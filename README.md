# agent-skills

Personal slash commands for Claude and Cursor.

## Install

[`skl`](https://github.com/ashleydavis/skilled) installs Cursor and Claude skill packages from git.

After team packages (see [skill-config](https://github.com/ArkoseLabs/skill-config)):

```sh
skl -g add ashleydavis/agent-skills --ns me
```

**This repo only:**

```sh
skl init -g
skl -g add ashleydavis/agent-skills --ns me
```

Skills and commands then show up in Cursor and Claude under `me`. For example, in Claude, type `/me:huh` or `/me:plan:create`.

## Layout

```
├── skills/                 # Cursor and Claude skills
│   └── ...                 # one subdirectory per skill
│       └── SKILL.md
└── commands/               # slash commands
    └── ...                 # nested dirs; other files are for commands to read
        └── *.md            # plan/create → /me:plan:create
```

