Finish all the remaining steps of the current plan and complete the plan.

Start the plan if it has not been started, or resume it if it is part done, and carry on to the plan's final step. Once the user has set the goal (step 1), ask no questions and do not stop until the plan is complete, whatever the reason. A failing test, a build error or a hard step is work to do, not a reason to stop.

0. **Choose the plan** — do not present a menu and do not wait for an answer. If a specific plan is obvious from the conversation context, use that. Otherwise choose it yourself from `docs/plans/new/`: the plan that has a `## Handover` section (in the plan file or in one of its step files), and if there is more than one, the one modified most recently; if none has one, the plan that is part done, newest first; if none of those, the newest plan. Say which plan you chose and why in one line.

1. **Print the goal and stop** — do this right after the plan is chosen, before reading anything. Print the goal in a fenced block, with one line asking the user to set it. Use no tool in that message. Never say you printed it unless you did. The text is exactly this, with the plan's name in place of "the plan":

   ```
   Implement the plan to completion. Satisfy all acceptance criteria for the plan. Implement all unit and smoke tests required and make sure they pass. STOPPING IS NOT ALLOWED FOR ANY REASON UNTIL THE PLAN IS COMPLETED AND ALL TESTS ARE PASSING.
   ```

   After printing it, stop. Do nothing else until the user has set the goal and told you to go on. From then on, stopping is banned until the plan is done.

2. **Read the plan and its handover notes** — read the chosen plan file. If it has a `## Handover` section, read it first: it holds the notes the previous agent left for whoever picks the work up (decisions, traps, what is part done). Treat what it says as what the previous agent believed, and check anything you rely on.

3. **Check for open issues** — look for a section headed `Issues` or `Open issues`. Only unchecked items (`- [ ]`) inside that section count: those are decisions the plan is waiting on, and they are the one thing that ends this command early, because the plan cannot be finished without them. If any exist, report them and stop. Unchecked items in any other section are progress tracking and never count. Never count `- [ ]` across the whole file.

4. **Work out what remains** — there are three cases.

   - **The plan has steps.** Steps are the `## Implementation Steps` checklist at the top of the plan file, with a step file for each item when the plan was broken up with `/plan:break`, or a `## Steps` section of the plan file when there are no step files. Every unchecked item (`- [ ]`) is a remaining step. If every item is already checked (`- [x]`), the plan is already complete: say so, move the plan to `docs/plans/done/` if it is still in `new/`, and stop.
   - **The plan has no steps.** Decide from the plan, its handover notes, the plan's own checklists and the state of the code and the git history what is done and what is left. What is left is everything the plan asks for that is not done, from the start when nothing has been done. If it is part done, pick up where the notes and the code say it left off, as best you can. If everything the plan asks for is done, the plan is already complete: say so and stop.
   - **Nothing has been started.** Everything the plan asks for remains.

5. **Complete all of it** — work through everything that remains, in the plan's order, until none is left. Do not report between steps and do not wait for approval. A "Write documentation" step is not a place to stop and wait for review: write it, carry on, and let the final "Update documentation" step bring it into line with the finished code. For each step, or each piece of work when the plan has no steps:

   - When it has a step file (e.g. `docs/plans/<plan-name>/<N>-<slug>.md`), read it, and read its `## Handover` section first if it has one.
   - Use TodoWrite to break it into discrete tasks and work through them one by one, marking each complete as you go. Work in the directory and branch the session is already in. Do not create a worktree.
   - Add or update unit tests and smoke tests for every new or changed function as described in the step or plan.
   - Run `/verify`. If it fails, find the cause, fix it and run it again, until it passes. A step is not done while it fails.
   - Record it. When the plan has step files, replace the empty `## Summary` placeholder at the bottom of the step file with a concise account of what was actually done: files changed, key decisions, anything that diverged from the step's instructions, and anything deferred. When it has no step files, record it in the plan where the plan keeps its own progress. When the plan has steps, change the `- [ ]` for the step to `- [x]`. Do not tick an item that is not actually done.
   - Delete the `## Handover` section you read for this step (in the step file, the plan file, or both), because it describes a state the work has now moved past.

6. **Complete the plan** — when nothing remains and every item in the checklist is `- [x]`, run `/verify` once more over the whole change, and fix whatever it reports. Then move the plan file and its steps directory from `docs/plans/new/` to `docs/plans/done/`.

7. **Report** — only now, summarise what was done across the whole plan, flag anything that was skipped or deferred and why, and say that the plan has been moved to `docs/plans/done/`.

## Next

Recommend the developer run:
- `/commit:detz`: produce a commit message for the finished plan.
