Find the root cause of a bug, locally, in a temporary experiment worktree. I want the root cause, not a fix. Do not propose a fix, only identify and prove the root cause.

What counts as evidence, and what does not, is in `~/agent-config/rules/evidence.md`. Read it before collecting, judging or reporting evidence.

This command works only on this machine. It never pushes. For a failure that happens only in a CI workflow, use `/workflow:root-cause`.

0. **Make the experiment worktree**: every experiment happens in a new worktree on a new branch made for them. It is temporary: it will be removed without being merged. Read the project's instructions for how worktrees are made there and follow them. Otherwise: (1) run `git branch --show-current` to get the current branch, (2) run `git worktree add -b root-cause-<name> .claude/worktrees/root-cause-<name> <current-branch>`, (3) use `EnterWorktree` with the `path` parameter to enter it (if the session is held to another worktree, `ExitWorktree` releases it first), (4) if the worktree contains a `mise.toml`, run `mise trust` inside it without asking and run its commands through `mise exec --`, then install the project's dependencies inside it before proceeding.

   **Work inside that worktree for the entire task. This is not optional.** Every experiment, every file edit, every command must happen inside the worktree, never in the main repo or any other worktree. It is NOT acceptable to make changes anywhere else, not even a small edit, a temporary log, a quick fix, or "just this once". Before you edit or run anything, confirm your working directory is the worktree path. If you ever notice you are elsewhere, stop immediately and move to the worktree.

   Understand the consequences, because YOU have repeatedly broken this rule: if you make ANY change outside the worktree, those changes will be summarily reverted without asking you and without consulting you. Your work will be thrown away. And if you keep doing it, your process will be summarily terminated. Use the worktree.

   In the worktree you may change any code and commit (the pre-commit hook may be skipped there). **Never push**, from the worktree or anywhere else.

1. **Gather the failure**: get what you need to see the failure. If the problem is already clear from the conversation, use that. Otherwise ask **once**, then stop asking:
   - **If there is a failing test** (unit, integration, smoke, or e2e): ask the developer to paste the output from the failing test so you can identify it.
   - **Otherwise**: ask the user to describe the problem: symptom, expected outcome, wrong behaviour, error message, and how to trigger it.

   This is the only time you may ask a question. Once you have the failure in hand, do not ask anything else. Do not stop until the root cause is found and proven.

2. **Reproduce the problem**: run the relevant test, command, or minimal script that triggers the failure. Confirm you can see the bad behaviour before investigating further. If you cannot reproduce it, report that clearly, say what differs between here and where it fails, and stop.

3. **Explore the codebase**: read the relevant files and trace the call chain.

4. **Experiment, one commit per experiment**: form a hypothesis about where the fault lives, then test it. Add temporary logs, throw on the suspected bad path, or comment out the suspected faulty code to observe whether the behaviour changes. Repeat with a new hypothesis if the first is disproved. Keep each experiment minimal and targeted. Your code changes are experiments, never fixes, so **do not present any change you make as a fix**. Document every experiment with commits (see "The commit log" below).

5. **Prove the root cause**: you are not finished until an experiment proves it: the behaviour must change when the suspected cause is present versus removed, and nothing else changes between the two. Once proven, give a precise, single-sentence statement of the root cause. Name the file, function, and line number.

6. **Capture the evidence**: commit into the worktree, under `root-cause/`:
   - `README.md`: the failure, the root cause in a sentence or two, the experiment that proves it (what was changed on each side and what happened), and the list of files below with what each shows.
   - The evidence itself: the output of the runs that prove it, before and after, copied in verbatim.
   - The experiment code stays on the branch, so the proof can be run again.

7. **Report, evidence first**: come back only when you have evidence of the proven root cause. If you do not have the evidence you are not finished, so keep going. Lead with the evidence:
   - The experiment you ran and its output (before and after), showing the behaviour changing exactly as the root cause predicts. This is the proof, and it must come first.
   - One-sentence root cause statement.
   - File, function, and line number.
   - How you reproduced the original failure (command or test run and its output).
   - Where the full evidence is: the worktree path, `root-cause/README.md`, and the branch.

## The commit log

The commit log on the experiment branch is the record of the investigation. The human must be able to read it, oldest first, and know what was tried, why it was tried, and what each experiment told you about the problem.

- One experiment, one commit, made before you run it. Its message says what it changes, the hypothesis it tests, and what result would confirm or rule that hypothesis out.
- The next commit's message starts with the result of the previous experiment: what you ran, what happened (the key lines of output, copied verbatim), and what that tells you about the root cause. Then it describes its own experiment.
- When an experiment's result needs no code change to follow it, record the result in a commit of its own (`git commit --allow-empty`), so no result is left unrecorded.
- The commit that captures the evidence (step 6) starts with the result of the last experiment.

## Next

Recommend the developer run:
- `/issue:prop`: propose fixes for the root cause just found.
