Fix the issues in the current plan. The fixes go in the plan only. Never change the code.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

Make a todo list from the issues in the "Issues" section at the top of the plan.

Work through the todo list, address each issue and update the plan accordingly. Fixing a plan asks no questions and never stops for a decision. Do not stop until every issue is fixed. An issue that needs the human's answer or permission is resolved by choosing the recommended option and adding it to "Decisions not approved by a human".

Mark the checkbox for each issue as done in the plan, as you address each issue.

Before fixing an issue, check that it is inside the plan's scope: the change the plan's Overview describes. Never fix an issue outside it, and change nothing but the plan's text to deal with it. Mark it `[-]` in place of its checkbox and write, indented under it, one or two lines saying why it is outside the plan's scope.

The plan must have a Self Review step after Verify. When it is missing, add it. It checks the evidence the earlier steps collected and the "Review" checklist, and it does not collect evidence. The "Review" section carries the checklist items from `~/agent-config/rules/review-checklist.md`. The order is Verify, then Self Review, then Clean up, then External actions.

Finish with a summary that lists every issue marked `[-]` as out of scope, each with its reason in one line.

Never mention the Android emulator pool in the plan: not its state, not a check of it, and no step or note that depends on it.

## Next

Recommend the developer run:
- `/plan:check`: re-analyse the plan to confirm the fixes resolved it.
