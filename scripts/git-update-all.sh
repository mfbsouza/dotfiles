#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: git-update-all.sh [-d MAXDEPTH] [-n] [-c] [ROOT]

Walks ROOT, finds git repositories, and fast-forwards each one to the latest
commit on its default branch.

  ROOT           Directory to walk (default: current directory)
  -d MAXDEPTH    How deep to look for repos (default: 1, i.e. ROOT's children)
  -n             Dry run: list what would be done, change nothing
  -c             Force color even when stdout is not a terminal (for | less -R)
  -h             Show this help

Output is colored when stdout is a terminal: green for repos that were updated,
yellow for skips, red for failures. Set NO_COLOR=1 to disable.

Repos with uncommitted changes are fetched but never modified.
Nothing is ever force-pushed, reset, or rewritten.
EOF
}

MAXDEPTH=1
DRY_RUN=0
FORCE_COLOR=0

while getopts ":d:nch" opt; do
    case "$opt" in
        d)
            MAXDEPTH="$OPTARG"
            if ! [[ "$MAXDEPTH" =~ ^[0-9]+$ ]]; then
                echo "error: -d expects a non-negative integer, got '$MAXDEPTH'" >&2
                exit 2
            fi
            ;;
        n) DRY_RUN=1 ;;
        c) FORCE_COLOR=1 ;;
        h) usage; exit 0 ;;
        \?) echo "error: unknown option -$OPTARG" >&2; usage >&2; exit 2 ;;
        :) echo "error: -$OPTARG requires an argument" >&2; exit 2 ;;
    esac
done
shift $((OPTIND - 1))

ROOT="${1:-.}"

if [ ! -d "$ROOT" ]; then
    echo "error: not a directory: $ROOT" >&2
    exit 2
fi

# -------------------------------------------------------------------- color ---

# Every color var is empty when color is off, so the printf call sites below
# need no conditionals. stdout and stderr are decided separately so that
# redirecting one does not leave stray escapes in the other.
want_color() { # fd
    # NO_COLOR is a user-level opt-out and outranks -c on purpose.
    [ -n "${NO_COLOR:-}" ] && return 1
    [ "$FORCE_COLOR" -eq 1 ] && return 0
    case "${TERM:-}" in
        ''|dumb) return 1 ;;
    esac
    [ -t "$1" ]
}

RED='' GREEN='' YELLOW='' BOLD='' RESET=''
if want_color 1; then
    RED=$'\033[31m' GREEN=$'\033[32m' YELLOW=$'\033[33m'
    BOLD=$'\033[1m' RESET=$'\033[0m'
fi

ERR_RED='' ERR_RESET=''
if want_color 2; then
    ERR_RED=$'\033[31m' ERR_RESET=$'\033[0m'
fi

# ---------------------------------------------------------------- discovery ---

# Match both .git dirs and .git files so linked worktrees are included.
# maxdepth is +1 because we search for .git, not the repo dir itself: -d 1
# then finds ROOT/.git and ROOT/child/.git.
repos=()
while IFS= read -r -d '' gitpath; do
    repos+=("$(dirname "$gitpath")")
done < <(
    find "$ROOT" -maxdepth "$((MAXDEPTH + 1))" \
        \( -name node_modules -o -name .venv -o -name vendor \) -prune -o \
        -name .git -print0 2>/dev/null | sort -z
)

