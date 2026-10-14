Take a note. Record it in `docs/notes.md` and change nothing else.

The note is what the human typed after the command. Record it, do not act on it, and do not start work it implies.

1. **Find the notes file.** There is one per project, and it is `docs/notes.md` at the top of the project: the directory the session was started in, not the subdirectory you happen to be working in. A project can hold several repositories or packages, and each of those can have a `docs/` of its own; those are not where notes go. Look for an existing `docs/notes.md` first and append to that one. Only when there is none do you create it, at the top of the project, with a heading and one sentence saying what it holds: notes taken during work, each one waiting to be categorised. Never start a second notes file because the note is about code in a subdirectory: say where that code is in step 3 instead.

2. **Write the note down, in the human's words.** Correct only spelling and obvious slips. Never reword it into your own phrasing, never expand it, never add reasoning or a solution, and never split one note into several.

3. **Add what a later reader needs to understand it**, and nothing more: the file, command, output or state it was about, if the note does not say and the conversation does. One clause, in parentheses, after the note.

4. **Append it** as a list item under a `## Notes` heading, after the notes already there. Keep the order they were taken in.

5. **Say one line back**: that it is noted. Nothing else. Do not summarise the note, do not restate it, and do not offer to act on it.

**You may not write notes of your own.** Only what the human dictates goes in this file. If you think something is worth noting, say so in the conversation and let them decide.

## Next

Recommend the developer run:
- `/notes:cat`: categorise the notes when there are enough of them to work through.
