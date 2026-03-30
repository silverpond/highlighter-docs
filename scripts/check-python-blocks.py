#!/usr/bin/env python3
"""
check-python-blocks.py — Validate Python code blocks in markdown docs using pyright.

Checks:
  - Syntax errors
  - Missing/wrong imports (reportMissingImports)
  - Undefined variables (reportUndefinedVariable)
  - Basic type checking (typeCheckingMode: basic)

Requires: pyright, highlighter-sdk (for import resolution)

Usage:
  python scripts/check-python-blocks.py                     # check all docs
  python scripts/check-python-blocks.py path/to/file.md     # check one file
"""

import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[1;33m"
BOLD = "\033[1m"
NC = "\033[0m"


def extract_python_blocks(search_path: Path):
    """Extract fenced ```python blocks from markdown files."""
    blocks = []
    md_files = (
        [search_path] if search_path.is_file() else sorted(search_path.rglob("*.md"))
    )

    for md_file in md_files:
        in_python = False
        block_start = 0
        block_lines: list[str] = []
        line_num = 0

        for line in md_file.read_text().splitlines():
            line_num += 1
            if not in_python:
                if re.match(r"^```python", line):
                    in_python = True
                    block_start = line_num
                    block_lines = []
            else:
                if re.match(r"^```\s*$", line):
                    if block_lines:
                        blocks.append(
                            {
                                "source": "\n".join(block_lines),
                                "file": str(md_file),
                                "line": block_start,
                            }
                        )
                    in_python = False
                else:
                    block_lines.append(line)

    return blocks


def run_pyright(blocks: list[dict], repo_root: str) -> list[dict]:
    """Write blocks to temp files, run pyright, return diagnostics."""
    with tempfile.TemporaryDirectory() as tmpdir:
        # Pyright config: basic type checking, import validation, no stub noise
        config: dict = {
            "include": ["."],
            "typeCheckingMode": "basic",
            "reportMissingImports": "error",
            "reportUndefinedVariable": "error",
            "reportMissingTypeStubs": "none",
            "reportMissingModuleSource": "none",
        }

        # Point pyright at the current Python (provided by nix develop)
        config["pythonPath"] = sys.executable

        (Path(tmpdir) / "pyrightconfig.json").write_text(json.dumps(config))

        # Map temp filenames → source locations
        file_map: dict[str, dict] = {}
        for i, block in enumerate(blocks):
            filename = f"block_{i}.py"
            (Path(tmpdir) / filename).write_text(block["source"])
            file_map[filename] = block

        result = subprocess.run(
            ["pyright", "--outputjson"],
            capture_output=True,
            text=True,
            cwd=tmpdir,
        )

        try:
            output = json.loads(result.stdout)
        except json.JSONDecodeError:
            print(f"{RED}Failed to parse pyright output{NC}")
            if result.stderr:
                print(result.stderr)
            if result.stdout:
                print(result.stdout[:500])
            sys.exit(2)

        diagnostics = []
        for diag in output.get("generalDiagnostics", []):
            if diag.get("severity") != "error":
                continue
            filepath = diag.get("file", "")
            filename = Path(filepath).name
            if filename not in file_map:
                continue
            block = file_map[filename]
            diag_line = diag.get("range", {}).get("start", {}).get("line", 0)
            diagnostics.append(
                {
                    "file": block["file"],
                    "block_line": block["line"],
                    "diag_line": block["line"] + diag_line + 1,
                    "message": diag.get("message", ""),
                    "rule": diag.get("rule", ""),
                    "block_index": int(filename.split("_")[1].split(".")[0]),
                }
            )

        return diagnostics


def main():
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("content/docs")

    print(f"{BOLD}Checking Python blocks in: {target}{NC}\n")

    blocks = extract_python_blocks(target)
    if not blocks:
        print("No Python blocks found.")
        return

    print(f"Found {len(blocks)} Python block(s)\n")

    repo_root = os.getcwd()
    diagnostics = run_pyright(blocks, repo_root)

    # Group diagnostics by block
    error_blocks: set[int] = set()
    for diag in diagnostics:
        error_blocks.add(diag["block_index"])
        rule = f" ({diag['rule']})" if diag["rule"] else ""
        print(f"{RED}FAIL{NC} {diag['file']}:{diag['diag_line']}{rule}")
        print(f"  {diag['message']}")

    # Print results for passing blocks
    for i, block in enumerate(blocks):
        if i not in error_blocks:
            # Show just filename:line for passing blocks
            rel = os.path.relpath(block["file"])
            print(f"{GREEN}  OK{NC} {rel}:{block['line']}")

    passed = len(blocks) - len(error_blocks)
    failed = len(error_blocks)
    print(f"\n---")
    print(f"{BOLD}Results:{NC}")
    print(f"  Checked: {len(blocks)}")
    print(f"  Passed:  {GREEN}{passed}{NC}")
    print(f"  Failed:  {RED}{failed}{NC}")

    sys.exit(1 if failed > 0 else 0)


if __name__ == "__main__":
    main()
