Implement the current plan.

**BEFORE ANYTHING ELSE, ONCE THE PLAN IS CHOSEN: CHECK THAT THE PLAN (OR THE PART OF THE PLAN) TO BE IMPLEMENTED HAS NO STOPS, NO QUESTIONS AND NO PARTS THAT REQUIRE A HUMAN. THE ONE ALLOWED STOP IS A DOCUMENTATION REVIEW STOP, FOR THE HUMAN TO REVIEW THE DOCUMENTATION. IF IT HAS ANY OTHER, EXIT IMMEDIATELY SAYING: THIS PLAN CANNOT BE COMPLETED WITHOUT A HUMAN, THE PLAN NEEDS FIXING**

External actions (commit, push, release, tag, publish, running a workflow) are done only when the plan stamps them "requested explicitly by the human", and only in its "Release" step. Deletions are done only in its "Clean up" step, last. Test by the platform rules and testing ladder in `~/agent-config/rules/testing.md`.

**The plan is not yours to change.** You are authorised to edit the plan file only to tick a step, record what was done under that step, and delete the handover you used. You may not add, remove, move, reword, split or reduce any step, any item of a step or any acceptance criterion, and you may not move work out of a step to another one. If a step looks too big, impossible or in conflict with something else, the step stands as written: do all of it. If you think the plan itself is wrong, say so in the report and leave it unchanged.

**Stay inside the step.** A failure in code or tests this work did not change is not part of it. If it passes on the next run, record it in one line in the report and carry on, and do not investigate it, run tests only to reproduce it, or fix it. A failure is yours only if it is in what the work changed, or if it still fails on the final full run.

0. **Choose the plan** — if a specific plan is obvious from the conversation context, use that. If `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

1. **Choose working location** — ask this right after the plan is chosen, before the goal is printed, because the goal forbids questions once it is set. Present the user with:
   ```
   1. Main working copy
   2. Git worktree
   ```
   Wait for the user to reply with 1 or 2. If they choose 2: (1) run `git branch --show-current` to get the current branch, (2) run `git worktree add -b <new-branch> .claude/worktrees/<name> <current-branch>` to create the worktree branching from the current branch, (3) use `EnterWorktree` with the `path` parameter to enter it, (4) if the worktree contains a `mise.toml`, run `mise trust` inside it without asking (it trusts a copy of a file already trusted in the main checkout), then run `mise exec -- bun install` inside it; otherwise run `bun install` inside it. Do this before proceeding.

   **If the user chose the worktree (option 2) you MUST actually work inside that worktree for the entire task. This is not optional.** Every file edit, every command, every commit must happen inside the worktree, never in the main repo. It is NOT acceptable to make changes to the main working copy when the user chose the worktree, not even a small edit, a quick fix, a test tweak, or "just this once". Before you edit or run anything, confirm your working directory is the worktree path. If you ever notice you are in the main repo, stop immediately and move to the worktree.

   Understand the consequences, because YOU have repeatedly broken this rule: if you make ANY change to the main repo when you were supposed to be on the worktree, those changes will be summarily reverted without asking you and without consulting you. Your work will be thrown away. And if you keep violating this rule and continue making changes to the main repo, your process will be summarily terminated. Reverted changes and a terminated process is the guaranteed outcome of working in the main repo when the worktree was chosen. Use the worktree.

2. **Print the goal and stop** — do this right after the working location is set up. Read only the plan's list of steps, to find whether it has a documentation review stop: a step that writes documentation and tells you to stop for the human's review. A step that writes documentation without saying to stop is an ordinary step, not a review stop, wherever it sits in the plan. Print the goal in a fenced block, with one line asking the user to set it. Use no tool in that message. Never say you printed it unless you did.

   **When the plan has a documentation review stop**, print the first goal, which ends at the documentation stop. The text is exactly this, with the plan's name in place of `<plan>` and the documentation step's number and title in place of `<N>` and `<title>`:

   ```
   Do <plan> up to and including step <N>, <title>. You are finished only when all of these are shown in the transcript after your last edit: step <N> and every step before it shows as `- [x]` in the plan file; each of those steps has a filled summary and no `## Handover`, in its step file when the plan has step files and otherwise under that step in the plan file; the human has been told the documentation is ready for review. Never create a step file. Do not start any step after step <N>. Ask no questions before then. When something blocks you, solve it, and if it needs a decision, make it yourself and record it in the summary.
   ```

   The second goal, below, is printed at the documentation stop (step 6).

   **When the plan has no documentation review stop**, print this goal, with the plan's name in place of "the plan":

   ```
   Do the plan. You are finished only when all of these are shown in the transcript after your last edit: the tests ran and passed; the plan file shows every step as `- [x]` and is in `docs/plans/done/`; every step has a filled summary and no `## Handover`, in its step file when the plan has step files and otherwise under that step in the plan file. Never create a step file. Never stop before then. Run all tests related to code that was changed, there is no need to run all tests unless all code has changed. Do not force all tests to run. Do not use the --force argument on test scripts. A test command that exits with code 0 has passed, and that includes a run that reports it had nothing to run because nothing changed since the last passing run. Ask no questions. When something blocks you, solve it, and if it needs a decision, make it yourself and record it in the summary.
   ```

   After printing it, stop. Do nothing else until the user has set the goal and told you to go on. From then on, stopping is banned until the goal is met.

3. **Read the plan** — read the chosen plan file from `docs/plans/new/`. If it has a `## Handover` section, read it first: it holds the notes the previous agent left for whoever picks the work up (decisions, traps, what is part done). Treat what it says as what the previous agent believed, and check anything you rely on.

4. **Check for open issues** — look for a section headed `Issues` or `Open issues`. Only unchecked items (`- [ ]`) inside that section block implementation: if any exist, stop and report them to the user before proceeding. Unchecked items in any other section (a progress or parity checklist, for example) are progress tracking, so ignore them. Never count `- [ ]` across the whole file. If the plan has no such section, there is nothing to check, so continue to step 5.

5. **Create a todo list** — use TodoWrite to break the plan into discrete tasks, then work through them one by one, marking each complete as you go.

6. **Documentation stop** — if the plan has a documentation review stop, do every step up to and including it and then STOP. Do not start later steps. Do not write tests, verify, or move the plan. Tell the human the documentation is ready for review and wait for them to approve it. If they revise the documentation, revise the remaining plan steps to match. When they approve, print the second goal (the no-review-stop goal from step 2) in a fenced block, with one line asking them to set it, and wait for them to say to continue. Only then may you implement later steps. The last step, when present, updates the documentation to match the final code.

7. **Write tests** — add or update unit tests and smoke tests for every new or changed function as described in the step or plan.

8. **Verify** — once all steps are done, run the tests and read the result. Run all tests related to code that was changed, there is no need to run all tests unless all code has changed. Do not force all tests to run. Do not use the --force argument on test scripts. A test command that exits with code 0 has passed, and that includes a run that reports it had nothing to run because nothing changed since the last passing run. Any failure is yours to fix: fix the cause and run the tests again until they pass. Do not tick a step until every function the work added or changed, copied code included, has a unit test, and you checked this rather than assumed it. Any later edit means running it again.

9. **Move the plan** — move the plan file (and the plans "steps" directory if it has one) from `docs/plans/new/` to `docs/plans/done/`.

10. **Report** — summarise what was implemented and flag anything that was skipped or deferred.

## Next

Recommend the developer run:
- After a documentation review stop, wait for the human to approve the docs (and revise remaining plan steps if they changed the docs) before continuing implementation.
- `/commit:detz`: once checks pass, produce a commit message.
