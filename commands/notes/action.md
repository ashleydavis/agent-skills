Action every categorised note in `docs/notes.md`, according to its category.

1. **Read the notes file** (`docs/notes.md` at the top of the project, not one under a repository or package nested inside it). Work only on notes that carry a category. A note with none is left alone, and you say at the end how many were left.

2. **Read the categories** from the `## Categories` section at the top of the notes file. Each one says, after `When actioned:`, what is done with the notes that carry its code. That is the only source of what to do: never act on a note from what its code might mean elsewhere. If the file has no `## Categories` section, ask the human for the category codes, a short description of each and the action to take for each, wait, and write what they give, in their words, as the `## Categories` section, after the file's heading and opening sentence and before `## Notes`. If a note carries a code the section does not list, ask what to do with it.

3. **Find where each action points**, before doing anything: the plan, document or file it names. If a plan is meant and there is more than one in `docs/plans/new/`, ask which. If anything an action names is missing or ambiguous, ask one clear question naming the choices, and wait. Never guess where a note goes.

4. **Action each note by its category's action.**
   - A note that changes the code, the configuration or the documents is done with tests where the project's rules ask for them, following the project's own rules for how the work is done.
   - A note that goes into a plan becomes one step, unless two notes are the same job, in which case they become one step and both notes say so. A step says what is wrong, what to build, what tests it needs and what "done" means, in the same form as the plan's existing steps. If the plan is broken into step files, the step is a new step file and a line in the plan's checklist.
   - A note that goes into any other document becomes one entry, in the human's own terms, in the section it belongs to. If the document has a status or a phase convention, follow it.

5. **Remove every note you actioned or moved** from the notes file, so what is left is what has not been dealt with. Nothing is deleted before the thing it went into exists. Leave `## Categories` as it is.

6. **Verify** whatever the notes changed in code or configuration, by whatever the project uses: compile, lint, tests. Report failures rather than working around them.

7. **Report**, in one short list: what was done, where each moved note went, what was left, and anything you had to ask about.

## Next

Recommend the developer run:
- `/verify`: if any note changed code.
