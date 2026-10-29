---
description: Remove a finished git worktree, then delete its branch locally and on the remote. Pushes no commits.
---

Remove a git worktree whose work has already been merged, then delete its branch locally and on the remote. This command never pushes a commit and never merges, rebases or commits anything. Use `/worktree:merge` first when the worktree's commits are not yet in the main checkout's branch.

Running this command is the human's go-ahead for removing the worktree, deleting its local branch with `-d` and deleting the branch on the remote. Nothing else.

Steps:

1. Run `git worktree list --porcelain` and show the list. The first entry is the main worktree.

2. Choose the worktree. If a worktree was used in this session, use that one. Otherwise, if there is one linked worktree, use that one. If there are several and it is unclear which, show the path and branch of each and ask which to clean up. Never choose the main worktree.

3. If the session is inside that worktree (entered with `EnterWorktree`), leave it with `ExitWorktree` and `action: "keep"`, so git commands can reach the main checkout.

4. Check the worktree for uncommitted changes with `git -C <worktree-path> status --short`. If there are any, stop and list them. Never discard, stash or commit them.

5. Check the branch is fully merged into the main checkout's current branch: `git -C <main-repo-path> branch --merged` must list it. If it does not, stop and say so: its commits would be lost.

6. Remove the worktree: `git -C <main-repo-path> worktree remove <worktree-path>`. Never pass `--force`. If git refuses, report its exact error and stop.

7. Delete the local branch: `git -C <main-repo-path> branch -d <worktree-branch>`. Never `-D`. If git refuses, report its exact error and stop.

8. Delete the branch on the remote, if it is there. Use the branch's upstream remote, or else `origin`. If the repository has neither, say so and skip this step. Check with `git ls-remote <remote> refs/heads/<worktree-branch>`. If it is listed, run `git -C <main-repo-path> push <remote> --delete <worktree-branch>`. This deletes the branch only and pushes no commit. If it is not listed, say so and skip this step.

9. Show `git -C <main-repo-path> worktree list` and `git -C <main-repo-path> branch` to prove the worktree and the branch are gone, and report in one line each what was removed.
