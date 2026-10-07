Continue the current plan from where it left off.

This works for a plan that has been broken into step files (via `/plan:break`), for a plan with a checklist of steps in the plan file, and for a plan with no steps at all. A plan that has steps gets exactly one step done, and then this command stops. A plan with no steps gets the next piece of work done, as far as the plan and its handover notes make clear, and then stops.

Once the plan is chosen, do not ask the user any questions and do not stop for a decision. When something is undecided, make the most sensible call yourself, say in the report what you decided and why, and carry on. Once the user has set the goal (step 1), stopping is banned. The current step (or the next piece of work, for a plan with no steps) must be completed, with no questions and no stopping until it is done, and "complete" means every part of it is written, tested and ticked off. The user running this command is the go-ahead.

**The plan is not yours to change.** You are authorised to edit the plan file only to tick the current step, record what was done under that step, and delete the handover you used. You may not add, remove, move, reword, split or reduce any step, any item of a step or any acceptance criterion, in the current step or any other, and you may not move work out of the current step to another one. "Make the most sensible call" applies only to how you do the work inside the current step. If the step looks too big, impossible or in conflict with something else, the step stands as written: do all of it. If you think the plan itself is wrong, say so in the report and leave it unchanged.

**Finished is proved, not claimed.** Before you write the report, check all of these. If any fails, you are not finished: go back to step 5 and keep working.

- Every item the step names is done, as the step words it. Moving an item to a later step, splitting the step, or doing a smaller version of it is not doing it. If an item needs something that is not built yet, building that thing is part of this step.
- The last run of the project's full test command (step 7) was green, and you read its output in this session after your last edit. A run before your last edit does not count, and neither does a narrower set of tests than the full command.
- Every test you wrote was watched failing before it passed.
- The step is ticked off.

0. **Choose the plan** — if a specific plan is obvious from the conversation context, use that. Otherwise present every plan in `docs/plans/new/` as a numbered menu, newest first by modification time. Do not truncate the list: the user cannot choose a plan you did not show them, and a plan sitting in `new/` is a plan waiting to be worked on however old it is. Read the top of each file (its heading and Overview) and give every plan a description of one short sentence saying what it does, on the row beside its number. Say whether it has not been started, is part done (how many of its steps are checked off, when it has steps) or is finished. A filename is not a description, so a menu of bare filenames is not a menu. Wait for the user's selection before continuing.

1. **Print the goal and stop** — do this right after the plan is chosen, before reading anything. Print the goal in a fenced block, with one line asking the user to set it. Use no tool in that message. Never say you printed it unless you did. The text is exactly this, but write "the next step of" and the plan's name in place of "the step", because you do not know the step yet:

   ```
   Implement the step to completion. Satisfy all acceptance criteria for the step. Implement all unit and smoke tests required and make sure they pass. Run the project's full test command after your last edit and make sure every test passes. STOPPING IS NOT ALLOWED FOR ANY REASON UNTIL THE STEP IS COMPLETED AND ALL TESTS ARE PASSING.
   ```

   After printing it, stop. Do nothing else until the user has set the goal and told you to go on. From then on, stopping is banned until the step is done.

2. **Read the plan and its handover notes** — read the chosen plan file. If it has a `## Handover` section, read it first: it holds the notes the previous agent left for whoever picks the work up (decisions, traps, what is part done). Treat what it says as what the previous agent believed, and check anything you rely on.

3. **Check for open issues** — look for a section headed `Issues` or `Open issues`. Only unchecked items (`- [ ]`) inside that section block the work: if any exist, stop and report them to the user. Unchecked items in any other section are progress tracking and never count. Never count `- [ ]` across the whole file.

4. **Work out where the plan stands** — there are three cases.

   - **The plan has steps.** Steps are the `## Implementation Steps` checklist at the top of the plan file, with a step file for each item when the plan was broken up with `/plan:break`, or a `## Steps` section of the plan file when there are no step files. Find the first unchecked item (`- [ ]`). If every item is checked (`- [x]`), the plan is finished: report that, move the plan to `docs/plans/done/` if it is still in `new/`, and stop. Otherwise that unchecked item is the step to do. When it has a step file (e.g. `docs/plans/<plan-name>/<N>-<slug>.md`), read it, and read its `## Handover` section first if it has one.
   - **The plan has no steps.** Decide from the plan, its handover notes, the plan's own checklists and the state of the code and the git history what is done and what is left. If nothing has been done, start at the beginning. If it is part done, pick up where the notes and the code say it left off, as best you can. If everything the plan asks for is done, the plan is finished: report that and stop.
   - **Nothing has been started.** Start the plan and do its first step, or its first piece of work when it has no steps.

   Say which step or piece of work you are doing before you start it. Do not ask the user to confirm it.

5. **Create a todo list** — use TodoWrite to break the step or piece of work into discrete tasks, then work through them one by one, marking each complete as you go. Work in the directory and branch the session is already in. Do not create a worktree.

6. **Write tests** — add or update unit tests and smoke tests for every new or changed function as described in the step or plan.

7. **Verify** — once all tasks are done, run the project's canonical full test command, exactly as the project's instructions give it (for a project whose `CLAUDE.md` names one, such as `bun run tev`, that one, plain and with no flags that skip suites), and read the result. Do not run a subset in its place, and do not assemble your own sequence of smaller commands. If it is longer than your command limit, start it in the background and wait for it inside the turn. Any failure is yours to fix, whoever wrote the code: fix the cause, then run the whole command again, and repeat until it is green. A suite that cannot run on this machine is named in the report with the reason, and never counted as passing. After this step, any further edit means running it again.

8. **Record what was done** — when the plan has step files, replace the empty `## Summary` placeholder at the bottom of the step file with a concise account of what was actually done: files changed, key decisions, anything that diverged from the step's instructions, and anything deferred. When it has no step files, record it in the plan where the plan keeps its own progress.

9. **Mark the step complete** — when the plan has steps, change the `- [ ]` for this step to `- [x]` in the plan's checklist. Do not tick an item that is not actually done: tick it only when the check under "Finished is proved, not claimed" passes in full. There is no way out of this: a step that looks impossible as written is a step whose missing pieces you build, and the step is not reported or left until it is done and ticked.

10. **Clear the handover you used** — delete the `## Handover` section you read at the start (in the step file, the plan file, or both), because it describes a state the work has now moved past. If you stop before the step is done, leave it and tell the user to run `/plan:handover`.

11. **If this was the last step, move the plan** — if every item in the checklist is now `- [x]`, move the plan file and its steps directory from `docs/plans/new/` to `docs/plans/done/`. Otherwise leave the plan in `new/`.

12. **Report and stop** — this is the only place this command stops. Summarise what was done, name the test command you ran and say what it reported, flag anything that was skipped or deferred, and tell the user which step (if any) is next. Do not start the next step.

    **Documentation stop.** If the step just completed was "Write documentation" (the first step of a plan that needs docs), tell the human the documentation is ready for review and wait for them to approve it. If they revise the documentation, revise the remaining plan steps to match, then wait for them to say to continue. Only after that approval may `/plan:continue` be run again. When the last step is "Update documentation", it revises the docs from step 1 to match the final code.

## Next

Recommend the developer run:
- `/plan:continue`: do the next step, until the plan is finished. After a write-documentation step, do not run this until the human has approved the documentation (and remaining steps have been revised if they changed the docs).
- `/plan:handover`: if you stopped before the step was done.
