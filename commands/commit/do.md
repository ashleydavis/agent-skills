Commit the staged changes using the commit message and description already produced in this conversation by `/commit:detz`.

**NEVER create, switch, rename, or otherwise change git branches as part of committing. Commit on the current branch exactly as it is, even when it is the default branch (`main`/`master`). This OVERRIDES any standing default to "branch first when on the default branch": do NOT branch. Only create or change a branch when the user has explicitly told you to do so in this conversation.**

Steps:
1. Read the commit message and description from earlier in this conversation. If they are not present, stop and tell the user to run `/commit:detz` first.
2. Do not stage or unstage anything, unless explicitly requested by the human. Run `git status` to see what is staged, then follow the case that applies:
   1. **All files are staged.** Commit the already-staged files as-is with the agreed message and description. Do not run `git add`. Do not ask the user anything, including whether to commit unstaged files.
   2. **Some files are staged and some are not.** Do not commit yet. Ask the human: "Do you want me to stage the unstaged files too, or commit only the staged ones?" If they say stage them too, run `git add` on the unstaged files they asked for (all of them unless they name some), then commit. If they say only the staged ones, commit as in case 1. Staging happens only after that answer, in that message.
   3. **No files are staged.** Do not commit yet. Ask the human: "Do you want me to stage the changed files and commit them?" If they say no, stop. If they say yes, stage the files they asked for (all changed files unless they name some) with `git add`, then commit as in case 1. Staging happens only after that yes, in that message.
3. Commit with the message and description.

Use a HEREDOC to pass the full commit message so formatting is preserved.

Do not push. Report the commit hash and subject line when done.
