Add a todo item. Record it in `todo.md` and change nothing else.

The item is what the human typed after the command. Record it, do not act on it, and do not start the work it describes.

1. **Find the todo file.** There is one per project, and it is `todo.md` at the top of the project: the directory the session was started in, not the subdirectory you happen to be working in. A project can hold several repositories or packages; their own directories are not where todo items go. Look for an existing `todo.md` first and append to that one. Only when there is none do you create it, at the top of the project, with a heading and one sentence saying what it holds: work waiting to be done. Never start a second todo file because the item is about code in a subdirectory.

2. **Write the item down verbatim**, exactly as the human typed it. Change nothing: no spelling or grammar fixes, no rewording, no added context, no clause in parentheses, no reasoning or solution, and never split one item into several.

3. **Append it** as a list item under a `## Todo` heading, after the items already there. Keep the order they were added in.

4. **Say one line back**: that it is added. Nothing else. Do not summarise the item, do not restate it, and do not offer to act on it.

**You may not add items of your own.** Only what the human dictates goes in this file. If you think something is worth doing, say so in the conversation and let them decide.

## Next

Recommend the developer run:
- `/todo:list`: see what is on the list.
- `/todos`: work through the list.
