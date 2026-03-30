#!/usr/bin/env bash
#
# check-code-blocks.sh — Syntax-check fenced code blocks in markdown docs
#
# Checks:
#   bash, sh    → bash -n   (syntax only, no execution)
#   json        → jq empty  (parse validity)
#
# Cannot check (no runtime available):
#   powershell, yaml, csv
# Python is checked separately by check-python-blocks.py
#
# Usage:
#   ./scripts/check-code-blocks.sh                     # check all docs
#   ./scripts/check-code-blocks.sh path/to/file.md     # check one file

set -euo pipefail

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
BOLD=$'\033[1m'
NC=$'\033[0m'

errors=0
checked=0
skipped=0
declare -A lang_counts

inc() { local -n var="$1"; var=$(( var + 1 )); }

check_bash() {
    local file="$1" line="$2" block="$3"
    local tmpfile
    tmpfile=$(mktemp)

    # Replace <PLACEHOLDER> patterns with a dummy word so bash doesn't
    # parse angle brackets as redirections.
    local cleaned
    cleaned=$(printf '%s\n' "$block" | sed 's/<[A-Z_][A-Z_0-9]*>/PLACEHOLDER/g')
    printf '%s\n' "$cleaned" > "$tmpfile"

    local output
    if output=$(bash -n "$tmpfile" 2>&1); then
        inc checked
    else
        inc errors
        local pretty
        pretty=$(printf '%s\n' "$output" | sed "s|${tmpfile}|${file}|g")
        printf '%sFAIL%s %s:%s (bash)\n' "$RED" "$NC" "$file" "$line"
        printf '%s\n' "$pretty" | sed 's/^/  /'
        printf '  First lines:\n'
        printf '%s\n' "$block" | head -3 | sed 's/^/    /'
        local nlines
        nlines=$(printf '%s\n' "$block" | wc -l)
        if (( nlines > 3 )); then
            printf '    ... (%d lines total)\n' "$nlines"
        fi
        printf '\n'
    fi
    rm -f "$tmpfile"
}

check_json() {
    local file="$1" line="$2" block="$3"

    # Skip blocks containing ellipsis (truncated/abbreviated JSON)
    if printf '%s\n' "$block" | grep -qP '^\s*\.\.\.?\s*$|[,\[]\s*\.\.\.\s*$'; then
        inc skipped
        return 0
    fi

    local output
    if output=$(printf '%s\n' "$block" | jq empty 2>&1); then
        inc checked
    else
        inc errors
        printf '%sFAIL%s %s:%s (json)\n' "$RED" "$NC" "$file" "$line"
        printf '%s\n' "$output" | sed 's/^/  /'
        printf '  First lines:\n'
        printf '%s\n' "$block" | head -3 | sed 's/^/    /'
        local nlines
        nlines=$(printf '%s\n' "$block" | wc -l)
        if (( nlines > 3 )); then
            printf '    ... (%d lines total)\n' "$nlines"
        fi
        printf '\n'
    fi
}

process_file() {
    local file="$1"
    local in_block=false
    local lang=""
    local block_start=0
    local block=""
    local line_num=0

    while IFS= read -r line || [[ -n "$line" ]]; do
        line_num=$(( line_num + 1 ))

        if [[ "$in_block" == false ]]; then
            if [[ "$line" =~ ^\`\`\`([a-zA-Z]+) ]]; then
                lang="${BASH_REMATCH[1],,}"
                in_block=true
                block_start=$line_num
                block=""
            elif [[ "$line" =~ ^\`\`\`[[:space:]]*$ ]]; then
                in_block=true
                lang=""
                block_start=$line_num
                block=""
            fi
        else
            if [[ "$line" =~ ^\`\`\`[[:space:]]*$ ]]; then
                if [[ -n "$lang" ]]; then
                    lang_counts[$lang]=$(( ${lang_counts[$lang]:-0} + 1 ))

                    if [[ -n "$block" ]]; then
                        case "$lang" in
                            bash|sh)    check_bash "$file" "$block_start" "$block" ;;
                            json)       check_json "$file" "$block_start" "$block" ;;
                            *)          inc skipped ;;
                        esac
                    else
                        inc skipped
                    fi
                else
                    lang_counts[unlabeled]=$(( ${lang_counts[unlabeled]:-0} + 1 ))
                    inc skipped
                fi

                in_block=false
                lang=""
                block=""
            else
                if [[ -n "$block" ]]; then
                    block="$block"$'\n'"$line"
                else
                    block="$line"
                fi
            fi
        fi
    done < "$file"
}

# --- Main ---

target="${1:-content/docs}"
printf '%sChecking code blocks in: %s%s\n\n' "$BOLD" "$target" "$NC"

if [[ -f "$target" ]]; then
    process_file "$target"
else
    while IFS= read -r -d '' file; do
        process_file "$file"
    done < <(find "$target" -name '*.md' -print0 | sort -z)
fi

printf -- '---\n'
printf '%sResults:%s\n' "$BOLD" "$NC"
printf '  Checked: %s%d%s\n' "$GREEN" "$checked" "$NC"
printf '  Skipped: %s%d%s\n' "$YELLOW" "$skipped" "$NC"
printf '  Errors:  %s%d%s\n' "$RED" "$errors" "$NC"
printf '\n'

printf '%sBlocks by language:%s\n' "$BOLD" "$NC"
for lang in $(printf '%s\n' "${!lang_counts[@]}" | sort); do
    printf '  %-12s %d\n' "$lang" "${lang_counts[$lang]}"
done

if (( errors > 0 )); then
    exit 1
fi
