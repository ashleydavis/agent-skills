Respond to the "Review" section of a completed plan.

Use the plan from the current conversation. If there is none and a plan in `docs/plans/done/` or `docs/plans/new/` has an unchecked bullet in its "Review issues" section, use that plan. Otherwise list the plans that have an unchecked "Review issues" bullet, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose. Once they have chosen, read that plan only.

The plan's "Review" section holds a "Review" checklist, a "Reviewed" checklist and a "Review issues" section. The "Review issues" section has one bullet per finding, nested under the "Review" checklist item it belongs to. The "Reviewed" checklist marks the items the review did not meet. The checklist is in `~/agent-config/rules/review-checklist.md`.

1. **Read the "Review" section.** Read the "Review" checklist, the "Reviewed" checklist and the "Review issues" section.

2. **Make a todo list** from the unchecked bullets in "Review issues", in the order they appear.

3. **Fix one issue at a time.** For each unchecked bullet:
    - Read the bullet and the "Review" checklist item it is nested under.
    - Make the change in the code. The change is the fix the bullet asks for. Do not fix anything else.
    - Run the tests and the checks the bullet names. A fix that breaks a test that passed before is not a fix: fix the cause and run the tests again. Collect the evidence as the fix is done: save the compile output to `tmp/evidence/compile`, the test output to `tmp/evidence/tests` and the acceptance evidence, screenshots included for GUI apps, to `tmp/evidence/acceptance`.
    - Tick the bullet `- [x]` when the fix is in and the tests pass.
    - Tick the "Review" item and the matching "Reviewed" item when every bullet under that item is fixed and the check the item names passes.

4. **Report.** Report the bullets fixed, the bullets not fixed with the reason, and the tests run.

Never change the "Review" checklist items or the "Review issues" text, other than ticking a bullet. Do not add a bullet. Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.

## Next

Recommend the developer run:
- `/plan:review`: re-run the review on the fixed plan.
