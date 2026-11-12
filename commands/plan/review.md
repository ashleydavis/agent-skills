Review a completed plan.

Use the plan from the current conversation. If there is none and `docs/plans/done/` holds exactly one plan, use that one without asking, and say which plan it is in one line. Otherwise list the file names in `docs/plans/done/` and `docs/plans/new/`, newest first, as a numbered menu and wait for the user's choice. Read nothing in the repo before they choose. Once they have chosen, read that plan only.

The plan's "Review" section is near the end. It holds a "Review" checklist, a "Reviewed" checklist with the same items, and a "Review issues" section. The "Review" checklist is filled by the implementer's Self Review step. The "Reviewed" checklist is filled by this review. The "Review issues" section holds one bullet per finding, nested under the "Review" checklist item it belongs to.

1. **Read the "Review" section.** Read the "Review" checklist, the "Reviewed" checklist, the "Review issues" section and the plan's "Acceptance criteria".

2. **Check the "Review" checklist is filled.** Every item in the "Review" checklist is ticked `- [x]`. An unticked item means the implementer's Self Review step did not complete the plan's review. That is one finding.

3. **Check the evidence.** The "Review" checklist names the evidence paths: `tmp/evidence/compile`, `tmp/evidence/tests` and `tmp/evidence/acceptance`, in the plan's project. The implementer collects the evidence during the work as each step is done. The Self Review step checks it and does not collect it. The compile and test evidence is a run of the code. The acceptance evidence includes screenshots for GUI apps. Read the evidence. Missing evidence, or evidence that does not show a run, is one finding for each affected item.

4. **Check the code compiles.** Run every command in the plan's "Verify" section that compiles or type-checks the code. Run them from the project's own directory. A command that exits with code 0 has passed. A compile error is one finding.

5. **Check the tests pass.** Run every command in the plan's "Verify" section that runs tests. Run them from the project's own directory. A command that exits with code 0 has passed. A command the "Verify" section names as CI-only cannot run on this machine; it is not a finding. A failing test is one finding.

6. **Check the acceptance criteria.** Check each bullet in the plan's "Acceptance criteria" from scratch. Check the code, the behaviour and the evidence in `tmp/evidence/acceptance`. Do not take the plan's own report as evidence. A bullet that is not met is one finding.

7. **Check the project rules.** Read the project's `CLAUDE.md` and `AGENTS.md` and every rule file they name. Check the work's code against each one. A rule that is not followed is one finding.

8. **Check the global rules.** Read `~/agent-config/rules/general.md`, `writing.md`, `planning.md`, `testing.md` and the rules for the languages in the work. Check the work's code against each one. A rule that is not followed is one finding.

9. **Report the verdict.**
    - **Every question is yes.** Tick every item in the "Reviewed" checklist `- [x]`. Write "None" in the "Review issues" section. Report that the plan passed.
    - **Any question is no.** Exit immediately. Do not fix anything. Write each finding in the "Review issues" section, nested under the "Review" checklist item it belongs to, as an unchecked bullet with what was wrong and the evidence. In the "Reviewed" checklist, put `- [-]` in place of the box of every item that is not met. Report the verdict and the number of findings.

The "Review" checklist items are in `~/agent-config/rules/review-checklist.md`, in order.

This command edits only the "Reviewed" checklist and the "Review issues" section. It never edits the plan's steps, the "Review" checklist, the code or any other file.

Never use em dashes in the plan. Use a period, comma, colon, or parentheses instead.

## Next

Recommend the developer run:
- `/plan:review-fix`: if findings were written.
