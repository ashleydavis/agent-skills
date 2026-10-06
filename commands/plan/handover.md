Wrap up what you are working on and leave it ready for another agent to pick up. This works only for work that has a current plan, because the notes go in the plan's `## Handover` section and only the plan commands read it.

This is a courtesy, not a report. Do not write a summary for the human, and do not run anything, check anything or gather anything for the purpose of telling them what you did. Everything you write here is for the next agent.

Assume the next agent starts with none of this conversation. Whatever matters and exists only in your head right now is what to write down.

**Step 1: Stop starting things**

Finish only what would be left broken or misleading if you stopped mid-way: an edit that leaves a file inconsistent, a half-renamed symbol, a test you changed but did not run. Do not begin new work, do not fix things you happened to notice, and do not tidy anything.

**Step 2: Write the notes in the Handover section of the document the next agent will read**

The notes always go in a section headed `## Handover`, in one fixed place that depends on the work, because that is where the next agent looks. Running this command is the human asking for the notes, so it is permission to write the section, whatever the project's rules say about plan content needing approval.

- **The plan has step files.** What was achieved goes in the Summary of the step file you worked on, in the same voice as the rest of it. The `## Handover` section (where the work stands, traps, what was inferred) goes in the step file of the next step to be done (the first unchecked item in the plan's Implementation Steps checklist), because that is the file the next agent opens. It does not go in the file of the step you just finished. If a step is part done, that step's file is the one, and the Summary and the section say which parts are finished and which are outstanding. Do not tick a checklist item that is not actually done.
- **There is a plan with no step files.** Put the section in the plan document.
- **There is no current plan.** Handover notes are read by the plan commands (`/plan:imp`, `/plan:continue`), so without a plan there is nowhere to put them. Tell the human there is no current plan to hand over through.

The `## Handover` section is temporary: it is replaced at the next handover and deleted when the next agent has used it. So it holds only what describes the state of the work right now (where it stands, what is part done, traps the next agent will meet straight away, what was inferred). A lesson, a constraint or a decision that a particular later phase or step must follow is a change to the plan, so it goes in the text of the phase or step it concerns, where it is still there when that phase is reached.

If the document already has a `## Handover` section, replace it with the new notes. It describes where the work stands now, so it is rewritten on each handover and never appended to. Notes in it that are still true and still needed stay, in the new text. Anything finished or out of date goes.

The plan commands that start the next piece of work (`/plan:imp`, `/plan:continue`) read this section first.

If the document records a baseline or a position that the work moved, update that too, so it is not left claiming something untrue.

**Step 3: Cover what only you know**

The code and the diff speak for themselves. These do not, so write them down:

- **Decisions and why.** Especially where you considered another option and rejected it, and where the human overruled something. A later agent that does not know a decision was made will make it again, differently.
- **Anything deliberately not done.** Deferred, out of scope, or blocked, and what it is waiting on. Say who decided, if it was the human.
- **Traps.** Something that looks like a defect but is correct, something that will fail for a reason other than the obvious one, a check that reports a change on purpose. This is the most valuable thing you can leave.
- **Anything you inferred rather than confirmed.** A value read out of code rather than seen at runtime, an assumption a later step will test.

**Step 4: Leave the working tree as it is**

Do not commit, push, merge or delete anything unless the human has told you to in this conversation.

Remove throwaway files you created that no longer serve anything. Keep anything the next agent needs, and say in the notes what it is for.

**Step 5: Say you are done, briefly**

One or two lines: which file's `## Handover` section you wrote the notes in, and the single most important thing the next agent should know. Nothing else. The notes are the handover, not this message.
