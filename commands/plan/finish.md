Finish all the remaining steps of the current plan and complete the plan.

Start the plan if it has not been started, or resume it if it is part done, and carry on to the plan's final step. Once the user has set the goal (step 2), ask no questions and do not stop until the plan is complete, whatever the reason. A failing test, a build error or a hard step is work to do, not a reason to stop.

**The plan is not yours to change.** You are authorised to edit the plan file only to tick a step, record what was done under that step, and delete the handover you used. You may not add, remove, move, reword, split or reduce any step, any item of a step or any acceptance criterion, and you may not move work out of a step to another one. If a step looks too big, impossible or in conflict with something else, the step stands as written: do all of it. If you think the plan itself is wrong, say so in the report and leave it unchanged.

**Stay inside the step.** A failure in code or tests this work did not change is not part of it. If it passes on the next run, record it in one line in the report and carry on, and do not investigate it, run tests only to reproduce it, or fix it. A failure is yours only if it is in what the work changed, or if it still fails on the final full run.

0. **Choose the plan** — do not present a menu and do not wait for an answer. If a specific plan is obvious from the conversation context, use that. Otherwise choose it yourself from `docs/plans/new/`: the plan that has a `## Handover` section (in the plan file or in one of its step files), and if there is more than one, the one modified most recently; if none has one, the plan that is part done, newest first; if none of those, the newest plan. Say which plan you chose and why in one line.

1. **Choose working location** — ask this right after the plan is chosen, before the goal is printed, because the goal forbids questions once it is set. Present the user with:
   ```
   1. Main working copy
   2. Git worktree
   ```
   Wait for the user to reply with 1 or 2. If they choose 2: (1) run `git branch --show-current` to get the current branch, (2) run `git worktree add -b <new-branch> .claude/worktrees/<name> <current-branch>` to create the worktree branching from the current branch, (3) use `EnterWorktree` with the `path` parameter to enter it, (4) if the worktree contains a `mise.toml`, run `mise trust` inside it without asking (it trusts a copy of a file already trusted in the main checkout), then run `mise exec -- bun install` inside it; otherwise run `bun install` inside it. Do this before proceeding.

   **If the user chose the worktree (option 2) you MUST actually work inside that worktree for the entire task. This is not optional.** Every file edit, every command, every commit must happen inside the worktree, never in the main repo. It is NOT acceptable to make changes to the main working copy when the user chose the worktree, not even a small edit, a quick fix, a test tweak, or "just this once". Before you edit or run anything, confirm your working directory is the worktree path. If you ever notice you are in the main repo, stop immediately and move to the worktree.

   Understand the consequences, because YOU have repeatedly broken this rule: if you make ANY change to the main repo when you were supposed to be on the worktree, those changes will be summarily reverted without asking you and without consulting you. Your work will be thrown away. And if you keep violating this rule and continue making changes to the main repo, your process will be summarily terminated. Reverted changes and a terminated process is the guaranteed outcome of working in the main repo when the worktree was chosen. Use the worktree.

2. **Print the goal and stop** — do this right after the working location is set up, before reading anything. Print the goal in a fenced block, with one line asking the user to set it. Use no tool in that message. Never say you printed it unless you did. The text is exactly this, with the plan's name in place of "the plan":

   ```
   Do the plan. You are finished only when all of these are shown in the transcript after your last edit: the tests ran and passed; the plan file shows every step as `- [x]` and is in `docs/plans/done/`; every step has a filled summary and no `## Handover`, in its step file when the plan has step files and otherwise under that step in the plan file. Never create a step file. Never stop before then. Run all tests related to code that was changed, there is no need to run all tests unless all code has changed. Do not force all tests to run. Do not use the --force argument on test scripts. A test command that exits with code 0 has passed, and that includes a run that reports it had nothing to run because nothing changed since the last passing run. Ask no questions. When something blocks you, solve it, and if it needs a decision, make it yourself and record it in the summary.
   ```

   After printing it, stop. Do nothing else until the user has set the goal and told you to go on. From then on, stopping is banned until the plan is done.

3. **Read the plan and its handover notes** — read the chosen plan file. If it has a `## Handover` section, read it first: it holds the notes the previous agent left for whoever picks the work up (decisions, traps, what is part done). Treat what it says as what the previous agent believed, and check anything you rely on.

