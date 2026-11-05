---
description: Merge every worktree listed in docs/merge-train.md through a temporary merge train, drop any that fail the tests, then merge the rest into the main checkout's branch.
---

Merge every worktree listed in `<main-checkout>/docs/merge-train.md` (written by `/worktree:merge-train:add`) into the main checkout's current branch, through a temporary merge train worktree. A worktree whose changes fail the tests is taken out of the train and left as it is.

Running this command is the human's go-ahead for everything below: creating and deleting the merge train worktree and branch, merging, resetting the merge train branch, bisecting in the merge train worktree, fast-forwarding the main checkout's branch, deleting `docs/merge-train.md`, and removing the merged worktrees with their local branches. Nothing else. Never push, never delete a remote branch, never change git configuration, never pass `--force` to `git worktree remove` and never delete a branch with `-D`. `receive.denyCurrentBranch` is banned in every scope.

Never refuse or hedge because the harness might block a command. Run it and find out. If a command fails, report its exact error.

## Steps

1. **Find everything.** Run `git worktree list --porcelain`. The first entry is the main checkout. If the session is inside a linked worktree (entered with `EnterWorktree`), leave it with `ExitWorktree` and `action: "keep"`.

2. **Read the train.** Read `<main-checkout>/docs/merge-train.md`. If it is missing or lists no branch, report that there is nothing to merge and stop.

3. **Find the target.** The target is the main checkout's current branch: `git -C <main-checkout> branch --show-current`. Do not assume `main`. If HEAD is detached, report it and stop.

4. **Check the main checkout.** Run `git -C <main-checkout> status --short`. If anything other than `docs/merge-train.md` is uncommitted, report it and stop: the fast-forward at the end could be refused, and nothing here may commit, stash or discard it.

5. **Check each listed worktree.** For each, confirm the branch exists and `git -C <worktree-path> status --short` is empty. A worktree with uncommitted changes or a missing branch is left out of the train and named in the report. If none is left, report that and stop.

6. **Create the merge train.** Name it `merge-train-<yyyymmdd-hhmmss>`. Create it next to the other linked worktrees (in the same parent directory), from the target:
   `git -C <main-checkout> worktree add <train-path> -b <train-branch> <target>`
   If the repo has a `mise.toml`, run `mise trust` on the train's copy straight away and run every command in the train through its own mise. Run the project's own install (for example `bun install`) if it has one.

7. **Merge every worktree into the train**, one after another in the listed order, with no testing between merges:
   `git -C <train-path> merge --no-edit <branch>`
   Resolve any conflict yourself, by reading both sides (`git -C <train-path> log <target>..<branch>`) and editing the result, then finish the merge with `git -C <train-path> commit --no-edit`. Record the merge commit for each branch.

8. **Delete `<main-checkout>/docs/merge-train.md`.**

9. **Test the train.** Use the repository's canonical test command, whichever its `CLAUDE.md` or `AGENTS.md` names. If it names none, run its full test script. If it has no test script, run the offline checks its CI validation workflow runs. Run it from the train, as the repository names it, with no flag that forces everything to run.

10. **On failure, find the worktree that breaks it.** Bisect over the train's merge commits:
    `git -C <train-path> bisect start --first-parent <train-branch> <target>`
    then `git -C <train-path> bisect run <test command>`. The first bad commit is the merge of the worktree to take out. Finish with `git -C <train-path> bisect reset`.
    If bisect blames the first merge, test the target alone in the train (`git -C <train-path> switch --detach <target>`, test, then `git -C <train-path> switch <train-branch>`). If the target fails on its own, no worktree is to blame: remove the train worktree and branch as in step 13, merge nothing, report that the target branch fails its tests and stop.

11. **Rebuild the train without it.** `git -C <train-path> reset --hard <target>`, then merge the remaining worktrees again in the listed order as in step 7. Go back to step 9. Repeat until the tests pass or no worktree is left. Keep the failing test output for each worktree taken out.

12. **On success, merge the train into the target:**
    `git -C <main-checkout> merge --ff-only <train-branch>`
    Then check `git -C <main-checkout> log --oneline -1` matches the train's tip. If the fast-forward is refused, report the exact error and stop, leaving the train in place.

13. **Remove the train.** After a complete failure, first run `git -C <train-path> reset --hard <target>` so the train branch is contained in the target. Then `git -C <main-checkout> worktree remove <train-path>` and `git -C <main-checkout> branch -d <train-branch>`.

14. **Remove each merged worktree and its local branch:** `git -C <main-checkout> worktree remove <worktree-path>`, then `git -C <main-checkout> branch -d <branch>`. If git refuses either, report its exact error and leave that one.

15. **Report:**
    - The branches merged into the target and the target's new tip.
    - Each worktree taken out for failing the tests, with the failing test in one line. Its worktree and branch are still there.
    - Each worktree left out in step 5, and why.
    - If nothing could be merged, say so first, and say the target is unchanged.
