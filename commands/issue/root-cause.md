Find the root cause of a bug, locally, in a temporary experiment copy of the code. I want the root cause, not a fix. Do not propose a fix, only identify and prove the root cause.

What counts as evidence, and what does not, is in `~/agent-config/rules/evidence.md`. Read it before collecting, judging or reporting evidence.

This command works only on this machine. **It is not authorized to run any git command that writes**: no commit, stage, push, branch, worktree, stash, checkout, reset or any other command that changes git state, anywhere. Git may be used read-only (`status`, `log`, `show`, `diff`, `blame`, `archive` and the like). For a failure that happens only in a CI workflow, use `/workflow:root-cause`.

Work only on what shows the failure: the failing test, app, feature, CLI command and code path. Never compile, test or run anything unrelated to it (other platforms, other suites, the full test run, other apps). Doing so wastes time on purpose.

**Print the goal and stop.** Before anything else, name the failure from `$ARGUMENTS` and the conversation (when it cannot be named, ask the one question in step 1 first). Then print this for the human to set, ready to copy, with `<failure>` replaced by a short description of the failure:

```
Find the root cause of <failure>. DO NOT STOP until the root cause is found, proven, and its evidence is saved in the experiment copy. Use git read-only: never run a git command that writes. It is not acceptable to stop for any reason until the root cause is proven and the evidence shows it.
```

Tell the human that setting it keeps you working until the cause is proven. Then end your turn. Do no other work, not even making the experiment copy, until the human has set the goal.

0. **Make the experiment copy**: every experiment happens in a temporary copy of the code the failure is on, made without writing to git. Put it in `.claude/worktrees/tmp-root-cause-<name>/` in the repository (check with `git check-ignore` that git ignores it). Fill it with `git archive HEAD | tar -x -C <copy>`, then bring in the working tree's uncommitted changes with `git diff HEAD | patch -p1 -d <copy>` and copy in any untracked files the failure needs. It is not a git checkout, so run no git command inside it. If it contains a `mise.toml`, run `mise trust` on it without asking and run its commands through `mise exec --`, then install the project's dependencies inside it before proceeding.

   **Work inside that copy for the entire task. This is not optional.** Every experiment, every file edit, every command must happen inside the copy, never in the main repo or any worktree. It is NOT acceptable to make changes anywhere else, not even a small edit, a temporary log, a quick fix, or "just this once". Before you edit or run anything, confirm your working directory is the copy. If you ever notice you are elsewhere, stop immediately and move to the copy.

   Understand the consequences, because YOU have repeatedly broken this rule: if you make ANY change outside the copy, those changes will be summarily reverted without asking you and without consulting you. Your work will be thrown away. And if you keep doing it, your process will be summarily terminated. Use the copy.

   In the copy you may change any code. Diff an experiment against the original with `git diff --no-index <original-file> <copy-file>`, which reads only.

1. **Gather the failure**: get what you need to see the failure. If the problem is already clear from the conversation, use that. Otherwise ask **once**, then stop asking:
   - **If there is a failing test** (unit, integration, smoke, or e2e): ask the developer to paste the output from the failing test so you can identify it.
   - **Otherwise**: ask the user to describe the problem: symptom, expected outcome, wrong behaviour, error message, and how to trigger it.

   This is the only time you may ask a question. Once you have the failure in hand, do not ask anything else. Do not stop until the root cause is found and proven.

2. **Reproduce the problem**: run the relevant test, command, or minimal script that triggers the failure. Confirm you can see the bad behaviour before investigating further. If you cannot reproduce it, report that clearly, say what differs between here and where it fails, and stop.

3. **Explore the codebase**: read the relevant files and trace the call chain.

4. **Experiment, one log entry per experiment**: form a hypothesis about where the fault lives, then test it. Add temporary logs, throw on the suspected bad path, or comment out the suspected faulty code to observe whether the behaviour changes. Repeat with a new hypothesis if the first is disproved. Keep each experiment minimal and targeted. Your code changes are experiments, never fixes, so **do not present any change you make as a fix**. Document every experiment in the experiment log (see "The experiment log" below).

5. **Prove the root cause**: you are not finished until an experiment proves it: the behaviour must change when the suspected cause is present versus removed, and nothing else changes between the two. Once proven, give a precise, single-sentence statement of the root cause. Name the file, function, and line number.

6. **Capture the evidence**: save it in the copy, under `root-cause/`:
   - `README.md`: the failure, the root cause in a sentence or two, the experiment that proves it (what was changed on each side and what happened), and the list of files below with what each shows.
   - The evidence itself: the output of the runs that prove it, before and after, copied in verbatim.
   - The experiment code stays in the copy, and the diff of each experiment is saved beside the log, so the proof can be run again.

7. **Report, evidence first**: come back only when you have evidence of the proven root cause. If you do not have the evidence you are not finished, so keep going. Lead with the evidence:
   - The experiment you ran and its output (before and after), showing the behaviour changing exactly as the root cause predicts. This is the proof, and it must come first.
   - One-sentence root cause statement.
   - File, function, and line number.
   - How you reproduced the original failure (command or test run and its output).
   - Where the full evidence is: the copy's path and `root-cause/README.md`.

## The experiment log

`root-cause/experiments.md` in the copy is the record of the investigation. The human must be able to read it, top to bottom, and know what was tried, why it was tried, and what each experiment told you about the problem.

- One experiment, one numbered entry, written before you run it. It says what the experiment changes, the hypothesis it tests, and what result would confirm or rule that hypothesis out. Save the experiment's code change as `root-cause/experiment-<number>.diff`.
- Once it has run, add its result to the entry: what you ran, what happened (the key lines of output, copied verbatim), and what that tells you about the root cause.
- An experiment that needs no code change still gets an entry, so no result is left unrecorded.

## Next

Recommend the developer run:
- `/issue:prop`: propose fixes for the root cause just found.
