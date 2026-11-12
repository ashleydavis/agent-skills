Save the current plan to a markdown file in `docs/plans/new/`.

1. **Identify the plan** — use the plan from the current conversation context. If none is clear, ask the user to describe the plan before proceeding.

2. **Choose a filename** — derive a short kebab-case name from the plan's subject (e.g. `plan-add-user-auth.md`). If a file with that name already exists, choose a different name.

3. **Write the file** — save to `docs/plans/new/<filename>`. Structure the content as:

```
# <Plan Title>

## Decisions not approved by a human
<Simple bullet points. "None" when there are none.>

## Acceptance criteria
<Short, simple, achievable and actionable. A few bullets.>

## Overview
<One paragraph describing the intent>

## Issues
<Leave empty. Populated later by plan:check.>

## Steps
<Numbered list of implementation steps. When the change needs documentation, step 1 is write documentation (then STOP and wait for human approval; revise later steps if the human revises the docs) and the last implementation step updates documentation to match the final code. After the implementation steps come "Verify", then "Self Review", then "Clean up", then "External actions", each only when it has something in it.>

<"Verify" and "Self Review" are separate steps. Verify runs the plan's "Verify" section and saves the evidence in the project's `tmp/evidence/` directory. Self Review checks the evidence the earlier steps collected and checks the "Review" checklist. It does not collect evidence. It can uncheck incomplete steps and add missed steps before Verify. When it fails, restart from the first unchecked step. "Clean up" holds every deletion and comes just before "External actions", which holds only actions stamped "requested explicitly by the human".>

## Unit Tests
<Unit tests to write or update>

## Smoke Tests
<Smoke tests to write or update>

## Verify
<Concrete checks to confirm after implementation is complete. The "Verify" step runs them and saves the evidence in `tmp/evidence/`.>

## Review
<Write the checklist's items here, copied from `~/agent-config/rules/review-checklist.md`. The implementer fills this in the Self Review step.>

## Reviewed
<Write the checklist's items here, copied from `~/agent-config/rules/review-checklist.md`. The reviewer fills this when they review the plan.>

## Review issues
<The reviewer writes each finding here. Leave empty when the review passes.>

## Notes
<Any decisions and trade-offs, including the human's answers. No open questions.>
```

Before writing the file, make sure the plan can be executed from start to finish with no human intervention, apart from a documentation review stop the human chose: no open question, no step needing anything the rules in force let the agent do only on the human's word (committing, pushing, merging, tagging or releasing, deleting files, changing git configuration and the like), and no step waiting on anything outside the agent's reach (a release, a tag, another person's change). Ask the human now about each one and write the answer into the plan, or restructure the step.

4. **Report** — print the path of the saved file.

## Hard stops

- Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.
- Never mention the Android emulator pool in a plan: not its state, not a check of it, and no step or note that depends on it.
- Never save a plan with a step the executing agent cannot finish alone, or with an open question.

## Next

Recommend the developer run:
- `/plan:check`: analyse the saved plan for problems.
