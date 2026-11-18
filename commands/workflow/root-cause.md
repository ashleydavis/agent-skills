---
description: Find, prove and capture the evidence of the root cause of a failed CI workflow, in a temporary experiment worktree, without fixing it. Ends with a summary and up to five fix options.
---

# Find the root cause of a failed workflow

What counts as evidence, and what does not, is in `~/agent-config/rules/evidence.md`. Read it before collecting, judging or reporting evidence.

The human gives you a failed workflow: `$ARGUMENTS` (a run, a job in a run, or a workflow's page). Find the root cause of the failure, prove it, and capture the evidence. Do not fix it.

## 1. Print the goal and stop

Read the failed run just far enough to name it (workflow, run, failing job). Then print this for the human to set, ready to copy, with `<run>` replaced by the run's link and `<job>` by the failing job: Write and print every goal by the rules in `~/agent-config/rules/goals.md`.

```
Find the root cause of the failure of <job> in <run>. This is achieved when the root cause is proven and its evidence is committed into the experiment worktree. Stopping for any reason other than achieving this is unacceptable.
```

Tell the human that setting it keeps you working until the cause is proven. Then end your turn. Do no other work until the human has set the goal.

## Rules

- All experiments happen in a new worktree on a new branch made for them. It is temporary: it will be removed without being merged. In it you may change any code, run anything locally, commit (the pre-commit hook may be skipped there) and push to run experiments in the workflows.
- Never change the branch the failure is on, or any other branch or worktree, and never touch the main checkout.
- Make no fix. Change only what you need to reproduce the failure, prove its cause and capture the evidence. Every such change stays on the experiment branch.
- Never guess. A cause is a claim until an experiment shows it. Say "I think" or "the evidence suggests" until then.
- Do not waste time or CI minutes. An experiment does the least that answers its question and nothing more.
- Work only on what shows the failure: the failing job, test, app, feature and code path. Never compile, test or run anything unrelated to it (other platforms, other suites, the full test run, other apps). Doing so wastes time on purpose.
- Document every experiment with commits on the experiment branch (see "The commit log" below).
- For a failure that also happens on this machine, `/issue:root-cause` does the same locally and never pushes.

## The commit log

The commit log on the experiment branch is the record of the investigation. The human must be able to read it, oldest first, and know what was tried, why it was tried, and what each experiment told you about the problem.

- One experiment, one commit, made before you run it or push it. Its message says what it changes, the hypothesis it tests, and what result would confirm or rule that hypothesis out.
- The next commit's message starts with the result of the previous experiment: what ran (locally, or the CI run's link), what happened (the key lines of output, copied verbatim), and what that tells you about the root cause. Then it describes its own experiment.
- When an experiment's result needs no code change to follow it, record the result in a commit of its own (`git commit --allow-empty`), so no result is left unrecorded.
- The commit that captures the evidence (step 7) starts with the result of the last experiment.

## 2. Make the experiment worktree

However it is made, the worktree's directory name and its branch both start with `tmp-root-cause-`, so they are known as temporary and `/worktree:clean-tmp` removes them, along with the branch on the remote. Read the project's instructions for how worktrees are made there and follow them. Otherwise branch from the commit that failed: `git worktree add -b tmp-root-cause-<something> <worktrees-dir>/tmp-root-cause-<something> <failed-commit>`, then enter it. If the session is held to another worktree, `ExitWorktree` releases it. Run whatever the project needs before it builds (trust its `mise.toml`, install dependencies).

## 3. Read the failure

- Get the failing line, not the job that reported it: the step, the test, and the log around it. A test that gave up waiting reports where it gave up, not what went wrong.
- Find out whether it has failed before: list the workflow's recent runs, and for each failed one read which job and which test failed, grouped by cause.
- Decide whether it is constant or intermittent. A failure in every run since a point is a break; one in some runs is intermittent and needs many runs per experiment to call a result (state the number before you start, such as "10 passes in a row is good, any failure is bad").
- Compare the failed run with the last green run of the same job: the commit, the runner image (`Image:` and `Version:` at the top of each job's log), the tool versions the setup steps printed, and how long each test took. A change between them that is not in the code (a new runner image, a new package version) is often the cause.

## 4. Reproduce it locally if you can

- Copy what the runner has, not what your machine has: its environment variables, the services it has and lacks, its OS image. A local run that passes proves nothing until it matches the runner in the respect that matters.
- If it reproduces, find the cause locally: instrument, narrow, and repeat. Local runs are cheap.
- If it does not reproduce, say why it does not (what differs from the runner), then go to step 5.

## 5. Otherwise, experiment in the workflow

- Put each experiment in a workflow of its own on the experiment branch, and delete every other workflow on that branch, so a push runs the experiment and nothing else. Cancel any other run a push still starts.
- An experiment runs only what answers its question: one job, the build it needs, the one failing test, run as many times as the question needs. Build once, run many times. Build only the target the test uses.
- Gut the experiment workflow of every command, action, step and job the experiment does not need. Copy from the real workflow only the steps the failing test cannot run without, and cut anything that does not help find or prove the root cause.
- Give `actions/checkout` full commit hashes; a short one fails.
- Cancel the run as soon as the experiment has given its result. Letting a run go on longer than the result needs wastes time on purpose. A job's log can be read only once the job has finished, so when the step you need has run, cancel the rest of the run and read the log.
- Make the evidence readable from the log: timestamps on the lines that matter, the tool's own tracing (such as `G_DBUS_DEBUG`, `strace`, `adb logcat`), the environment printed before the test.
- To find the commit that broke it, bisect between the last good commit and the first bad one, testing several commits in parallel per round when a round is slow. First check that the experiment fails on a commit known to be bad; a reproducer that passes there cannot bisect.

## 6. Prove it

The cause is proven only when an experiment shows both sides of it: with the cause present the failure happens, and with only the cause taken away (or only the cause added) it does not. One run is enough for a constant failure; an intermittent one needs the number of runs stated in step 3 on each side.

## 7. Capture the evidence

Commit into the experiment worktree, under `root-cause/`:

- `README.md`: the failure (run, job, failing line), the root cause in a sentence or two, the experiment that proves it (what was changed on each side and what happened), and the list of files below with what each shows.
- The evidence itself: the logs or log extracts of the runs that prove it (with their run links), local transcripts, traces, timings. Copy them in; a link alone can expire.
- The experiment workflows and code stay on the branch, so the proof can be run again.

Push the branch.

## 8. Report

End with:

- **Root cause:** one or two sentences.
- **How it was proven:** the experiment, both sides, one or two sentences.
- **Evidence:** what was captured, and where: the worktree path and `root-cause/README.md`, and the branch on the remote.
- **Fix options:** 0 to 5, one sentence each, ordered from the least change to the system to the most. Give none if no fix is possible from here, and say why.
