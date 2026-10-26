Summarise the current plan. 

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

Produce two things:

**Summary** — one paragraph describing the intent of the plan in plain English. What problem does it solve? What will change? Why is the change needed?

**Verification checklist** — a bullet list of things to confirm after implementation is complete. Cover unit tests, smoke tests, and any ad-hoc manual checks. Each item should be a concrete, observable check (e.g. "unit tests pass for `editSecret`", "CLI command `secrets edit` accepts multiline input", "manually verify the modal closes after save").
