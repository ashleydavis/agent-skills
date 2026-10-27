Analyse the current plan for problems. 

Follow `~/agent-config/rules/planning.md`.

Use the plan from the current conversation. If there is none and `docs/plans/new/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose: you need to know nothing about the plans to list them. Once they have chosen, read that plan only.

Check each of the following and report findings under labelled headings:

**Missing** — Are there steps that are implied but not stated? Dependencies not accounted for? Edge cases ignored?

**Inconsistencies** — Do any steps contradict each other? Are names, types, or interfaces used inconsistently across steps?

**Issues** — Are there technical problems, flawed assumptions, or approaches likely to cause bugs?

**Tests** — Are unit tests and integration tests called out for each new or changed function? Are edge cases covered?

**Docs** — If the change has a documented surface, is the first step write documentation (with a stop for human approval before later steps), and is the last step update documentation to match the final code? If the change has no documented surface, are both documentation steps absent? Are remaining plan steps required to be revised if the human revises the documentation?

**Human intervention** — Can the plan be executed from start to finish with no human intervention, apart from a documentation review stop the human chose? List every open question, every step needing something the rules in force let the agent do only on the human's word (committing, pushing, merging, tagging or releasing, deleting files, changing git configuration and the like), and every step waiting on something outside the agent's reach (a release, a tag, another person's change). 

**THE PLAN FAILS THIS CHECK IF IT HAS ANY OF THE FOLLOWING. EACH ONE IS AN ISSUE THAT MUST BE FIXED BEFORE THE PLAN IS IMPLEMENTED:**
- A stop, a question, or any step or note that requires a human.
- A note telling the agent what it cannot do, or to report, wait or stop.
- A dependency on a release, tag, push or anything else outside the agent's reach. Dependencies across repositories must be taken locally.
- A mechanism the plan relies on that was not checked against the code or by running it.
- An existing test or script that depends on something the plan removes or changes and that the plan does not deal with.
- A Verify check that cannot run on this machine and is not named CI-only.
- A commit, push, release, tag, publish, workflow run or any other external action not stamped "requested explicitly by the human", or one that is not in the "Release" step, second to last.
- A deletion of anything, real or temporary, anywhere but the "Clean up" step, the very last step.

**Security** — Are there injection risks, auth gaps, secrets handling issues, or other OWASP-class problems introduced by the plan?

For each heading, list findings as bullet points. If nothing was found for a category, write "None identified." Do not suggest fixes — only report findings.

Make a numbered list of issues and put them at the top of the plan under an "Issues" section. Each issue should have a checked box so we can check them off as we work through and address them.


## Next

Recommend the developer run:
- `/plan:fix`: if problems were found.
- `/plan:imp` (or `/plan:break` first): if the plan is clean.
