# Before/after analysis and learning documentation

Han Dev teaches **why the change exists**, **how it behaves**, and **what the developer should understand to own it**. The output is not a generated changelog alone.

## Establish a truthful comparison

- Compare the source as it existed **immediately before Han Dev's authorized changes** with the source after implementation. Preserve the distinction between agent changes and preexisting user edits.
- `git diff HEAD` may include changes that predate the task. Use a recorded baseline and file-by-file inspection, including untracked files where needed.
- For a newly created file, use "Before: this functionality/file did not exist in the captured baseline," rather than inventing prior code.
- For rewritten code, use short actual before/after excerpts with file links. Excerpts must be taken from inspected source or recorded snapshots and labeled accurately. Never fabricate snippets to look representative.
- If the baseline is missing, use a **current behavior explanation** and state that a reliable before/after comparison is unavailable.
- If source paths move after a lesson was created, recheck them before answering follow-ups.

## Impact-first explanation

Read [the impact rubric](./impact-assessment.md) before drafting an implementation or learning report. Classify consequential changed behaviors as Low / Medium / High / Critical with evidence, separately from verification confidence. Open with **Impact at a glance** and teach High/Critical changes first, with more concrete examples, execution paths, security/data/reliability consequences where relevant, edge cases, alternatives, and verification limits. Summarize Low changes briefly instead of giving every file equal space.

## Teaching sequence

For each substantial change, use an appropriate subset of this sequence:

1. **User-facing problem:** Explain the problem in plain English; provide one concrete scenario.
2. **Mental model:** Introduce the small set of unfamiliar concepts required to understand the solution before using them.
3. **Before:** Describe the old behavior and why it failed or fell short, supported by real evidence.
4. **After:** Describe what is different for users and internal components. Show focused before/after code excerpts or a compact diagram when valuable.
5. **Request or execution flow:** Walk one real case from trigger to output, referencing the actual functions and files. Explain technical terms at first use.
6. **Why this design:** Name the engineering decision, motivation, alternative(s), and trade-offs; distinguish documented intent from inferred reasoning.
7. **Verification and limits:** What was tested, what remains uncertain, any known edge cases or risks.
8. **What to study:** A small number of prerequisites, a short reading order, and an optional self-check or independently solvable exercise.

Do not compress five unfamiliar terms into a single paragraph. Prefer a short paragraph or an example before a diagram full of nodes. Do not make every lesson a full system audit. Adjust the depth to the change:

- **Brief:** small, obvious edits — summary, reason, affected paths, verification.
- **Standard (default):** meaningful changes — behavior, before/after, real code walkthrough, why, tests, checkpoint.
- **Deep:** substantiated High/Critical changes — prerequisites, actual before/after flow, affected dependents, failure scenarios, trade-offs, verification limits, and safe-change guidance. Do not expand every minor file solely because the overall task is High.

## Keep documents distinct

- [Specification](../assets/spec-template.md): approved **intent**, even if the plan is revised later.
- [Implementation report](../assets/implementation-template.md): **observed** modifications and verification results; deviations from intent.
- [Learning lesson](../assets/learning-template.md): **teaching** material connected to evidence and the implementation report.

Avoid falsely saying an algorithm was introduced by Han Dev if it already existed. Mark all hypothetical examples and pseudocode as examples, distinct from actual excerpts.

## Completion review

Check each factual claim against source or a recorded baseline. Check links, snippets, diagrams, actual test outputs, and clear separation of fact/inference. Ensure the user can answer: "what was wrong, what changed, why this design, where is the code, and how do I verify it?" For High/Critical paths, also ensure the learner can explain **what could break, who or what would be affected, and how the safeguards were actually checked**.
