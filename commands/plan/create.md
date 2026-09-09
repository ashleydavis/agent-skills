Create a new plan and save it to `docs/plans/`.

**Important:** You are drafting this plan for an AI agent (Claude) to execute later, not for a human. Do not write steps a human would follow. Write steps as precise AI actions: file edits, function changes, tool calls, and code modifications with exact file paths and names.

1. **Gather intent** — if the user has described the feature or change in this conversation, use that. Otherwise ask: "What do you want to plan?" Wait for their answer before continuing.

2. **Ask whether the plan starts with documentation.** Ask the human this question and wait for the answer before drafting anything: "Should step 1 of this plan write the documentation and stop for your review?"

    - **Yes:** the plan starts with a documentation step that stops for review, and ends with a documentation-update step.
    - **No:** no documentation step at the front and no review stop anywhere. Implementation begins at step 1 and the documentation is written as the last step.

    Ask it once and do not answer it yourself. A review stop makes the plan unexecutable until the human comes back to it, so whether to pay that cost is theirs to decide, not something to infer from the change touching a document.

3. **Research** — explore the relevant parts of the codebase to understand the current structure, affected files, and any existing patterns that the plan should follow. Use file reads, grep, and directory listings as needed.

4. **Draft the plan** — produce a complete plan using the structure below. Be specific: name actual files, functions, types, and interfaces. Steps should be small enough to implement one at a time. **Write all steps as instructions for an AI agent to execute, not a human** — steps should describe precise code changes, file edits, and tool actions, not manual UI interactions or things a person would do. Plans may include interface, class, and function signatures where helpful. Do not include actual implementation code unless describing a particularly difficult algorithm. Requirements should be described as text or bullet points, not code.

    **Documentation steps.** The answer given in step 2 decides these, not your own reading of whether the change touches a document.

    - **The human said yes.** The plan's first step drafts the documentation for the change as it is intended to work, naming the actual doc files to create or update, so the human can read it and understand what they are getting before any code is written. That step must tell the executing agent to STOP when the draft is written: do not continue to later steps. Wait for the human to review and approve it. They may revise it, and those revisions must be reflected as revisions to the remaining plan steps before implementation continues. The plan's last step then updates that documentation to match what was actually built.
    - **The human said no.** The plan has no documentation step at the front and no stop anywhere in it. Step 1 is the first implementation step, and the last step writes the documentation, naming the actual doc files to create or update and what each has to say.
    - **Either way the plan ends with a documentation step**, unless the change has no documented surface at all (an internal-only refactor, for example), in which case leave it out and say why in Notes.

```
# <Plan Title>

## Overview
<One paragraph describing the intent and why the change is needed>

## Issues
<Leave empty — populated later by plan:check>

## Steps
<Numbered list of concrete implementation steps, each naming the file and function to change. Where the human asked for a documentation review, step 1 is write documentation (then STOP and wait for their approval; revise later steps if they revise the docs) and the last step updates it to match the final code. Where they did not, step 1 is the first implementation step, nothing in the plan stops, and the last step writes the documentation. Each step that produces code must require that the code compiles (or type-checks / builds cleanly for the language) and that tests pass before it is complete: every new or changed function gets a unit test, and behaviour gets an e2e/smoke test where possible. Exception: React components, contexts, and hooks are not unit tested but must be covered by an e2e test.>

## Unit Tests
<List of unit tests to write or update — one per new or changed function. Every function must have a unit test. Exception: React components, contexts, and hooks are not unit tested (cover them with end-to-end tests instead).>

## Smoke Tests
<List of end-to-end checks, preferably captured as automated tests in a shell script. Where possible every behaviour should be covered by an end-to-end or smoke test. React components, contexts, and hooks must be covered here since they are not unit tested.>

## Verify
<Concrete, observable checks the AI agent can run after implementation. Must always include: the code compiles (or type-checks / builds cleanly for the language), all unit tests pass, and all smoke/e2e tests pass.>

## Notes
<Decisions, trade-offs, open questions, or constraints discovered during research>
```

5. **Choose a filename** — derive a short kebab-case name from the plan subject (e.g. `plan-add-user-auth.md`). If a file with that name already exists in `docs/plans/new/`, choose a different name.

6. **Save** — write the plan to `docs/plans/new/<filename>`.

7. **Report** — print the path of the saved file and a one-line summary of what the plan covers.

## Hard stops

- Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.

## Next

Recommend the developer run:
- `/plan:check`: analyse the new plan for problems.
- `/plan:simp`: if the plan looks over-engineered, propose simplifications.
