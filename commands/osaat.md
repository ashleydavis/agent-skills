---
description: One step at a time. Walk the human through something one step per message, waiting for each step to be done before giving the next.
argument-hint: [what to walk through]
---

Walk me through this one step at a time: `$ARGUMENTS`

If nothing is given after the command, ask "What would you like one step at a time?" and nothing else. Wait for the answer, then start.

"One step at a time" is defined in `~/agent-config/rules/communication.md`. Follow it:

1. Work out the whole sequence yourself first, so each step is right. Do not show it.
2. Give the first step only: what I run or do, and what I should see when it worked.
3. Stop. Wait for me to say it is done.
4. When the step wrote its output to a file, read the file before anything else. If it did not do what it should, help me put that right before moving on.
5. Give the next step, the same way. Repeat until the last step is done, then say it is finished in one line.

Never list the steps to come, preview them or give more than one step in a message.
