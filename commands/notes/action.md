Action every categorised note in `docs/notes.md`, according to its category.

1. **Read the notes file** (`docs/notes.md` at the top of the project, not one under a repository or package nested inside it). Work only on notes that carry a category. A note with none is left alone, and you say at the end how many were left.

2. **Read the categories** from the `## Categories` section at the top of the notes file. Each one says, after `When actioned:`, what is done with the notes that carry its code. That is the only source of what to do: never act on a note from what its code might mean elsewhere. If the file has no `## Categories` section, ask the human for the category codes, a short description of each and the action to take for each, wait, and write what they give, in their words, as the `## Categories` section, after the file's heading and opening sentence and before `## Notes`. If a note carries a code the section does not list, ask what to do with it.

3. **Find where each action points**, before doing anything: the plan, document or file it names. If a plan is meant and there is more than one in `docs/plans/new/`, ask which. If anything an action names is missing or ambiguous, ask one clear question naming the choices, and wait. Never guess where a note goes.

4. **Action the notes one at a time, with the human's approval on each.** Never work on more than one note at once and never start the next one on your own. For each note in turn: show it with its number and the total, say in a few lines what you will do for it, and wait for the human to approve. Then do that note alone, verify it (step 6), remove it from the notes file (step 5), report what changed in one or two lines, and stop until the human says to go on. If they say to change the approach, change it and ask again before doing anything.

   **Stop after every note.** Once a note is actioned, dropped or moved, end your turn with the one or two line report. Do not show the next note, do not read, search or research anything for it, and do not propose what you would do with it. A note the human drops counts as actioned: remove it, report it, stop. Only when the human says to go on do you show the next note. Finishing one note is never permission to start the next.

   Each note is actioned by its category's action:
   - A note that changes the code, the configuration or the documents is done with tests where the project's rules ask for them, following the project's own rules for how the work is done.
   - A note that goes into a plan becomes one step, unless two notes are the same job, in which case they become one step and both notes say so. A step says what is wrong, what to build, what tests it needs and what "done" means, in the same form as the plan's existing steps. If the plan is broken into step files, the step is a new step file and a line in the plan's checklist.
   - A note that goes into any other document becomes one entry, in the human's own terms, in the section it belongs to. If the document has a status or a phase convention, follow it.

5. **Remove every note you actioned or moved** from the notes file, so what is left is what has not been dealt with. Nothing is deleted before the thing it went into exists. Leave `## Categories` as it is.

6. **Verify** whatever the notes changed in code or configuration, by whatever the project uses: compile, lint, tests. Report failures rather than working around them.

7. **Report**, once the last note is done, in one short list: what was done, where each moved note went, what was left, and anything you had to ask about.
