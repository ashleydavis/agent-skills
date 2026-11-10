# agent-skills

Personal slash commands for Claude and Cursor.

## Install

```sh
./bootstrap.sh install
```

This symlinks `commands/` as `~/.claude/commands` and `~/.cursor/commands`. For example, in Claude, type `/huh` or `/plan:create`. See [bootstrap.md](bootstrap.md).

Some commands read rule files from [agent-config](https://github.com/ashleydavis/agent-config) and assume it is checked out at `~/agent-config`.

## Layout

```
└── commands/               # slash commands
    └── ...                 # nested dirs; other files are for commands to read
        └── *.md            # plan/create → /plan:create
```
