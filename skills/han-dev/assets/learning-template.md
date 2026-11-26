# [Task title] — Learn the Change

**Task ID:** [ID]  
**Based on:** [Actual implementation revision/source baseline]  
**Learning goal:** [What the reader should be able to explain or modify]

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

Describe the verified previous behavior and its limitation. When available, add a short actual pre-change excerpt with the original path. If no reliable baseline exists, explicitly state that a before/after comparison cannot be verified.

## 4. After: what changed

Explain the current behavior from the actual implementation. Add short **verified** code excerpts and source links; identify new files as new, not as transformations of invented old code.

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

For each High/Critical changed behavior, explain the **actual** before/after execution with verified code excerpts or a focused diagram. Trace affected callers, state/data ownership, failure paths, relevant alternative designs, and what a future maintainer must watch out for. Teach any required prerequisites first. Skip this section for lower-impact changes.

## 8. Explore the code yourself

A suggested reading order using real relative links, then a small independent exercise that doesn't require unrelated setup.

## 9. Check your understanding (optional)

1. [One simple what/why question]
2. [One predict/trace or modify question; for High/Critical changes, focus on a consequential failure case or affected caller]

Questions should test understanding, not merely the ability to copy phrases from the lesson. Answer only when the user asks or responds.
