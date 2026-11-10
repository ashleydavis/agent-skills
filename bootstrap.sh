#!/usr/bin/env bash

#
# Symlinks this repo's commands/ directory as ~/.claude/commands and ~/.cursor/commands, so the
# slash commands show up in Claude and Cursor (commands/plan/create.md becomes /plan:create).
#
# Usage: ./bootstrap.sh install
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#
# Prints how to run the script.
#
print_usage() {
    echo "Usage: $0 install"
    echo ""
    echo "Symlinks $SCRIPT_DIR/commands as ~/.claude/commands and ~/.cursor/commands."
}

#
# Removes a directory left by the older per-entry install, so the whole-directory link can take
# its place. Only links into this repo's commands/ are removed. Anything else in the directory
# stops the script, because removing it would lose a file or another package's command.
#
remove_per_entry_links() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || { echo "ERROR: $target_dir is not a directory." >&2; exit 1; }

    local path
    shopt -s nullglob dotglob
    for path in "$target_dir"/*; do
        if [[ -L "$path" ]]; then
            if [[ "$(readlink "$path")" != "$SCRIPT_DIR/commands/"* ]]; then
                echo "ERROR: $path links to $(readlink "$path"), outside this repo." >&2
                echo "       Move it out of $target_dir, then run this script again." >&2
                exit 1
            fi
        else
            echo "ERROR: $path is not a link into this repo." >&2
            echo "       Move it out of $target_dir, then run this script again." >&2
            exit 1
        fi
    done

    for path in "$target_dir"/*; do
        rm "$path"
        echo "  removed old link $path"
    done
    shopt -u nullglob dotglob

    rmdir "$target_dir"
}

#
# Links one tool's commands directory to this repo's commands/. A link already pointing there is
# left alone. A link to anywhere else stops the script.
#
install_commands() {
    local target_dir="$1"
    local source_dir="$SCRIPT_DIR/commands"

    [[ -d "$source_dir" ]] || { echo "ERROR: $source_dir is not a directory." >&2; exit 1; }

    echo "Linking $target_dir ..."

    if [[ -L "$target_dir" ]]; then
        if [[ "$(readlink "$target_dir")" == "$source_dir" ]]; then
            echo "  already linked $target_dir"
            return
        else
            echo "ERROR: $target_dir is a link to $(readlink "$target_dir"), not to $source_dir." >&2
            echo "       Remove it, then run this script again." >&2
            exit 1
        fi
    fi

    if [[ -e "$target_dir" ]]; then
        remove_per_entry_links "$target_dir"
    fi

    mkdir -p "$(dirname "$target_dir")"
    ln -s "$source_dir" "$target_dir"
    echo "  linked $target_dir -> $source_dir"

    [[ -L "$target_dir" ]] || { echo "ERROR: $target_dir was not linked." >&2; exit 1; }
}

if [[ $# -ne 1 ]]; then
    print_usage
    exit 1
fi

if [[ "$1" != "install" ]]; then
    echo "ERROR: Unknown command '$1'." >&2
    print_usage
    exit 1
fi

install_commands "$HOME/.claude/commands"
install_commands "$HOME/.cursor/commands"

echo "Done."
