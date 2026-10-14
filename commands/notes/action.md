Action every categorised note in `docs/notes.md`, according to its category.

1. **Read the notes file** (`docs/notes.md` at the top of the project, not one under a repository or package nested inside it). Work only on notes that carry a category. A note with none is left alone, and you say at the end how many were left.

2. **Find where the categories point**, before doing anything:
   - `l` needs the current plan. If plans live in `docs/plans/new/` and there is more than one, ask which. If a plan is broken into step files, an `l` note becomes a new step file and a line in the plan's checklist.
   - `p` needs the project level document, usually a project plan beside the plan. If there is one, `p` notes go into a `## Todo` section in it, created at the top of that document if it is not there. If there is no such document, ask where `p` notes should go.
   - `d` needs the design document. If there is more than one candidate, ask which.
   If any of those is missing or ambiguous, ask one clear question naming the choices, and wait. Never guess where a note goes.

3. **Do the `n` notes now.** Each one is a change to the code, the configuration or the documents, with tests where the project's rules ask for them. Follow the project's own rules for how the work is done.

4. **Write the `l` notes into the plan.** One step per note, unless two notes are the same job, in which case they become one step and both notes say so. A step says what is wrong, what to build, what tests it needs, and what "done" means, in the same form as the plan's existing steps.

5. **Write the `p` notes into the project document**, one entry each, in the human's own terms rather than as a task list.

6. **Write the `d` notes into the design document**, in the section they belong to. If the design has a status or a phase convention, follow it.

7. **Remove every note you actioned or moved** from the notes file, so what is left is what has not been dealt with. Nothing is deleted before the thing it went into exists.

8. **Verify** whatever the `n` notes changed, by whatever the project uses: compile, lint, tests. Report failures rather than working around them.

9. **Report**, in one short list: what was done now, where each moved note went, what was left, and anything you had to ask about.

## Next

Recommend the developer run:
- `/verify`: if the `n` notes changed code.
