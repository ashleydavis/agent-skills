Check code for breaches of the global coding rules, using subagents. Report only: change no file.

What to check is given after the command as paths. With none, check every file changed on the current branch against the trunk, plus every uncommitted and untracked file (read with read-only git commands only).

1. **Pick the rules.** Read the project's root marker files (`package.json`, `tsconfig.json`, `bun.lock`, `build.zig`, `build.zig.zon`). From the rules files of the agent-config repository (https://github.com/ashleydavis/agent-config, read from the local clone), choose every one that applies: `rules/general.md` always; `rules/writing.md` always (comments, displayed text, docs); `rules/typescript.md` for TypeScript; `rules/bun.md` for a Bun project; `rules/react.md` for React; `rules/zig.md` for Zig. Add the project's own `CLAUDE.md` and `AGENTS.md`.

2. **Split the files.** List every file to check. Split them into groups of at most eight, keeping a source file with its test file. Each group's rules are the ones that apply to its languages.

3. **Check in parallel.** Start one subagent per group, all at once. Give each: the absolute paths of its rules files, which it must read in full before anything else; its files; and this instruction: "Check every line of every file against every rule, one rule at a time. Report each breach as `file:line`, the rule broken (quoted), and what is wrong. Report a rule you could not check and why. Change no file. Run no command that writes." A file a rule does not cover is not reported against it.

4. **Check the checkers.** Start a second round of subagents over the same groups, each told what the first round reported for its group and asked only for breaches the first round missed. Earlier audits have missed breaches, so this round is not skipped.

5. **Report.** One table per file: line, rule, what is wrong. Then a count per rule. Nothing else: no fixes, no plan.

## Next

Recommend the developer run:
- `/rules:fix`: to fix every breach found.
