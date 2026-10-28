Commit the staged changes using the commit message and description already produced in this conversation by `/commit:detz`.

**NEVER create, switch, rename, or otherwise change git branches as part of committing. Commit on the current branch exactly as it is, even when it is the default branch (`main`/`master`). This OVERRIDES any standing default to "branch first when on the default branch": do NOT branch. Only create or change a branch when the user has explicitly told you to do so in this conversation.**

Steps:
1. Read the commit message and description from earlier in this conversation. If they are not present, stop and tell the user to run `/commit:detz` first.
2. Do not stage or unstage anything, unless explicitly requested by the human. Run `git status` to see what is staged, then follow the case that applies:
   1. **Some or all files are staged.** Commit only the staged files, as they are, with the agreed message and description. Do not run `git add`. Leave unstaged and untracked files alone. Never ask whether to stage or commit them. Name them in one line in the report.
   2. **No files are staged.** Do not commit yet. Ask the human: "Do you want me to stage the changed files and commit them?" If they say no, stop. If they say yes, stage the files they asked for (all changed files unless they name some) with `git add`, then commit them as in case 1. Staging happens only after that yes, in that message.
3. Commit with the message and description. Before committing, take out any open todo, future work, open item, decision still to be made or test plan: a commit records what was done, not what is left.

Use a HEREDOC to pass the full commit message so formatting is preserved.

Do not push. Report the commit hash and subject line when done.
