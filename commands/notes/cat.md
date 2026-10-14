Categorise the notes in `docs/notes.md`. Categorising only: change nothing else, and start no work.

Show the human one note at a time and take their category code for it. They are deciding where each note goes, not discussing it.

1. **Read the notes file** (`docs/notes.md` at the top of the project, not one under a repository or package nested inside it). Read the notes that carry no category yet. If every note has one, say so and stop.

2. **Read the categories** from the `## Categories` section at the top of the notes file. Each one is a list item giving its code, a short description and what is done with its notes when they are actioned in this project:

   ```
   - **<code>**: <short description>. When actioned: <what is done with the note>.
   ```

   The file is the only source of the codes. Never use codes from anywhere else, and never make one up. If the file has no `## Categories` section, or it lists no categories, ask the human for the category codes, a short description of each and the action to take for each when notes are actioned, and wait. Write what they give, in their words, as the `## Categories` section, after the file's heading and opening sentence and before `## Notes`. Then carry on.

3. **Show one note, with its number and the total**, exactly as written. Nothing else: no analysis, no suggestion, no plan for it. Under it, print every category from the file, exactly as written there, every time, because nobody remembers them. Then wait. Never ask for the code with the codes alone: the descriptions go with them on every note.

4. **Take the code** they answer with. Anything else they type is about that note, so answer it briefly and show the note and the categories again. A code that is not in the file is not accepted: say so and show the note and the categories again. If they want a new category, ask for its short description and its action, add it to `## Categories`, then use it. A note they say to drop is deleted from the file.

5. **Write the category onto the note** in the file, as `**<code>**` at the end of the line, before moving to the next note. If they correct an earlier one, change it.

6. **Move to the next note** and repeat until they are all categorised.

7. **Report the tally**: how many of each. Do not start on them.

## Next

Recommend the developer run:
- `/notes:action`: action the categorised notes.
