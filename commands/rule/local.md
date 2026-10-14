Write a rule into this project's `CLAUDE.md` and `AGENTS.md`. Running this command is the human asking for that edit.

The rule is one of these, taken from the conversation: the thing the human asked you to do, the thing they made you correct, or the thing they told you to remember. If they typed something after the command, that is the rule.

1. **Work out which rule it is.** If what they typed after the command says it, use that. Otherwise it is the most recent thing in the conversation that is plainly one of the three above. If there is more than one candidate, or none, or you are not sure, ask one question that names each candidate in a short phrase, and wait. Never pick one yourself.

2. **Find the files.** They are at the top of the project: the directory the session was started in, not the subdirectory you happen to be working in. If the rule is only about one repository or package nested inside the project, and that has its own `CLAUDE.md`, ask whether it goes there or at the top. Edit whichever of `CLAUDE.md` and `AGENTS.md` exist there. If neither exists, ask before creating one.

3. **Write the rule as one bullet**, in the human's terms: what to do or not do, and the case it covers. No reasoning they did not give, no examples they did not give, no history of how it came up. If an existing rule already covers it, change that rule instead of adding a second one. Put it where it belongs among the existing rules, and follow the file's own style and its writing rules.

4. **Write the same rule into both files**, so `CLAUDE.md` and `AGENTS.md` say the same thing. Adapt only where they already differ on purpose (a Claude-specific or Cursor-specific line). Do not ask for confirmation first.

5. **Say one line back**: which files were changed. Nothing else.

## Next

Recommend the developer run:
- `/rule:global`: if the rule should apply to every project, not just this one.
