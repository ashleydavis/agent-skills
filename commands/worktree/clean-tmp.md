---
description: Remove every temporary worktree (branch or directory starting with `tmp-`), with its branch locally and on the remote. Pushes no commits.
---

# Remove the temporary worktrees

Temporary worktrees, such as the experiment worktrees made by `/issue:root-cause` and `/workflow:root-cause`, have a directory name and a branch that start with `tmp-`. They are thrown away, never merged.

Running this command is the human's go-ahead for these operations, on `tmp-` worktrees and branches only: `git worktree remove --force`, `git branch -D` and `git push <remote> --delete`. Nothing else. Never touch a worktree or branch whose name does not start with `tmp-`, and never the main worktree.

## Steps

1. If the session is inside a worktree (entered with `EnterWorktree`), leave it with `ExitWorktree` and `action: "keep"`, so git commands reach the main checkout.

2. Run `git worktree list --porcelain`. The temporary worktrees are the linked ones whose directory name or branch starts with `tmp-`. Show their paths and branches. When there are none, also list local branches starting with `tmp-` (`git branch --list 'tmp-*'`) and go on with those, since a worktree may already be gone and leave its branch behind.

3. For each temporary worktree, show `git -C <worktree-path> status --short` and `git -C <worktree-path> log --oneline <main-branch>..HEAD`, so the human can see what is being thrown away. Do not stop for it.

4. Remove each worktree: `git worktree remove --force <worktree-path>`. If git refuses, report its exact error and go on with the next.

5. Delete each local branch starting with `tmp-` that belonged to a removed worktree or was listed in step 2: `git branch -D <branch>`. If git refuses, report its exact error and go on.

6. For each of those branches, find the remote: its upstream, or else `origin`. When the repository has neither, say so and skip. Check with `git ls-remote <remote> refs/heads/<branch>`. When it is listed, run `git push <remote> --delete <branch>`, which deletes the branch and pushes no commit. When it is not listed, say so.

7. Run `git worktree prune`, then show `git worktree list` and `git branch --list 'tmp-*'` to prove they are gone. Report in one line each worktree, local branch and remote branch removed, and anything git refused.
