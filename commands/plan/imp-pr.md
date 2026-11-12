Implement a plan, then commit and push its worktree branch and open a pull request back to the branch the worktree came from.

This command depends on `/plan:imp`. Use the plan from the current conversation, or the plan `/plan:imp` chooses.

**Refuse to run unless a worktree is selected.** Run `git worktree list --porcelain`. If the current directory is not one of the worktree paths in its output, say "This command runs only on a worktree. Choose the worktree when `/plan:imp` asks for the working location." and stop. Change nothing.

1. **Implement the plan.** Run `/plan:imp` for the plan. The plan's steps are its instructions, including its Self Review step. When the plan has a documentation review stop, `/plan:imp` stops there, the human approves the documentation, and the command carries on. Every repository the plan touches must be on a worktree, not a main checkout; if one is not, create that worktree before implementing.

2. **Check the tests.** Run the plan's "Verify" section. The commit is allowed only when every test command the plan names exits with code 0. A test the plan's "Verify" section names as CI-only cannot run on this machine; it is not a failure here.

3. **Read the base branch.** The base branch is the branch the worktree was created from, which is the main checkout's current branch. Run `git worktree list --porcelain` and read the first worktree's `branch` line. The base branch is not necessarily the main branch.

4. **Commit.** Commit on the worktree branch. The message follows `~/agent-config/rules/commits.md`, and the plan's title and "Overview" give the subject and the reason.

5. **Push.** Push the worktree branch to the remote.

6. **Open the pull request.** Open a pull request from the worktree branch to the base branch. The title and description follow `~/agent-config/rules/prs.md`, and the plan's title and "Overview" give the subject and the reason. Open the pull request URL in Chrome.

7. **Report.** Report the pull request URL, the base branch and the commit hash.

## Next

Recommend the developer run:
- `/plan:review`: review the completed plan.
