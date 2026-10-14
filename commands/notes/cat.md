Categorise the notes in `docs/notes.md`. Categorising only: change nothing else, and start no work.

Show the human one note at a time and take their letter for it. They are deciding where each note goes, not discussing it.

1. **Read the notes file** (`docs/notes.md` at the top of the project, not one under a repository or package nested inside it). Read the notes that carry no category yet. If every note has one, say so and stop.

2. **Show one note, with its number and the total**, exactly as written. Nothing else: no analysis, no suggestion, no plan for it. Under it, print the four letters and what each one means, every time, because nobody remembers them:

   ```
   n: action now
   l: action later, in the current plan
   p: action later in the project
   d: record it in the design document
   ```

   Then wait. Never ask for the letter with the letters alone (`n`, `l`, `p` or `d`?): the meanings go with them on every note.

3. **Take the letter** they answer with. Anything else they type is about that note, so answer it briefly and show the note and the four letters again. A note they say to drop is deleted from the file.

4. **Write the category onto the note** in the file, as `**n**`, `**l**`, `**p**` or `**d**` at the end of the line, before moving to the next note. If they correct an earlier one, change it.

5. **Move to the next note** and repeat until they are all categorised.

6. **Report the tally**: how many of each. Do not start on them.

## Next

Recommend the developer run:
- `/notes:action`: action the categorised notes.
