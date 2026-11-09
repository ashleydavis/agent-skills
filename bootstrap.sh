#!/usr/bin/env bash

#
# Symlinks every entry in this repo's commands/ directory into ~/.claude/commands and
# ~/.cursor/commands, so the slash commands show up in Claude and Cursor
# (commands/plan/create.md becomes /plan:create).
#
# Each entry gets its own link, rather than one link for the whole commands/ directory, so
# commands from other packages can sit beside them in the same directory.
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
    echo "Symlinks each entry in $SCRIPT_DIR/commands into ~/.claude/commands and ~/.cursor/commands."
}

#
# Removes links in the target directory that point into this repo at an entry that no longer
# exists, so a command deleted or renamed here also disappears from Claude and Cursor. Links
# that point anywhere else belong to other packages and are left as they are.
#
remove_stale_links() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || { echo "ERROR: $target_dir is not a directory." >&2; exit 1; }

    local path
    shopt -s nullglob
    for path in "$target_dir"/*; do
        if [[ -L "$path" ]]; then
            local link_target
            link_target="$(readlink "$path")"
            if [[ "$link_target" == "$SCRIPT_DIR"/* ]]; then
                if [[ ! -e "$path" ]]; then
                    echo "  removing stale link $path (-> $link_target)"
                    rm "$path"
                fi
            fi
        fi
    done
    shopt -u nullglob
}

#
# Links each entry of the source directory into the target directory. An entry already linked
# to the same place is left alone. Anything else already at that name stops the script, because
# overwriting it would lose a file or break another package's command.
#
link_entries() {
    local source_dir="$1"
    local target_dir="$2"

    [[ -d "$source_dir" ]] || { echo "ERROR: $source_dir is not a directory." >&2; exit 1; }
    [[ -d "$target_dir" ]] || { echo "ERROR: $target_dir is not a directory." >&2; exit 1; }

    local source_path
    shopt -s nullglob
    for source_path in "$source_dir"/*; do
        local name
        name="$(basename "$source_path")"
        local target_path="$target_dir/$name"

        if [[ -L "$target_path" ]]; then
            if [[ "$(readlink "$target_path")" == "$source_path" ]]; then
                echo "  already linked $target_path"
            else
                echo "ERROR: $target_path is a link to $(readlink "$target_path"), not to $source_path." >&2
                echo "       Remove it, then run this script again." >&2
                exit 1
            fi
        else
            if [[ -e "$target_path" ]]; then
                echo "ERROR: $target_path already exists and is not a link." >&2
                echo "       Move it out of the way, then run this script again." >&2
                exit 1
            else
                ln -s "$source_path" "$target_path"
                echo "  linked $target_path -> $source_path"
            fi
        fi

        [[ -L "$target_path" ]] || { echo "ERROR: $target_path was not linked." >&2; exit 1; }
    done
    shopt -u nullglob
}

#
# Prepares one tool's commands directory and links the commands into it. The directory has to
# be a real directory: if it were a link into this repo, Claude or Cursor would write into the
# repo through it.
#
install_commands() {
    local target_dir="$1"

    if [[ -L "$target_dir" ]]; then
        echo "ERROR: $target_dir is a link to $(readlink "$target_dir"). It has to be a real directory." >&2
        echo "       Remove the link, then run this script again." >&2
        exit 1
    fi

    mkdir -p "$target_dir"

    echo "Linking commands into $target_dir ..."
    remove_stale_links "$target_dir"
    link_entries "$SCRIPT_DIR/commands" "$target_dir"
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
