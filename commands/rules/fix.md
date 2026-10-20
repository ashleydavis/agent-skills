Fix every breach of the global coding rules, using subagents. Running this command is the human asking for those edits.

What to fix is given after the command as paths. With none, fix every file changed on the current branch against the trunk, plus every uncommitted and untracked file (read with read-only git commands only).

1. **Pick the rules.** Read the project's root marker files (`package.json`, `tsconfig.json`, `bun.lock`, `build.zig`, `build.zig.zon`). From the rules files of the agent-config repository (https://github.com/ashleydavis/agent-config, read from the local clone), choose every one that applies: `rules/general.md` always; `rules/writing.md` always (comments, displayed text, docs); `rules/typescript.md` for TypeScript; `rules/bun.md` for a Bun project; `rules/react.md` for React; `rules/zig.md` for Zig. Add the project's own `CLAUDE.md` and `AGENTS.md`.

2. **Split the files.** List every file to fix. Split them into groups of at most eight, keeping a source file with its test file. No file is in two groups.

3. **Fix in parallel.** Start one subagent per group, all at once. Give each: the absolute paths of its rules files, which it must read in full before anything else; its files, which are the only files it may edit; and this instruction: "Check every line of every file against every rule, one rule at a time, and fix every breach. Keep behaviour the same. Do not change a name or signature that a file outside your group uses; report it instead. Every function you add or change gets a unit test, and coverage of your files does not drop. Create no scratch files. Run the build and the tests of your files and fix what fails. Report each fix as `file:line` and the rule, and each breach left with the reason."

4. **Check the fixes.** Start a second round of subagents over the same groups, read only, each asked for every breach still in its files. Hand what they find to a third round that fixes it, and repeat until a check round finds nothing. Earlier audits have missed breaches, so the check round is never skipped.

5. **Verify.** Run the project's build and the tests of every changed file, and read the result. Fix any failure and run them again until they pass.

6. **Report.** Per file, what was fixed (line and rule). Every breach left, with the reason it could not be fixed (a name another file uses, a decision only the human can make). The build and test commands run and what they reported.

## Next

Recommend the developer run:
- `/rules:check`: to confirm nothing was missed.
- `/commit:detz`: to produce a commit message.
