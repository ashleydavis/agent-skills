---
description: Add a worktree to the merge train listed in docs/merge-train.md in the main checkout. Merges nothing.
---

Add a git worktree to the merge train: the list of worktrees that `/worktree:merge-train:merge` will merge. This command only writes the list. It never merges, commits or removes anything.

Steps:

1. Run `git worktree list --porcelain`. The first entry is the main checkout.

2. Choose the worktree. If a worktree was used in this session, use that one. Otherwise show the path and branch of every linked worktree and ask which to add. Never choose the main checkout.

3. Open `<main-checkout>/docs/merge-train.md`. If it does not exist, create it (and `docs/` if needed) with this content:

   ```
   # Merge train

   Worktrees waiting to be merged by `/worktree:merge-train:merge`, in merge order.

   | Branch | Worktree | Commit |
   |---|---|---|
   ```

4. If the branch is already in the table, say so in one line and change nothing.

5. Otherwise append a row: the branch, the worktree path and the short hash of its tip (`git -C <worktree-path> rev-parse --short HEAD`). Use a path starting with `~/` when the path is under the home directory.

6. Check the worktree with `git -C <worktree-path> status --short`. A merge takes commits only, so if anything is uncommitted, list it in the report. Never commit, stash or discard it.

7. Report in one line which branch was added. Add a second line only when step 6 found uncommitted changes.

Do not commit `docs/merge-train.md`.
