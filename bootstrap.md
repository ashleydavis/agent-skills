# bootstrap.sh

Installs the slash commands in this repo into Claude and Cursor.

It symlinks each entry in `commands/` into `~/.claude/commands` and `~/.cursor/commands`. For example, `commands/plan/create.md` becomes `/plan:create`.

Each entry gets its own link, so commands from other packages can sit in the same directory.

## Usage

```sh
./bootstrap.sh install
```

`install` is the only argument. Run with no argument, the script prints its usage.

## What it does

- Creates `~/.claude/commands` and `~/.cursor/commands` if they are missing. Each has to be a real directory, so the script stops if either is a link.
- Removes links that point into this repo at an entry that has since been deleted or renamed.
- Links each entry in `commands/`. An entry already linked to the same place is left as it is.
- Stops with an error when a name is already taken by a file or by a link to somewhere else, so it overwrites no other package's command.

Run it again after adding, renaming or removing a top-level entry in `commands/`. Changes inside an entry show up at once, because the link points at the repo.
