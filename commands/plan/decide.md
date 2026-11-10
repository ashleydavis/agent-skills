Walk through the plan's decisions not approved by a human, one at a time, and record the human's verdict on each.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

1. **Read the decisions.** Take each bullet in the plan's "Decisions not approved by a human" section. If the section is missing or says "None", say so in one line and stop.

2. **Present one decision at a time.** For each, use the AskUserQuestion tool with one question that stands on its own: the decision in one plain sentence, what it affects in the plan, and the options:
    - **Approve**: the decision stands.
    - **Reject**: the decision is dropped.
    - **Change**: the human says what to do instead.
    - **More detail**: explain the decision, the alternatives you considered and why you chose this one, then ask about the same decision again.

    Never present the next decision until the current one has a verdict of approve, reject or change.

3. **Apply each verdict to the plan before moving on.**
    - **Approve:** remove the bullet from "Decisions not approved by a human" and record the decision under Notes as approved by the human.
    - **Reject:** remove the bullet, rewrite every step, test and note that depended on the decision so the plan no longer makes it, and record under Notes that it was rejected. If the rejection leaves a gap the plan cannot fill without a new decision, add that new decision as a bullet in "Decisions not approved by a human" so it is walked through in this same run.
    - **Change:** remove the bullet, rewrite every step, test and note that depended on it to follow the human's instruction, and record the instruction under Notes as approved by the human. A new decision the change forces goes back into "Decisions not approved by a human" for this same run.

4. **Finish.** When the section is empty, replace its contents with "None". Report in one line how many decisions were approved, rejected and changed.

Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.

## Next

Recommend the developer run:
- `/plan:check`: re-analyse the plan after the changes.
