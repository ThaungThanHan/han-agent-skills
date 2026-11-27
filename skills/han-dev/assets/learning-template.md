# [Task title] — Learn the Change

**Task ID:** [ID]  
**Based on:** [Actual implementation revision/source baseline]  
**Learning goal:** [What the reader should be able to explain or modify]  
**Code-reading companion:** [`code-walkthrough.md`](./code-walkthrough.md) — actual changes, before/after code, source links, sorted Critical → High → Medium → Low

## Impact at a glance

**Overall impact:** [Low / Medium / High / Critical, based on actual changed behavior]

Describe the highest-impact 1–3 changes first, with their consequences and links to inspected source. If the overall task is High/Critical, focus the explanation on those behaviors rather than equally covering every changed file. Impact is not a measure of confidence or code size.

| Changed behavior | Impact | Why it matters | Code reference |
| --- | --- | --- | --- |
| [Behavior] | [Level] | [Who/what is affected and why] | [Link] |

## 1. The problem in plain English

Start with a concrete user scenario. Define the behavior that motivated the task.

## 2. The smallest mental model

Introduce up to three essential concepts needed to follow the implementation. Use a small analogy or diagram if helpful; avoid making this a generic framework tutorial.

## 3. Before: how the project worked

Describe the verified previous behavior and its limitation at a **conceptual level**. Link to the corresponding detailed before/after excerpts in `code-walkthrough.md`. If the baseline is unavailable, disclose the limitation.

## 4. After: what changed

Explain the current behavior at a **conceptual level** and why it matters. Link to the relevant actual source and sections of `code-walkthrough.md` rather than copying every change again. Introduce only a short verified snippet when it is essential to teaching a new concept.

## 5. Walk through one real execution

1. [Trigger or user action]
2. [Entry point]
3. [Key function/state/data transition]
4. [Result or failure behavior]

Use source links beside important steps. Explain terminology before using it.

## 6. Why this design?

- **Decision:** [Actual implementation choice]
- **Why useful:** [Specific problem solved]
- **Alternative:** [Viable alternative and its trade-off]
- **Limitation:** [Known drawback, test gap, or constraint]

Distinguish observed facts from inferred motivation.

## 7. What was verified?

Summarize executed checks, failed/skipped checks, and the remaining confidence limits without inventing success. For High/Critical paths, discuss the most consequential failure or security/data-integrity scenarios, any safeguards, gaps in validation, and recovery/rollback considerations when relevant.

## High-impact walkthrough (when applicable)

For each High/Critical changed behavior, teach the **conceptual mental model** that makes the code readable, referencing the corresponding detailed sections in `code-walkthrough.md`. Explain affected callers, state/data ownership, failure paths, alternatives, and safe-change considerations, without duplicating the full before/after code blocks. Use a focused Mermaid diagram if it helps. Skip this section for lower-impact changes.

## 8. Explore the code yourself

A suggested reading order using real relative links, then a small independent exercise that doesn't require unrelated setup.

## 9. Check your understanding (optional)

1. [One simple what/why question]
2. [One predict/trace or modify question; for High/Critical changes, focus on a consequential failure case or affected caller]

Questions should test understanding, not merely the ability to copy phrases from the lesson. Answer only when the user asks or responds.
