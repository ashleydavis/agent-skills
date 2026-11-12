Make a plan ready to be executed by another agent that has only the plan and the repositories: find every gap and fix it in the plan, in one pass.

Follow `~/agent-config/rules/planning.md`.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

## Steps

1. **Read it as the implementer would.**
    - Read the plan, then the project's `CLAUDE.md` and `AGENTS.md` files and every rule file they name.
    - Walk the steps in order as if implementing them, without writing anything. For each step, open every file, function, line, type, command, helper and test it names, and check that each one exists in the code, or is made by an earlier step of this plan or by a plan listed under Prerequisites.
    - For each step, list anything the implementer would need and could not find in the plan, the code or the docs: a name that does not exist, a value or behaviour the plan does not state, a choice the plan leaves open, a term it never defines, a reference to a conversation, a decision or "the other plan" with no file named, a "use whatever name it ends up with", a step that depends on a later step, and a command that cannot be run as written.
    - List every place where the plan contradicts itself, the code or the rules.
    - Skip anything that is only style. A choice the human has made, in the conversation or recorded in the plan's Notes, is not a finding.
2. **Confirm each finding** against the plan, the code and the rules before changing anything. Drop any that is wrong.
3. **Fix every confirmed finding in the plan.** Research the code to settle each one, then rewrite the steps, tests, Verify, Review and Notes so the gap is gone: give the missing name, value, command, file or behaviour, correct the line numbers and resolve the contradiction. Follow the template and rules of `/plan:create`. The order is Verify, then Self Review, then Clean up, then External actions. The Self Review checks the "Review" checklist copied from `~/agent-config/rules/review-checklist.md`.
    - Never log a finding in the Issues section or leave it for later.
    - Never shrink the plan's scope to close a gap: keep every repository, platform, feature and test it covers. Find the way to do it, or name a check that this machine cannot run as CI-only.
    - When a fix needs a decision that changes what users see, the design or the public API, and research cannot settle it, add one short bullet to "Decisions not approved by a human" and write the plan around the choice you recommend.
4. **Report.** One heading giving the verdict: **Ready** when every finding was fixed, otherwise **Not ready**. Then at most 5 bullets: how many findings were fixed, any decision added, and anything not fixed with the reason.

## Next

Recommend the developer run:
- `/plan:decide`: if a decision was added.
- `/plan:imp`: if the plan is ready.