4. **Check for open issues** — look for a section headed `Issues` or `Open issues`. Only unchecked items (`- [ ]`) inside that section count: those are decisions the plan is waiting on, and they are the one thing that ends this command early, because the plan cannot be finished without them. If any exist, report them and stop. Unchecked items in any other section are progress tracking and never count. Never count `- [ ]` across the whole file.

5. **Work out what remains** — there are three cases.

   - **The plan has steps.** Steps are the `## Implementation Steps` checklist at the top of the plan file, with a step file for each item when the plan was broken up with `/plan:break`, or a `## Steps` section of the plan file when there are no step files. Every unchecked item (`- [ ]`) is a remaining step. If every item is already checked (`- [x]`), the plan is already complete: say so, move the plan to `docs/plans/done/` if it is still in `new/`, and stop.
   - **The plan has no steps.** Decide from the plan, its handover notes, the plan's own checklists and the state of the code and the git history what is done and what is left. What is left is everything the plan asks for that is not done, from the start when nothing has been done. If it is part done, pick up where the notes and the code say it left off, as best you can. If everything the plan asks for is done, the plan is already complete: say so and stop.
   - **Nothing has been started.** Everything the plan asks for remains.

6. **Complete all of it** — work through everything that remains, in the plan's order, until none is left. Do not report between steps and do not wait for approval. A "Write documentation" step is not a place to stop and wait for review: write it, carry on, and let the final "Update documentation" step bring it into line with the finished code. For each step, or each piece of work when the plan has no steps:

   - When it has a step file (e.g. `docs/plans/<plan-name>/<N>-<slug>.md`), read it, and read its `## Handover` section first if it has one.
   - Use TodoWrite to break it into discrete tasks and work through them one by one, marking each complete as you go. Work in the location chosen in step 1.
   - Add or update unit tests and smoke tests for every new or changed function as described in the step or plan.
   - Run the tests. Run all tests related to code that was changed, there is no need to run all tests unless all code has changed. Do not force all tests to run. Do not use the --force argument on test scripts. A test command that exits with code 0 has passed, and that includes a run that reports it had nothing to run because nothing changed since the last passing run. If they fail, find the cause, fix it and run the tests again, until they pass. A step is not done while it fails.
   - Record it. When the plan has step files, replace the empty `## Summary` placeholder at the bottom of the step file with a concise account of what was actually done: files changed, key decisions, anything that diverged from the step's instructions, and anything deferred. When it has no step files, record it under the step in the plan file. Never create a step file. When the plan has steps, change the `- [ ]` for the step to `- [x]`. Do not tick an item that is not actually done. Do not tick a step until every function the work added or changed, copied code included, has a unit test, and you checked this rather than assumed it.
   - Delete the `## Handover` section you read for this step (in the step file, the plan file, or both), because it describes a state the work has now moved past.

7. **Complete the plan** — when nothing remains and every item in the checklist is `- [x]`, run the tests once more over the whole change, and fix whatever they report. Run all tests related to code that was changed, there is no need to run all tests unless all code has changed. Do not force all tests to run. Do not use the --force argument on test scripts. A test command that exits with code 0 has passed, and that includes a run that reports it had nothing to run because nothing changed since the last passing run. Then move the plan file and its steps directory from `docs/plans/new/` to `docs/plans/done/`.

8. **Report** — only now, summarise what was done across the whole plan, flag anything that was skipped or deferred and why, and say that the plan has been moved to `docs/plans/done/`.

## Next

Recommend the developer run:
- `/commit:detz`: produce a commit message for the finished plan.
