Make a plan ready to be executed by another agent that has only the plan and the repositories: find every gap and fix it in the plan, round after round, until a cold read finds nothing.

Follow `~/agent-config/rules/planning.md`.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

## Steps

1. **Get a cold read.** Start one subagent with no context but this: the plan's absolute path, the absolute paths of the repositories it names, and the instructions below. Pass on nothing from this conversation: the point is to see what an agent that never saw it would find. Tell the subagent to change no file and no git state, and to give it these instructions:
    - Read the plan, then the project's `CLAUDE.md` and `AGENTS.md` files and every rule file they name.
    - Walk the steps in order as if implementing them, without writing anything. For each step, open every file, function, line, type, command, helper and test it names, and check that each one exists in the code, or is made by an earlier step of this plan or by a plan listed under Prerequisites.
    - For each step, list anything the implementer would need and could not find in the plan, the code or the docs: a name that does not exist, a value or behaviour the plan does not state, a choice the plan leaves open, a term it never defines, a reference to a conversation, a decision or "the other plan" with no file named, a "use whatever name it ends up with", a step that depends on a later step, and a command that cannot be run as written.
    - List every place where the plan contradicts itself, the code or the rules.
    - Report each finding with the step number, the exact text and what is missing. Report nothing that is only style.
2. **Check what it found.** Confirm each finding against the plan, the code and the rules. Drop any that is wrong. A choice the human has made, in the conversation or recorded in the plan's Notes, is not a finding.
3. **Fix every confirmed finding in the plan.** Research the code to settle each one, then rewrite the steps, tests, Verify and Notes so the gap is gone: give the missing name, value, command, file or behaviour, correct the line numbers and resolve the contradiction. Follow the template and rules of `/plan:create`.
    - Never log a finding in the Issues section or leave it for later.
    - Never shrink the plan's scope to close a gap: keep every repository, platform, feature and test it covers. Find the way to do it, or name a check that this machine cannot run as CI-only.
    - When a fix needs a decision that changes what users see, the design or the public API, and research cannot settle it, add one short bullet to "Decisions not approved by a human" and write the plan around the choice you recommend.
4. **Repeat.** Go back to step 1 with a new subagent on the fixed plan. Stop when a cold read finds nothing, or after 5 rounds.
5. **Report.** One heading giving the verdict: **Ready** when the last cold read found nothing, otherwise **Not ready**. Then at most 5 bullets: the rounds run, how many findings were fixed, any decision added, and anything not fixed with the reason.

## Next

Recommend the developer run:
- `/plan:decide`: if a decision was added.
- `/plan:imp`: if the plan is ready.
