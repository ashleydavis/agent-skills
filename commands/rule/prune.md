Prune this project's agent instruction files: remove every rule that duplicates or conflicts with the global instructions, then go through the low value rules with the human one at a time. Running this command is the human asking for those edits.

The agent instruction files are the project's `CLAUDE.md` and `AGENTS.md` and any other file written only for agents. User and developer facing documentation (`README.md`, `docs/`, guides) is never changed, even where it repeats a rule.

1. **Read both sides.** Read every agent instruction file in the project. Read the project's root marker files, then every global rules file the global instructions point to that applies to this project. The global instructions themselves are already in your context.

2. **Remove duplicates and conflicts.** A rule is a duplicate when a global rule already says it. A rule conflicts when it says something different from a global rule. Remove both kinds. Where a line is only partly a duplicate, cut it down to the part that is specific to this project. Where a section is left empty, remove its heading. Keep `CLAUDE.md` and `AGENTS.md` saying the same thing.

3. **Report the removals.** One bullet per removed or cut line, naming the global rule that covers it. Name each conflict and say which global rule now applies in its place.

4. **Find the low value rules.** A rule is low value when a tool already enforces it (the compiler, a linter, the pre-commit hook), when it explains instead of instructing, when it only restates another rule in the same file, when a project document agents must follow already requires it (such as a contract or a spec), or when it belongs in user or developer documentation instead of agent instructions. Also count a rule that breaks a global rule in a way step 2 missed. A rule whose wording a reader cannot follow is not low value: rewrite it so it says what to do.

5. **Go through them one at a time.** For each one, ask one question that quotes the rule with its `file:line`, says in one sentence why it is low value and offers each choice: remove it, cut it down (quoting what is left) or keep it. Wait for the answer. Apply it, then move to the next. Never batch them.

6. **Use the human's words.** When the human restates a rule in their own words, rewrite the rule in those words.

7. **Check the file.** Read every changed file in full. Put back any blank line an edit removed (before each heading, between rules). Look again for rules that steps 2 and 4 now catch because of the edits, and take each through step 5.

8. **Say one line back** when the last one is done: which files were changed.
