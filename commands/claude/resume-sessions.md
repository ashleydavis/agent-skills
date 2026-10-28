---
description: List the Claude sessions that ran in the current directory, its subdirectories and its worktrees in the last X hours, with the command to resume each.
argument-hint: [hours, default 1]
---

List the Claude sessions that ran under the current directory in the last X hours and print the command to resume each one. Listing only: change nothing and write no file.

## Steps

1. **Get X.** X is the number of hours given after the command (`/claude:resume-sessions 8`). If none was given, X is 1.

2. **Find the sessions.** First tell the human in one line what you are searching: "Searching for sessions under `<current directory>`, its subdirectories and worktrees, active in the last X hours." Then run this from the current directory with `HOURS` set to X. It reads session transcripts under `~/.claude/projects/` and only reads them. Running this command is the human's permission to do that.

   ```sh
   HOURS=<X>; root=$(pwd -P)
   find ~/.claude/projects -mindepth 2 -maxdepth 2 -name '*.jsonl' -mmin -$((HOURS * 60)) | while read -r f; do
     cwd=$(grep -m1 -o '"cwd":"[^"]*"' "$f" | cut -d'"' -f4)
     [ -n "$cwd" ] || continue
     keep=
     case "$cwd/" in "$root"/*) keep=1 ;; esac
     if [ -z "$keep" ] && [ -d "$cwd" ]; then
       common=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
       case "$common/" in "$root"/*) keep=1 ;; esac
     fi
     [ -n "$keep" ] || continue
     worktrees=$(grep -o '"cwd":"[^"]*"' "$f" | cut -d'"' -f4 | sort -u | while read -r d; do
       [ -d "$d" ] || continue
       gitdir=$(git -C "$d" rev-parse --path-format=absolute --git-dir 2>/dev/null) || continue
       [ "$gitdir" != "$(git -C "$d" rev-parse --path-format=absolute --git-common-dir)" ] && git -C "$d" rev-parse --show-toplevel
     done | sort -u | paste -sd, -)
     name=$(grep -o '"customTitle":"[^"]*"' "$f" | tail -1 | cut -d'"' -f4)
     printf '%s\t%s\t%s\t%s\t%s\n' "$(stat -c %Y "$f")" "$cwd" "$(basename "$f" .jsonl)" "${name:-unnamed}" "${worktrees:--}"
   done | sort -k2,2 -k1,1nr | while IFS="$(printf '\t')" read -r t cwd id name worktrees; do
     printf '%s | %s | %s | %s | %s\n' "$(date -d @"$t" '+%F %H:%M')" "$cwd" "$name" "$id" "$worktrees"
   done
   ```

   Each line is: last active, working directory, name, UUID, worktrees.

   - The working directory is the one the session started in. `claude --resume` finds the session only from there.
   - A session counts when its working directory is the current directory or under it, or is a git worktree whose repository is under it. That covers worktrees kept outside the tree.
   - The name is the one set with `/rename`, or `unnamed` if none was set.
   - Worktrees are every git worktree the session worked in, comma separated, or `-` for none. A worktree that has since been deleted is not listed.
   - "In the last X hours" means the transcript changed in that time.

3. **Print the result.** One section per session, in the order the script gives, with a blank line between each line shown here so they render as separate lines:

   ````
   ### <name>

   Last active: <HH:MM>

   Directory: `<directory>`

   Worktrees: none

   ```
   claude --resume <uuid>
   ```
   ````

   - Leave a blank line between one session's code block and the next session's heading.
   - Add " (this session)" to the heading of the current session.
   - Show the date before the time only when it is not today.
   - Write paths relative to the current directory, which itself is `./`.
   - When the session used worktrees, write `Worktrees:` followed by a list with one path per line instead of `none`.
   - The code block must not sit inside a list, so copying it gets only the command.
   - Write the resume command bare: no `mise exec --` and no `cd` in front.
   - If nothing was found, say so in one line, naming X.
   - End with one line saying how to search further back: "To search more hours, run `/claude:resume-sessions <hours>`."
   - Add nothing else: no summary and no advice on which session to resume.
