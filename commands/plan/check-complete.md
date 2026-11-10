Check whether a plan can be implemented by another agent that has only the plan and the repositories, or whether it is missing context.

Follow `~/agent-config/rules/planning.md`.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

## Steps

1. **Get a cold read.** Start one subagent with no context but this: the plan's absolute path, the absolute paths of the repositories it names, and the instructions below. Pass on nothing from this conversation: the point is to see what an agent that never saw it would find. Tell the subagent to change no file and no git state, and to give it these instructions:
    - Read the plan, then the project's `CLAUDE.md` and `AGENTS.md` files and every rule file they name.
    - Walk the steps in order as if implementing them, without writing anything. For each step, open every file, function, line, type, command, helper and test it names, and check that each one exists in the code, or is made by an earlier step of this plan or by a plan listed under Prerequisites.
    - For each step, list anything the implementer would need and could not find in the plan, the code or the docs: a name that does not exist, a value or behaviour the plan does not state, a choice the plan leaves open, a term it never defines, a reference to a conversation, a decision or "the other plan" with no file named, a "use whatever name it ends up with", a step that depends on a later step, and a command that cannot be run as written.
    - List every place where the plan contradicts itself, the code or the rules.
    - Report each finding with the step number, the exact text and what is missing. Report nothing that is only style.
2. **Check what it found.** For each finding, confirm it against the plan and the code yourself. Drop any that is wrong and say so in one line.
3. **Report.** One heading giving the verdict: **Ready** when nothing is missing, otherwise **Missing context**. Then the confirmed findings as a numbered list, each one line: step, what is missing, where the implementer would have looked. Add each confirmed finding to the plan's "Issues" section as an unchecked box, so `/plan:fix` can work through them, and change nothing else in the plan.

## Next

Recommend the developer run:
- `/plan:fix`: if context is missing.
- `/plan:imp`: if the plan is ready.
