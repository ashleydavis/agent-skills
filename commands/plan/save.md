Save the current plan to a markdown file in `docs/plans/new/`.

1. **Identify the plan** — use the plan from the current conversation context. If none is clear, ask the user to describe the plan before proceeding.

2. **Choose a filename** — derive a short kebab-case name from the plan's subject (e.g. `plan-add-user-auth.md`). If a file with that name already exists, choose a different name.

3. **Write the file** — save to `docs/plans/new/<filename>`. Structure the content as:

```
# <Plan Title>

## Overview
<One paragraph describing the intent>

## Steps
<Numbered list of implementation steps. When the change needs documentation, step 1 is write documentation (then STOP and wait for human approval; revise later steps if the human revises the docs) and the last step is update documentation to match the final code.>

## Unit Tests
<Unit tests to write or update>

## Smoke Tests
<Smoke tests to write or update>

## Verify
<Concrete checks to confirm after implementation is complete>

## Notes
<Any decisions and trade-offs, including the human's answers. No open questions.>
```

Before writing the file, make sure the plan can be executed from start to finish with no human intervention, apart from a documentation review stop the human chose: no open question, no step needing anything the rules in force let the agent do only on the human's word (committing, pushing, merging, tagging or releasing, deleting files, changing git configuration and the like), and no step waiting on anything outside the agent's reach (a release, a tag, another person's change). Ask the human now about each one and write the answer into the plan, or restructure the step.

4. **Report** — print the path of the saved file.

## Hard stops

- Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.
- Never save a plan with a step the executing agent cannot finish alone, or with an open question.

## Next

Recommend the developer run:
- `/plan:check`: analyse the saved plan for problems.
