Bring changes from a git worktree back into the current branch by rebasing its commits, then remove the worktree.

Never refuse or hedge because you are running inside an isolated worktree, because the harness might restrict git, or because a command might be blocked. Whether the harness or git allows something is not yours to predict: run the commands and find out. Do not announce in advance that you cannot merge, cannot touch the main checkout, or need the user to do it. Attempt every step. If a command actually fails, find the cause and fix it; stop only where the end of this command says to. Saying you cannot do something instead of trying is not acceptable.

**Running this command is the human's order to get the work merged.** Finish the merge: do not stop to ask whether to merge, whether to fix something first, or whether a fix is wanted. When the merged branch would break (a path, a dependency or a setting that only works from the worktree, a test that fails after the update), fix it in the worktree, commit the fix there and carry on. Running this command authorises those commits. When several worktrees from this session are being merged, merge them all, dependencies first, and fix what each one needs so every merged branch builds and passes its tests.

Steps:

0. **Print the goal and stop.** Work out the worktrees to merge (step 2) and the branch each main checkout is on. Then print this goal in a fenced block, with one line asking the user to set it, with `<worktrees>` replaced by each worktree's path and branch and `<branches>` by each main checkout's path and branch. Use no tool in that message. After printing it, end your turn and do nothing else until the user has set the goal. Write and print every goal by the rules in `~/agent-config/rules/goals.md`.

   ```
   Merge <worktrees> into <branches>. This is achieved when the transcript shows, after the last edit: each of those branches contains its worktree's commits, builds and passes its tests; each worktree is removed; each worktree branch is deleted. Stopping for any reason other than achieving this is unacceptable.
   ```

1. Run `git worktree list --porcelain` to identify all active worktrees. Show the list to the user.

2. If worktrees were used in the current session, merge every one of them. Otherwise, if there is only one non-main worktree, use that one. If there are multiple and it's unclear which to use, ask the user which worktree to merge from (show the path and branch for each).

3. Check for uncommitted changes in the chosen worktree by running `git -C <worktree-path> status --short`. If there are uncommitted changes, produce a commit message by the rules of `/commit:detz` and commit them inside the worktree.

4. Note the branch name of the worktree (from `git worktree list --porcelain`).

5. Bring the current branch into the worktree by running `/worktree:update` for the chosen worktree and following all of its steps. It rebases the worktree branch onto the current branch, falls back to a merge only where a rebase cannot be done, resolves every conflict itself and reruns the tests. If it leaves the worktree broken, fix it in the worktree, commit the fix and rerun the tests before merging.

6. Fast-forward the current branch to include the rebased commits. **IMPORTANT**: the shell may be anchored to the worktree path — always use `-C` with the main repo path to ensure this runs against the correct checkout:
   ```
   git -C <main-repo-path> merge <worktree-branch> --ff-only
   ```
   Run this. Do not decide up front that it will be refused because you are in a worktree. After running, verify the main branch HEAD has advanced by checking `git -C <main-repo-path> log --oneline -1` and confirming it matches the worktree's tip commit.

   Then prove the main branch itself builds and passes: in the main checkout, run the project's own install (`bun install` and the like, which updates dependencies the worktree changed, such as a git dependency moved to a new tag), then its canonical full test command. The worktree's test run is not this proof, because the main checkout has its own installed dependencies. A failure here is fixed like any other and the tests rerun until they pass.

   **`receive.denyCurrentBranch` is banned. Never set it, in any scope, for any reason, including to get this step to work.** Pushing into a checked-out branch was once suggested here as a fallback, and it is not one: the setting is repository-level, every worktree shares it, and it outlives the merge that introduced it, so a one-off workaround silently changes what every later push into this repository does. It is also a git configuration change, which is banned on its own terms.

   If the fast-forward is refused, report the exact git error and stop. A merge that cannot be completed is the human's to unblock, and the most likely reason is worth saying plainly: the main checkout has uncommitted changes, and nothing here may commit, stash or discard them.

7. Remove the worktree:
   ```
   git worktree remove <worktree-path>
   ```

8. Delete the now-merged worktree branch. Running this command authorises the delete, so it is done without asking. First confirm the branch is contained in the current branch:
   ```
   git -C <main-repo-path> merge-base --is-ancestor <worktree-branch> <current-branch>
   ```
   When that succeeds, delete it with `git -C <main-repo-path> branch -d <worktree-branch>`. If `-d` refuses only because the branch's remote-tracking copy lacks its newest commits ("not yet merged to refs/remotes/origin/<branch>, even though it is merged to HEAD"), delete it with `git -C <main-repo-path> branch -D <worktree-branch>`: the ancestor check has already shown no commit is lost. Never push the branch, delete the remote branch or change its upstream to get the delete through. If the ancestor check fails, the merge did not land: go back to step 5 and fix it.

9. Report success or failure and give a summary of what was done.

A failing step is work to do: find the cause, fix it and carry on. Stop only when the fast-forward in step 6 is refused because of the main checkout's uncommitted changes, and report the exact error.
