---
description: Walk the human through an AWS IAM policy file one statement at a time, showing each whole statement and explaining what its permissions do and why they are needed, and fix the statement comments as they ask.
---

Walk the human through the statements in an AWS IAM policy file, one statement per message, so they can review each one as a whole and have its comment fixed.

Read `~/agent-config/rules/aws-permissions.md` first.

## 1. Find the policy file

The argument names the file. Find it on disk with one `find` from the current directory, leaving out `node_modules` and `.git`. Use no git command to find it.

- **A path:** use it as it is.
- **A file name, such as `cloudfront_automation_api_environment_production.json`:** `find . -name '<name>'`.
- **A project and an environment, such as `cfai prod`:** expand standard abbreviations (`cfai` is CloudFront Automation API, `dev`, `stg` and `prod` are development, staging and production) and find the `.json` file whose name holds both, written the way file names write them (`cloudfront_automation_api`, `production`).
- **No argument:** ask for the file.

Copies of the same file in worktrees (under `.claude/worktrees/` or similar) are separate matches. When more than one file matches, or none does, ask for the path in one question, naming the candidates.

Work on that file where it is. Make no commit and no push: the human asks for those when they want them.

Start the walkthrough by showing the file's full absolute path on a line of its own, then say how many statements and permissions it has, then start with the first statement.

## 2. Check every comment before the first statement

Each statement should carry a comment saying why its permissions are needed. Before showing the first statement, review every comment in the policy:

- It says why the permissions are needed: what the system needs to do, and that it can't be done without them. It is clear, simple and concise, with nothing extra.
- It says what the permissions are limited to, in a few words.
- It does not restate the actions, explain how IAM works or tell the story of how it came to be.

Rewrite every comment that falls short. When the same policy exists for other environments and the files are meant to stay identical, copy the change to each of them.

## 3. One statement per message

For each statement, in file order, give:

- A heading: `Statement <n> of <total>: <Sid>`.
- The whole statement, exactly as it is in the file, comment included. Never shorten it with `...`.
- **What it does:** each action and what it does in AWS, a few words per action. Group actions that do the same thing to the same resource.
- **Why it's needed:** what the system does with these permissions, and what fails without them.
- **Scope:** the resources and conditions that limit it, with the placeholders filled in for the environment under review.
- **Tested:** where the same permissions already work, such as another environment's deploys. Say so only when it is true. When it is not known, say it is untested.
- Then stop and wait for the human. `n` moves to the next statement. `s` shows the current statement again in full, as it is in the file now.

## 4. When the human asks for a change

- Make it in the working tree straight away, in every copy of the policy that has to stay the same, then show the changed statement again.
- Before splitting a statement or adding text that IAM keeps, measure the policy as IAM counts it: comments stripped, placeholders filled in, no whitespace. Check it against the limit that applies (10,240 characters across a role's inline policies, 6,144 for a managed policy). Refuse a change that would go over, and say how close the policy is.
- Check the file still parses and that no permission was added or lost, then carry on from the same statement.
