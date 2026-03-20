#!/usr/bin/env bash
#
# check-hl-commands.sh — Verify that `hl` CLI subcommands referenced in docs
#                        actually exist in the installed highlighter-sdk.
#
# Requires: python3, pip, highlighter-sdk (will install into a venv if needed)
#
# What it checks:
#   - Every `hl <subcommand>` referenced in bash code blocks exists
#   - Each subcommand's --help exits successfully
#
# Usage:
#   ./scripts/check-hl-commands.sh                     # check all docs
#   ./scripts/check-hl-commands.sh path/to/file.md     # check one file

set -euo pipefail

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
BOLD=$'\033[1m'
NC=$'\033[0m'

VENV_DIR=".venv-check"
target="${1:-content/docs}"

# --- Ensure hl is available ---

ensure_hl() {
    if command -v hl &>/dev/null; then
        printf '%s✓%s hl found: %s\n' "$GREEN" "$NC" "$(command -v hl)"
        return 0
    fi

    printf '%shl not on PATH, setting up venv...%s\n' "$YELLOW" "$NC"

    if ! command -v python3 &>/dev/null; then
        printf '%sERROR: python3 not found. Add it to flake.nix or install manually.%s\n' "$RED" "$NC"
        printf 'In flake.nix, change:\n'
        printf '  buildInputs = with pkgs;[ zola just ];\n'
        printf 'to:\n'
        printf '  buildInputs = with pkgs;[ zola just python3 ];\n'
        exit 1
    fi

    if [[ ! -d "$VENV_DIR" ]]; then
        python3 -m venv "$VENV_DIR"
    fi
    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

    if ! command -v hl &>/dev/null; then
        printf 'Installing highlighter-sdk...\n'
        pip install -q highlighter-sdk
    fi

    if ! command -v hl &>/dev/null; then
        printf '%sERROR: hl command not available after installing highlighter-sdk%s\n' "$RED" "$NC"
        exit 1
    fi

    printf '%s✓%s hl available via venv\n' "$GREEN" "$NC"
}

# --- Extract unique hl subcommands from markdown code blocks ---
# Output: one line per occurrence: "hl subcommand args\tfile:line"

extract_hl_commands() {
    local search_path="$1"
    local tmpfile
    tmpfile=$(mktemp)

    find "$search_path" -name '*.md' -print0 | sort -z | while IFS= read -r -d '' file; do
        local in_bash_block=false
        local line_num=0
        while IFS= read -r line; do
            line_num=$(( line_num + 1 ))

            if [[ "$in_bash_block" == false ]]; then
                if [[ "$line" =~ ^\`\`\`(bash|sh) ]]; then
                    in_bash_block=true
                fi
            else
                if [[ "$line" =~ ^\`\`\` ]]; then
                    in_bash_block=false
                elif [[ "$line" =~ ^[[:space:]]*(hl[[:space:]]+[a-z]) ]]; then
                    # Extract the subcommand path (words before any --flag or quoted arg)
                    local cmd
                    cmd=$(printf '%s' "$line" \
                        | sed 's/^[[:space:]]*//' \
                        | sed 's/#.*//' \
                        | sed 's/\\[[:space:]]*$//' \
                        | awk '{
                            for (i=1; i<=NF; i++) {
                                if ($i ~ /^-/ || $i ~ /^"/ || $i ~ /^[0-9]/ || $i ~ /^</ || $i ~ /^\$/ || $i ~ /^\[/ || $i ~ /^\|/ || $i ~ /[\/\.A-Z]/) break
                                printf "%s ", $i
                            }
                            printf "\n"
                        }' \
                        | sed 's/[[:space:]]*$//')
                    if [[ -n "$cmd" ]]; then
                        printf '%s\t%s:%d\n' "$cmd" "$file" "$line_num"
                    fi
                fi
            fi
        done < "$file"
    done > "$tmpfile"

    cat "$tmpfile"
    rm -f "$tmpfile"
}

# --- Run a command safely by splitting into an array ---

run_hl_help() {
    local cmd="$1"
    # Validate: must start with "hl " and contain only lowercase, digits, spaces, hyphens
    if [[ ! "$cmd" =~ ^hl( +[a-z][a-z0-9-]*)+$ ]] && [[ "$cmd" != "hl" ]]; then
        printf '  %sSKIP%s %s (unexpected format)\n' "$YELLOW" "$NC" "$cmd"
        return 1
    fi
    # Split into array on spaces
    local -a args
    read -ra args <<< "$cmd"
    "${args[@]}" --help &>/dev/null
}

# --- Main ---

printf '%sChecking hl commands in: %s%s\n\n' "$BOLD" "$target" "$NC"

ensure_hl
printf '\n'

# Collect unique subcommands and their locations
declare -A cmd_locations
declare -A cmd_seen

while IFS=$'\t' read -r cmd location; do
    [[ -z "$cmd" ]] && continue
    cmd_seen[$cmd]=1
    if [[ -n "${cmd_locations[$cmd]:-}" ]]; then
        cmd_locations[$cmd]="${cmd_locations[$cmd]}, ${location}"
    else
        cmd_locations[$cmd]="$location"
    fi
done < <(extract_hl_commands "$target")

total=${#cmd_seen[@]}
if (( total == 0 )); then
    printf 'No hl commands found.\n'
    exit 0
fi

printf '%sFound %d unique hl subcommands to check:%s\n\n' "$BOLD" "$total" "$NC"

errors=0
passed=0

while IFS= read -r cmd; do
    if run_hl_help "$cmd"; then
        printf '  %s✓%s %s\n' "$GREEN" "$NC" "$cmd"
        passed=$(( passed + 1 ))
    else
        printf '  %s✗%s %s\n' "$RED" "$NC" "$cmd"
        printf '    referenced in: %s\n' "${cmd_locations[$cmd]:-unknown}"
        errors=$(( errors + 1 ))
    fi
done < <(printf '%s\n' "${!cmd_seen[@]}" | sort)

printf '\n---\n'
printf '%sResults:%s\n' "$BOLD" "$NC"
printf '  Passed: %s%d%s\n' "$GREEN" "$passed" "$NC"
printf '  Failed: %s%d%s\n' "$RED" "$errors" "$NC"

if (( errors > 0 )); then
    exit 1
fi
