Fix the issues in the current plan.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

Make a todo list from the issues in the "Issues" section at the top of the plan.

Work through the todo list, address each issue and update the plan accordingly. An issue that needs the human's answer or permission is resolved now, by asking them, and the answer is written into the plan: the fixed plan must be executable from start to finish with no human intervention, apart from a documentation review stop the human chose.

Mark the checkbox for each issue as done in the plan, as you address each issue.

## Next

Recommend the developer run:
- `/plan:check`: re-analyse the plan to confirm the fixes resolved it.
