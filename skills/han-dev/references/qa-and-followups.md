# Q&A and prerequisite recovery

The coding task and its learning documents are the context, but current source is authoritative. `code-walkthrough.md` is the first place to navigate for task-owned changed sections, before confirming claims against current source. The purpose of Q&A is to grow the user's engineering judgment, not to bury them in an audit.

## Answer a question

1. Identify which task, source file, or behavior the user is asking about; use the most recent clearly relevant task when unambiguous.
2. Read the affected current code if accessible. Contrast it with the documented revision only when that difference matters.
3. Start with a direct, short answer and a small scenario or analogy.
4. Explain **what, why, how** in that order where useful. Refer to the actual function and one concise source excerpt; explicitly label illustrative pseudocode.
5. When the user asks a design question, discuss relevant alternatives and trade-offs, not merely "this is best practice."
6. If the topic involves High/Critical impact, give careful attention to consequential branches, affected users/data, and actual checks, using [the impact rubric](./impact-assessment.md). Still answer the user's specific question first, and avoid unnecessary alarm.
7. Offer a focused follow-up exploration; do not force exercises or regenerate the entire lesson.

If the code cannot be accessed, explicitly say that and ask for the relevant excerpt or provide only a clearly labeled general explanation. Don't pretend past knowledge is a fresh inspection.

## Confusion pathway

When the user does not understand an explanation:

- Identify the exact stumbling point or a small set of plausible missing prerequisites (e.g. request/response, state vs cache, event loop vs worker thread). Do not assume the user's ability from a single question.
- Determine whether the problem is missing knowledge, terminology, poor explanation, a faulty diagram, or incorrect documentation.
- Teach the **minimum** prerequisite concepts with a small worked example; use one to three essential concepts at first, not a huge new curriculum.
- Connect the newly learned concept to the actual code passage; ask whether the connection now makes sense, or offer one brief checkpoint.
- If the user requests a dedicated learning bridge or a broader curriculum, suggest the separate Han Learn skill; do not secretly overwrite Han Learn materials.

## Interaction rules

- User questions are not implicit requests to edit code. Do not create changes without a new approved spec.
- For a challenged or corrected explanation, inspect source and acknowledge uncertainties or mistakes; update a saved lesson only with user permission and a known destination.
- If the user requests a quiz, challenge, or assessment, ask questions tied to the implementation and hold solutions back until the user responds or requests them.
- If a newly discovered defect needs a code change, propose a new spec or amendment instead of silently fixing it during Q&A.
