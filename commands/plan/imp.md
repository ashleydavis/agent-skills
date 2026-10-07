Implement the current plan.

0. **Choose the plan** — if a specific plan is obvious from the conversation context, use that. Otherwise present every plan in `docs/plans/new/` as a numbered menu, newest first by modification time. Do not truncate the list: the user cannot choose a plan you did not show them, and a plan sitting in `new/` is a plan waiting to be implemented however old it is. Read the top of each file (its heading and Overview) and give every plan a description of one short sentence saying what it does, on the row beside its number. Mark any plan whose section headed `Issues` or `Open issues` still has unchecked items (`- [ ]`), since step 3 will refuse to implement it. Unchecked items in any other section are progress tracking and never count. A filename is not a description, so a menu of bare filenames is not a menu. Wait for the user's selection before continuing.

1. **Choose working location** — present the user with:
   ```
   1. Main working copy
   2. Git worktree
   ```
   Wait for the user to reply with 1 or 2. If they choose 2: (1) run `git branch --show-current` to get the current branch, (2) run `git worktree add -b <new-branch> .claude/worktrees/<name> <current-branch>` to create the worktree branching from the current branch, (3) use `EnterWorktree` with the `path` parameter to enter it, (4) if the worktree contains a `mise.toml`, run `mise trust` inside it without asking (it trusts a copy of a file already trusted in the main checkout), then run `mise exec -- bun install` inside it; otherwise run `bun install` inside it. Do this before proceeding.

   **If the user chose the worktree (option 2) you MUST actually work inside that worktree for the entire task. This is not optional.** Every file edit, every command, every commit must happen inside the worktree, never in the main repo. It is NOT acceptable to make changes to the main working copy when the user chose the worktree, not even a small edit, a quick fix, a test tweak, or "just this once". Before you edit or run anything, confirm your working directory is the worktree path. If you ever notice you are in the main repo, stop immediately and move to the worktree.

   Understand the consequences, because YOU have repeatedly broken this rule: if you make ANY change to the main repo when you were supposed to be on the worktree, those changes will be summarily reverted without asking you and without consulting you. Your work will be thrown away. And if you keep violating this rule and continue making changes to the main repo, your process will be summarily terminated. Reverted changes and a terminated process is the guaranteed outcome of working in the main repo when the worktree was chosen. Use the worktree.

2. **Read the plan** — read the chosen plan file from `docs/plans/new/`. If it has a `## Handover` section, read it first: it holds the notes the previous agent left for whoever picks the work up (decisions, traps, what is part done). Treat what it says as what the previous agent believed, and check anything you rely on.

3. **Check for open issues** — look for a section headed `Issues` or `Open issues`. Only unchecked items (`- [ ]`) inside that section block implementation: if any exist, stop and report them to the user before proceeding. Unchecked items in any other section (a progress or parity checklist, for example) are progress tracking, so ignore them. Never count `- [ ]` across the whole file. If the plan has no such section, there is nothing to check, so continue to step 4.

4. **Create a todo list** — first print a goal for the user to set, in a fenced block, so that a goal can hold you to finishing. Print it first, as a message of its own with no tool call in it, before any other tool call. Write it for this plan: name the plan and say it is met only when every step is written with its unit tests (each watched failing first), `/verify` passes, and the plan has been moved to `docs/plans/done/`. Say that stopping is banned and the goal is not met until all of it is done. Print it once, then carry on working: do not wait for the user to set it. Then use TodoWrite to break the plan into discrete tasks, then work through them one by one, marking each complete as you go.

5. **Documentation stop** — if the plan's first step is write documentation, do that step and then STOP. Do not start later steps. Do not write tests, verify, or move the plan. Tell the human the documentation is ready for review and wait for them to approve it. If they revise the documentation, revise the remaining plan steps to match, then wait for them to say to continue. Only after that approval may you implement later steps. The last step, when present, updates the documentation to match the final code.

6. **Write tests** — add or update unit tests and smoke tests for every new or changed function as described in the plan.

7. **Verify** — once all steps are done, run `/verify` to confirm the full test suite and compile checks pass.

8. **Move the plan** — move the plan file (and the plans "steps" directory if it has one) from `docs/plans/new/` to `docs/plans/done/`.

9. **Report** — summarise what was implemented and flag anything that was skipped or deferred.

## Next

Recommend the developer run:
- After a write-documentation step, wait for the human to approve the docs (and revise remaining plan steps if they changed the docs) before continuing implementation.
- `/verify`: run all quality checks once implementation is complete.
- `/commit:detz`: once checks pass, produce a commit message.
