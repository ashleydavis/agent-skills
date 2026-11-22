Find the root cause of a bug, locally, in the checkout the failure is on. I want the root cause, not a fix. Do not propose a fix, only identify and prove the root cause.

What counts as evidence, and what does not, is in `~/agent-config/rules/evidence.md`. Read it before collecting, judging or reporting evidence.

This command works only on this machine. **It is not authorized to run any git command that writes**: no commit, stage, push, branch, worktree, stash, checkout, reset or any other command that changes git state, anywhere. Git may be used read-only (`status`, `log`, `show`, `diff`, `blame`, `archive` and the like). For a failure that happens only in a CI workflow, use `/workflow:root-cause`.

Work only on what shows the failure: the failing test, app, feature, CLI command and code path. Never compile, test or run anything unrelated to it (other platforms, other suites, the full test run, other apps). Doing so wastes time on purpose.

**Print the goal and stop.** Before anything else, name the failure from `$ARGUMENTS` and the conversation (when it cannot be named, ask the one question in step 1 first). Write and print every goal by the rules in `~/agent-config/rules/goals.md`. Then print this for the human to set, ready to copy, with `<failure>` replaced by a short description of the failure:

```
Find the root cause of <failure>. This is achieved when the transcript shows, after the last edit: the failure reproduced; one experiment run with the suspected cause present, showing the failure, and with only that cause removed, not showing it; `tmp/root-cause/README.md` naming the cause's file, function and line; both runs' output saved in `tmp/root-cause/`. Stopping for any reason other than achieving this is unacceptable.
```

Tell the human that setting it keeps you working until the cause is proven. Then end your turn. Do no other work until the human has set the goal.

0. **Work in the checkout the failure is on**: every experiment happens in the checkout or worktree where the failure was seen. It is not acceptable to make a copy of the code: no `git archive`, no copied directory, no new worktree. If the checkout contains a `mise.toml`, run its commands through `mise exec --`.

   Before the first experiment, run `git status` and keep the list of files that were already changed, so the checkout's own uncommitted work is never mistaken for an experiment. Each experiment's edits are temporary: save their diff (`git diff -- <file>`, which reads only), then undo them by editing the files back, never with a git command. When you finish, no experiment edit is left in the checkout, and the files changed before you started are exactly as they were.

   Evidence goes in `tmp/root-cause/` in the checkout. Check with `git check-ignore` that git ignores it, and if it does not, add `tmp/` to `.gitignore` first.

1. **Gather the failure**: get what you need to see the failure. If the problem is already clear from the conversation, use that. Otherwise ask **once**, then stop asking:
   - **If there is a failing test** (unit, integration, smoke, or e2e): ask the developer to paste the output from the failing test so you can identify it.
   - **Otherwise**: ask the user to describe the problem: symptom, expected outcome, wrong behaviour, error message, and how to trigger it.

   This is the only time you may ask a question. Once you have the failure in hand, do not ask anything else. Do not stop until the root cause is found and proven.

2. **Reproduce the problem**: run the relevant test, command, or minimal script that triggers the failure. Confirm you can see the bad behaviour before investigating further. If you cannot reproduce it, report that clearly, say what differs between here and where it fails, and stop.

3. **Explore the codebase**: read the relevant files and trace the call chain.

4. **Experiment, one log entry per experiment**: form a hypothesis about where the fault lives, then test it. Add temporary logs, throw on the suspected bad path, or comment out the suspected faulty code to observe whether the behaviour changes. Repeat with a new hypothesis if the first is disproved. Keep each experiment minimal and targeted. Your code changes are experiments, never fixes, so **do not present any change you make as a fix**. Document every experiment in the experiment log (see "The experiment log" below).

5. **Prove the root cause**: you are not finished until an experiment proves it: the behaviour must change when the suspected cause is present versus removed, and nothing else changes between the two. Once proven, give a precise, single-sentence statement of the root cause. Name the file, function, and line number.

6. **Capture the evidence**: save it in `tmp/root-cause/`:
   - `README.md`: the failure, the root cause in a sentence or two, the experiment that proves it (what was changed on each side and what happened), and the list of files below with what each shows.
   - The evidence itself: the output of the runs that prove it, before and after, copied in verbatim.
   - The diff of each experiment, saved beside the log, so the proof can be run again after the edits are undone.

7. **Report, evidence first**: come back only when you have evidence of the proven root cause. If you do not have the evidence you are not finished, so keep going. Lead with the evidence:
   - The experiment you ran and its output (before and after), showing the behaviour changing exactly as the root cause predicts. This is the proof, and it must come first.
   - One-sentence root cause statement.
   - File, function, and line number.
   - How you reproduced the original failure (command or test run and its output).
   - Where the full evidence is: `tmp/root-cause/README.md` in the checkout.

## The experiment log

`tmp/root-cause/experiments.md` is the record of the investigation. The human must be able to read it, top to bottom, and know what was tried, why it was tried, and what each experiment told you about the problem.

- One experiment, one numbered entry, written before you run it. It says what the experiment changes, the hypothesis it tests, and what result would confirm or rule that hypothesis out. Save the experiment's code change as `tmp/root-cause/experiment-<number>.diff`.
- Once it has run, add its result to the entry: what you ran, what happened (the key lines of output, copied verbatim), and what that tells you about the root cause.
- An experiment that needs no code change still gets an entry, so no result is left unrecorded.

## Next

Recommend the developer run:
- `/issue:prop`: propose fixes for the root cause just found.
