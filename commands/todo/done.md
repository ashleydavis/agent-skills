Remove a finished item from `todo.md`. Change nothing else, and start no work.

The human typed the item's number after the command: its number in `/todo:list`, counting the items under `## Todo` from 1 in the order they appear in the file.

1. **Read the todo file** (`todo.md` at the top of the project, not one under a repository or package nested inside it). If there is none, or it holds no items, say so in one line and stop.

2. **Find the item.** If no number was given, or it matches no item, print the numbered list as `/todo:list` does and ask which one. Never pick one yourself.

3. **Show the item** exactly as written and ask the human to confirm it is the one to remove. Wait for the answer.

4. **Remove that item only.** Leave every other item, the heading and the order as they are.

5. **Say one line back**: which item was removed. Nothing else.

## Next

Recommend the developer run:
- `/todo:list`: see what is left.