# Drop repos nested inside an already-accepted repo (submodules, worktrees
# checked out inside their parent, .git internals).
# Note the ${arr[@]+"${arr[@]}"} guards: bash 3.2 (macOS) treats an empty
# array expansion as an unbound variable under `set -u`.
toplevel=()
for repo in ${repos[@]+"${repos[@]}"}; do
    nested=0
    for accepted in ${toplevel[@]+"${toplevel[@]}"}; do
        case "$repo" in
            "$accepted"/*) nested=1; break ;;
        esac
    done
    [ "$nested" -eq 0 ] && toplevel+=("$repo")
done

if [ ${#toplevel[@]} -eq 0 ]; then
    echo "No git repositories found under $ROOT (maxdepth $MAXDEPTH)."
    exit 0
fi

echo "Found ${#toplevel[@]} repo(s) under $ROOT"
[ "$DRY_RUN" -eq 1 ] && echo "(dry run - nothing will be changed)"
echo

# ------------------------------------------------------------------ helpers ---

# Is the working tree dirty, or is an operation half-finished?
is_dirty() {
    local dir="$1" gitdir
    [ -n "$(git -C "$dir" status --porcelain 2>/dev/null)" ] && return 0
    gitdir="$(git -C "$dir" rev-parse --git-dir 2>/dev/null)" || return 1
    # rev-parse may return a relative path
    case "$gitdir" in /*) ;; *) gitdir="$dir/$gitdir" ;; esac
    for marker in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD; do
        [ -e "$gitdir/$marker" ] && return 0
    done
    return 1
}

# Default branch name for a remote, without the remote/ prefix.
default_branch() {
    local dir="$1" remote="$2" ref
    ref="$(git -C "$dir" symbolic-ref --short "refs/remotes/$remote/HEAD" 2>/dev/null)" || ref=""
    if [ -z "$ref" ]; then
        # Not set on some clones - ask the remote and retry.
        git -C "$dir" remote set-head "$remote" --auto >/dev/null 2>&1 || true
        ref="$(git -C "$dir" symbolic-ref --short "refs/remotes/$remote/HEAD" 2>/dev/null)" || ref=""
    fi
    if [ -z "$ref" ]; then
        for candidate in main master; do
            if git -C "$dir" show-ref --verify --quiet "refs/remotes/$remote/$candidate"; then
                ref="$remote/$candidate"
                break
            fi
        done
    fi
    [ -z "$ref" ] && return 1
    echo "${ref#"$remote"/}"
}

# ---------------------------------------------------------------- main loop ---

names=()
cats=()
results=()
count_updated=0
count_current=0
count_skipped=0
count_failed=0

# record <name> <category> <message>
# category is one of: updated | current | skip | fail  (drives summary color)
record() {
    names+=("$1")
    cats+=("$2")
    results+=("$3")
}

for dir in "${toplevel[@]}"; do
    name="${dir#"$ROOT"/}"
    [ "$name" = "$ROOT" ] && name="$(basename "$dir")"
    printf '%s==> %s%s\n' "$BOLD" "$name" "$RESET"

    # Pick a remote: origin if it exists, else the first one.
    remote="$(git -C "$dir" remote 2>/dev/null | grep -x origin || git -C "$dir" remote 2>/dev/null | head -n 1)"
    if [ -z "$remote" ]; then
        printf '    %sno remote - skipping%s\n' "$YELLOW" "$RESET"
        record "$name" skip "SKIPPED (no remote)"
        count_skipped=$((count_skipped + 1))
        continue
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        branch="$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
        if is_dirty "$dir"; then
            printf '    %swould fetch %s, skip merge (dirty)%s\n' "$YELLOW" "$remote" "$RESET"
            record "$name" skip "would fetch only (dirty)"
        else
            echo "    would fetch $remote and fast-forward (currently on $branch)"
            record "$name" current "would update (on $branch)"
        fi
        continue
    fi

    # Dirty repos: refresh remote refs but leave the working tree alone.
    if is_dirty "$dir"; then
        printf '    %suncommitted changes or operation in progress - fetching only%s\n' "$YELLOW" "$RESET"
        if ! git -C "$dir" fetch --all --prune --tags --quiet; then
            printf '    %sfetch failed%s\n' "$ERR_RED" "$ERR_RESET" >&2
            record "$name" fail "FAILED (fetch)"
            count_failed=$((count_failed + 1))
            continue
        fi
        record "$name" skip "SKIPPED (dirty)"
        count_skipped=$((count_skipped + 1))
        continue
    fi

    echo "    fetching $remote"
    if ! git -C "$dir" fetch --all --prune --tags --quiet; then
        printf '    %sfetch failed%s\n' "$ERR_RED" "$ERR_RESET" >&2
        record "$name" fail "FAILED (fetch)"
        count_failed=$((count_failed + 1))
        continue
    fi

    if ! branch="$(default_branch "$dir" "$remote")"; then
        printf '    %scould not determine default branch - skipping%s\n' "$YELLOW" "$RESET"
        record "$name" skip "SKIPPED (no default branch)"
        count_skipped=$((count_skipped + 1))
        continue
    fi

    current="$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '')"
    if [ "$current" != "$branch" ]; then
        echo "    switching $current -> $branch"
        if ! checkout_err="$(git -C "$dir" checkout --quiet "$branch" 2>&1)"; then
            if printf '%s' "$checkout_err" | grep -qi 'used by worktree'; then
                printf '    %s%s is checked out in another worktree - skipping%s\n' "$YELLOW" "$branch" "$RESET"
                record "$name" skip "SKIPPED (branch in use by worktree)"
            else
                printf '    %scheckout failed: %s%s\n' "$ERR_RED" "$checkout_err" "$ERR_RESET" >&2
                record "$name" skip "SKIPPED (checkout failed)"
            fi
            count_skipped=$((count_skipped + 1))
            continue
        fi
    fi

    before="$(git -C "$dir" rev-parse --short HEAD)"
    if ! git -C "$dir" -c advice.diverging=false merge --ff-only --quiet "$remote/$branch" >/dev/null 2>&1; then
        printf '    %scannot fast-forward %s onto %s/%s (diverged) - skipping%s\n' \
            "$YELLOW" "$branch" "$remote" "$branch" "$RESET"
        record "$name" skip "SKIPPED (diverged)"
        count_skipped=$((count_skipped + 1))
        continue
    fi
    after="$(git -C "$dir" rev-parse --short HEAD)"

    if [ "$before" = "$after" ]; then
        echo "    already up to date ($branch @ $after)"
        record "$name" current "up to date ($branch)"
        count_current=$((count_current + 1))
    else
        printf '    %supdated %s %s -> %s%s\n' "$GREEN" "$branch" "$before" "$after" "$RESET"
        record "$name" updated "updated $branch $before -> $after"
        count_updated=$((count_updated + 1))
    fi
done

# ------------------------------------------------------------------ summary ---

echo
printf '%sSummary%s\n' "$BOLD" "$RESET"
width=0
for name in "${names[@]}"; do
    [ "${#name}" -gt "$width" ] && width="${#name}"
done
for i in "${!names[@]}"; do
    case "${cats[$i]}" in
        updated) color="$GREEN" ;;
        skip)    color="$YELLOW" ;;
        fail)    color="$RED" ;;
        *)       color='' ;;
    esac
    # Only the result column is colored: it is the last field and never
    # padded, so the %-*s byte-count padding on the name stays correct.
    printf '  %-*s  %s%s%s\n' "$width" "${names[$i]}" "$color" "${results[$i]}" "${color:+$RESET}"
done

if [ "$DRY_RUN" -eq 1 ]; then
    echo
    echo "${#names[@]} repo(s) inspected (dry run)."
    exit 0
fi

# Color a count only when non-zero, so a clean run has no red "0 failed".
tally() { # count label color
    if [ "$1" -gt 0 ] && [ -n "$3" ]; then
        printf '%s%s %s%s' "$3" "$1" "$2" "$RESET"
    else
        printf '%s %s' "$1" "$2"
    fi
}

echo
printf '%s, %s, %s, %s\n' \
    "$(tally "$count_updated" updated "$GREEN")" \
    "$(tally "$count_current" 'up to date' '')" \
    "$(tally "$count_skipped" skipped "$YELLOW")" \
    "$(tally "$count_failed" failed "$RED")"

[ "$count_failed" -gt 0 ] && exit 1
exit 0
