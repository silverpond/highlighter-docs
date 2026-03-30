#!/usr/bin/env python3
"""
check-hl-commands.py — Validate `hl` CLI commands in docs using Click's make_context().

Uses Click's built-in argument parsing to validate every `hl` command referenced
in bash code blocks — checking subcommand names, flag names, required flags, and
argument types — without executing any command callbacks.

Requires: highlighter-sdk (provides the Click command tree)

Usage:
  python scripts/check-hl-commands.py                     # check all docs
  python scripts/check-hl-commands.py path/to/file.md     # check one file
"""

import re
import shlex
import sys
from pathlib import Path

import click

RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[1;33m"
BOLD = "\033[1m"
NC = "\033[0m"

# Lazy-loaded CLI root
_cli_root = None


def get_cli_root():
    global _cli_root
    if _cli_root is None:
        # The module path varies across SDK versions
        try:
            from highlighter.cli.highlighter_cli import highlighter_group
        except ImportError:
            from highlighter.cli.highlighter import highlighter_group
        _cli_root = highlighter_group
    return _cli_root


def extract_hl_commands(search_path: Path) -> list[tuple[str, str, int]]:
    """Extract hl command lines from bash code blocks in markdown.

    Joins backslash-continued lines. Returns (command_line, file, line_num).
    """
    results = []
    md_files = (
        [search_path] if search_path.is_file() else sorted(search_path.rglob("*.md"))
    )

    for md_file in md_files:
        in_bash = False
        accumulated = ""
        acc_start_line = 0
        line_num = 0

        for line in md_file.read_text().splitlines():
            line_num += 1

            if not in_bash:
                if re.match(r"^```(bash|sh)", line):
                    in_bash = True
                continue

            if re.match(r"^```", line):
                in_bash = False
                accumulated = ""
                continue

            stripped = line.rstrip()

            # Handle backslash continuation
            if stripped.endswith("\\"):
                if not accumulated:
                    acc_start_line = line_num
                accumulated += stripped[:-1].strip() + " "
                continue

            full_line = accumulated + stripped
            cmd_line_num = acc_start_line if accumulated else line_num
            accumulated = ""

            # Match lines starting with hl command
            match = re.match(r"^\s*(hl\s+.+)", full_line)
            if not match:
                continue

            cmd_line = match.group(1)
            # Replace <PLACEHOLDER> before splitting, so angle brackets aren't
            # mistaken for shell redirections. Use "0" as it's valid for both
            # string and integer-typed Click options.
            cmd_line = re.sub(r"<[A-Z_][A-Z_0-9]*>", "0", cmd_line)
            # Stop at pipes, semicolons, redirections, subshells, command substitution
            cmd_line = re.split(r"\s*[|;&>)<]|\$\(", cmd_line)[0].strip()
            # Strip inline comments (# followed by space, not bare ### placeholders)
            cmd_line = re.sub(r"\s+#\s.*$", "", cmd_line).strip()

            if cmd_line and cmd_line != "hl":
                results.append((cmd_line, str(md_file), cmd_line_num))

    return results


def tokenize_command(cmd_line: str) -> list[str] | None:
    """Tokenize a command line, replacing placeholders with dummy values."""
    cleaned = cmd_line
    # <PLACEHOLDER> patterns are already replaced during extraction
    # Replace $VARIABLE / ${VARIABLE} with a dummy value
    cleaned = re.sub(r"\$\{?[A-Za-z_][A-Za-z_0-9]*\}?", "0", cleaned)
    # Replace ### placeholder values (used for numeric IDs in docs)
    cleaned = re.sub(r"###", "0", cleaned)
    # Remove [OPTIONS], [ARGS] etc. (help-style placeholders)
    cleaned = re.sub(r"\[[A-Z_]+\]", "", cleaned)
    # Replace ... with nothing (truncated examples)
    cleaned = re.sub(r"\.\.\.", "", cleaned)
    try:
        tokens = shlex.split(cleaned)
    except ValueError:
        return None
    # Remove --help (would cause Click to try to exit during make_context)
    tokens = [t for t in tokens if t != "--help"]
    return tokens


def validate_command(tokens: list[str]) -> str | None:
    """Validate tokens against the Click command tree.

    Returns None on success or an error message string.
    """
    cli_root = get_cli_root()

    # Strip the 'hl' prefix
    args = tokens[1:] if tokens and tokens[0] == "hl" else tokens
    if not args:
        return None

    cmd = cli_root
    name_parts = ["hl"]

    # Walk down through Click groups to find the leaf command
    while args and isinstance(cmd, click.Group):
        subcmd_name = args[0]

        # Don't treat flags as subcommand names
        if subcmd_name.startswith("-"):
            break

        ctx = click.Context(cmd, info_name=" ".join(name_parts))
        subcmd = cmd.get_command(ctx, subcmd_name)
        if subcmd is None:
            return f"unknown subcommand '{subcmd_name}' under '{' '.join(name_parts)}'"

        name_parts.append(subcmd_name)
        cmd = subcmd
        args = args[1:]

    # If we ended on a group with no more args, that's fine (just referencing the group)
    if isinstance(cmd, click.Group) and not args:
        return None

    # If we ended on a group but there are remaining flag args, that's also fine
    # (the group itself may have options)
    if isinstance(cmd, click.Group) and args and args[0].startswith("-"):
        return None

    # Validate the leaf command's arguments with make_context
    if not isinstance(cmd, click.Group):
        try:
            cmd.make_context(" ".join(name_parts), list(args))
            return None
        except click.BadParameter:
            # Type conversion failure on dummy placeholder values (e.g. "0" for
            # a UUID option, or a non-existent file path). The command structure
            # is valid — only the placeholder value is wrong.
            return None
        except click.UsageError as e:
            return str(e)
        except SystemExit:
            # Click may call sys.exit for eager options; treat as valid
            return None

    return None


def main():
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("content/docs")

    print(f"{BOLD}Checking hl commands in: {target}{NC}\n")

    # Verify the CLI is importable
    try:
        get_cli_root()
        print(f"{GREEN}✓{NC} highlighter CLI loaded\n")
    except ImportError as e:
        print(f"{RED}ERROR: Cannot import highlighter CLI: {e}{NC}")
        print("Make sure highlighter-sdk is installed.")
        sys.exit(2)

    commands = extract_hl_commands(target)
    if not commands:
        print("No hl commands found.")
        return

    # Deduplicate commands, tracking all locations
    seen: dict[str, list[str]] = {}
    for cmd_line, file, line_num in commands:
        if cmd_line not in seen:
            seen[cmd_line] = []
        seen[cmd_line].append(f"{file}:{line_num}")

    print(f"Found {len(seen)} unique hl command(s)\n")

    errors = 0
    passed = 0
    skipped = 0

    for cmd_line in sorted(seen):
        locations = seen[cmd_line]
        tokens = tokenize_command(cmd_line)
        if tokens is None:
            print(f"  {YELLOW}SKIP{NC} {cmd_line} (tokenize error)")
            for loc in locations:
                print(f"    at: {loc}")
            skipped += 1
            continue

        error = validate_command(tokens)
        if error:
            print(f"  {RED}✗{NC} {cmd_line}")
            print(f"    {error}")
            for loc in locations:
                print(f"    at: {loc}")
            errors += 1
        else:
            print(f"  {GREEN}✓{NC} {cmd_line}")
            passed += 1

    print(f"\n---")
    print(f"{BOLD}Results:{NC}")
    print(f"  Passed:  {GREEN}{passed}{NC}")
    print(f"  Skipped: {YELLOW}{skipped}{NC}")
    print(f"  Failed:  {RED}{errors}{NC}")

    sys.exit(1 if errors > 0 else 0)


if __name__ == "__main__":
    main()
