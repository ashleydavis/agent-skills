Write a rule into the global `CLAUDE.md` and `AGENTS.md`, the instruction files read in every project. Running this command is the human asking for that edit, and the only thing that permits it.

The rule is one of these, taken from the conversation: the thing the human asked you to do, the thing they made you correct, or the thing they told you to remember. If they typed something after the command, that is the rule.

1. **Work out which rule it is.** If what they typed after the command says it, use that. Otherwise it is the most recent thing in the conversation that is plainly one of the three above. If there is more than one candidate, or none, or you are not sure, ask one question that names each candidate in a short phrase, and wait. Never pick one yourself.

2. **Find the files.** The global `CLAUDE.md` in Claude's config directory and the global `AGENTS.md` in Cursor's config directory are symlinks into the agent-config repository, at `home/.claude/CLAUDE.md` and `home/.cursor/AGENTS.md`. Resolve each symlink with `readlink -f` and edit the file it points at. Never write through the home-directory path: that replaces the symlink with a plain file and takes the change out of version control.

3. **Write the rule as one bullet**, in the human's terms: what to do or not do, and the case it covers. No reasoning they did not give, no examples they did not give, no history of how it came up. If an existing rule already covers it, change that rule instead of adding a second one. Put it where it belongs among the existing rules, and follow the file's own style and its writing rules.

4. **Write the same rule into both files**, so `CLAUDE.md` and `AGENTS.md` say the same thing. Adapt only where they already differ on purpose (a Claude-specific or Cursor-specific line). Change nothing else in either file. Do not ask for confirmation first.

5. **Say one line back**: which files were changed. Commit nothing.

## Next

Recommend the developer run:
- `/rule:local`: if the rule belongs to this project only.
