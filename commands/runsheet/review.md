Review a local runsheet with the human. Apply their feedback. Keep the style guide and these commands in sync.

Find and read the runsheet style guide in `~/notes` **before changing anything**. That guide is the source of truth. Do not invent a parallel style. Do not load unrelated skills unless the human asks.

## Steps

1. **Choose a local runsheet.** If the human already has a runsheet open or named one, use that. Otherwise list every `*.md` under `runsheets/` (workspace root) and ask which file. Stop if missing or empty.

2. **Wait for feedback.** Do not start a bulk rewrite. Do not hunt for style issues. Do not read extra files “for context” until the human points at a passage and says what to change. If they have not given a note yet, stop and wait.

3. **Apply each note** to the local file. Prefer a small, exact edit over a wide rewrite. Preserve procedure truth: do not invent steps, tickets, or workflows the human did not confirm. If a fix needs a human decision, ask once and apply the answer.

4. **Persist the rule.** When the feedback is a style or process rule (not a one-off fact about this procedure), update in the same turn, without being asked again:
   - the runsheet style guide in `~/notes`
   - these runsheet commands (`create`, `review`, `publish`) when the rule changes how an agent should behave

5. **Preserve Confluence metadata.** Keep the top HTML comment (`Source`, `Confluence page id`, `Downloaded`, `Version at download`) unchanged unless the human asks to refresh it via `/runsheet/download`.

6. **Do not publish to Confluence** during the review. Even if the original message also said “publish”, wait until the human says the review is finished, then use `/runsheet/publish`.

7. **Report.** Path updated, what changed, and (when step 4 applied) which guide or command you updated. Keep it short.

## Hard stops

- Never use em dashes in the draft. Use a period, comma, colon, or parentheses instead.
- Never start editing before the human has pointed at what to change.
- Never load unrelated skills to “prepare” for a runsheet review.
