# bootstrap.sh

Installs the slash commands in this repo into Claude and Cursor.

It symlinks `commands/` as `~/.claude/commands` and `~/.cursor/commands`. For example, `commands/plan/create.md` becomes `/plan:create`.

## Usage

```sh
./bootstrap.sh install
```

`install` is the only argument. Run with no argument, the script prints its usage.

## What it does

- Links `~/.claude/commands` and `~/.cursor/commands` to `commands/`. A link already pointing there is left as it is.
- Replaces a directory of per-entry links into `commands/` with the single directory link.
- Stops with an error when the target is a link to somewhere else, or a directory holding anything other than links into `commands/`.

Changes in `commands/` show up at once, because the link points at the repo.
