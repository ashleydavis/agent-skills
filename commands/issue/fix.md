Given the root cause, proposed fix, and implementation plan from this conversation, implement the fix and verify it.

**BEFORE ANYTHING ELSE, ONCE THE PLAN IS CHOSEN: CHECK THAT THE PLAN (OR THE PART OF THE PLAN) TO BE IMPLEMENTED HAS NO STOPS, NO QUESTIONS AND NO PARTS THAT REQUIRE A HUMAN. THE ONE ALLOWED STOP IS AFTER THE WRITE DOCUMENTATION STEP, FOR THE HUMAN TO REVIEW THE DOCUMENTATION, AND THIS COMMAND DOES NOT STOP THERE: IT WRITES THE DOCUMENTATION AND CARRIES ON. IF IT HAS ANY OTHER, EXIT IMMEDIATELY SAYING: THIS PLAN CANNOT BE COMPLETED WITHOUT A HUMAN, THE PLAN NEEDS FIXING**

**This command is not authorized to run any git command that writes**: no commit, stage, push, tag, branch, worktree, stash, checkout, reset or any other command that changes git state, anywhere, whatever the plan says. Git may be used read-only (`status`, `log`, `show`, `diff`, `blame` and the like). Other external actions (release, publish, running a workflow) are done only when the plan stamps them "requested explicitly by the human", and only in its "Release" step. Deletions are done only in its "Clean up" step, last. Test by the platform rules and testing ladder in `~/agent-config/rules/testing.md`.

0. **Working location** — work in the checkout the session is in now (the main working copy, or the worktree the human has already made and the session is in). Never make a worktree or branch: that writes to git. If the checkout contains a `mise.toml`, run its commands through `mise exec --`.

   **Work inside that checkout for the entire task. This is not optional.** Every file edit and every command must happen there, never in another checkout or worktree. Before you edit or run anything, confirm your working directory is that checkout. If you ever notice you are elsewhere, stop immediately and move back.

   **Then print the goal and stop.** Write and print every goal by the rules in `~/agent-config/rules/goals.md`. Print this to the human, on its own, ready to copy, with `<fix>` replaced by a short description of the fix being implemented and `<location>` by the checkout's path:

   ```
   Implement <fix> in <location>. This is achieved when the transcript shows, after the last edit: every task in the todo list for the plan marked complete; the compile, the unit tests and the smoke tests passed; the test that showed the failure passed on the changed code. Stopping for any reason other than achieving this is unacceptable.
   ```

   Tell them that setting it keeps you working to the end instead of handing back after the first change, and that without it you will stop the first time you think you are done. Then end your turn. Do nothing else until the human has set the goal. Start step 1 only once the goal is set.

1. **Read the plan** — find the plan in context or read the most recent file from `docs/plans/new/`.

2. **Check for open issues** — if the plan file has an issues section with unchecked checkboxes (`- [ ]`), stop and report them to the user before proceeding.

3. **Create a todo list** — use TodoWrite to break the plan into discrete tasks. Work through them one by one, marking each complete as you finish it.

4. **Implement** — make only the changes described in the plan. Do not add unrequested features, refactoring, or cleanup beyond what the plan specifies.

5. **Verify** — once all tasks are done, run `/verify` to confirm the full test suite and compile checks pass.

   When the conversation before this command showed the failure through a test (a unit, smoke, e2e or manual test), run that exact test, as it is written, on the fixed code and show it passing. Same test, same commands, same paths, same steps: a similar command or a different database path does not count. If the test's own steps build from a checkout that does not have the fix, build from the one that does and run every other step as written. The fix is not verified until that test passes.

6. **Report** — once all checks pass, summarise what was changed (files and functions) and confirm that compile, unit tests, and smoke tests all passed, and that the test that showed the failure now passes.
