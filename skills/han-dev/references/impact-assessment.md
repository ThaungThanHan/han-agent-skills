# Change impact assessment and teaching priority

Impact is an assessment of **what a code change could affect**, not a measure of lines changed, effort, or how impressive a change sounds. Use it to allocate explanation and verification attention. The label is **not** a claim that the code is unsafe or that a failure occurred.

## Assess twice

1. **Specification (predicted):** Identify potentially high-impact areas from the existing code and proposed change. Mark assumptions and where evidence is incomplete. This informs approval and verification planning.
2. **After implementation (observed):** Reassess each task-owned changed behavior using the final diff, execution paths, affected callers, and checks. Update the implementation report and teaching lesson. If impact increased materially beyond the approved risk or scope, follow the spec-amendment gate *before* implementing the additional change.

Classify **each meaningful changed behavior or subsystem**, then provide an **overall task impact** equal to the highest substantiated tier. Group closely related files when they affect the same behavior. Do not inflate impact based on file size or language/framework popularity; a one-line access-control change can be higher impact than hundreds of lines of UI styling. A high label must have a specific rationale and referenced evidence. Mark uncertain impact as **provisional** and explain what would resolve it.

## Impact levels

| Level | Typical reach and consequences | Teaching depth |
| --- | --- | --- |
| **Low** | Localized presentation, copy, or isolated internal change with little effect on behavior | One-paragraph summary, location, and check |
| **Medium** | Meaningful behavior in one bounded feature; failures mostly isolated and recoverable | Before/after, one execution walkthrough, trade-offs and tests |
| **High** | Shared components, public API/contracts, auth/session/permissions, data persistence, complex concurrency, system boundaries, broad user-facing behavior, significant performance/reliability risk | **Prioritize first:** prerequisites, detailed verified before/after, end-to-end flow, affected consumers, failure and edge cases, alternatives, tests/unknowns, safe-change guidance |
| **Critical** | Credible risk of unauthorized access or secrets exposure, irreversible data loss, unsafe destructive migrations, severe availability loss, or other serious cross-system consequences | Everything in High, plus explicit safeguards, compatibility/migration/rollback or recovery strategy, and limitations of verification; do not assert production safety from unit tests alone |

These are heuristics, not automatic triggers: merely touching an auth file does not prove a vulnerability, and a new API endpoint is not invariably High. Evaluate **blast radius, user/data consequences, reversibility, trust boundaries, coupling, and uncertainty** using the actual task.

## Impact map format

Use a compact table for tasks with more than one meaningful changed area:

| Changed area / behavior | Level | Why it matters | Evidence | Verification / uncertainty |
| --- | --- | --- | --- | --- |
| `path` / function | High | [Specific affected callers, data or users] | [Actual source or diff link] | [Performed checks and remaining gap] |

For a one-file simple fix, a short labelled paragraph is sufficient. Distinguish the **impact of the code change** from the **confidence in its correctness**; passing tests increases confidence, not the impact level.

## Teach in impact order

1. Open with **Impact at a glance**: overall impact, the top one to three changed behaviors, and a simple reason for each. Explain the highest-impact change before low-priority housekeeping, even when its code is smaller.
2. For **High/Critical** changes, build a clear learning path: the user problem → essential prerequisites → old behavior and risks → actual new code and how it works → a concrete end-to-end scenario (including state/data boundaries) → failure/edge cases → alternatives/trade-offs → verification evidence and missing checks → what the developer should inspect before modifying it again.
3. Use **actual recorded before and after excerpts**, short and annotated; when a baseline is unavailable, say so. Show a small Mermaid sequence/flow diagram when it genuinely clarifies a consequential flow. Avoid jargon-heavy paragraphs; introduce one concept at a time.
4. For **Medium**, a focused walkthrough and key trade-off are normally enough. For **Low**, summarize in a table or appendix; avoid diluting the important changes with equal-length explanations.
5. Offer a **high-impact understanding checkpoint**, such as predicting a failure case or explaining which callers depend on the change. Do not manufacture risk, tests, or performance measurements.
6. Q&A about an impactful change should prioritize its critical execution path and risks, but answer the user's specific question directly rather than forcing an exhaustive review.

## Example (illustrative, not repo evidence)

A UI label change is Low. Changing the query/filter behavior in one opportunities table may be Medium. Reworking a shared request client that handles token refresh across multiple pages may be High. A change that could bypass authorization for other users' records is Critical **if that credible consequence is supported by the inspected code**, not merely because the file name includes `auth`.
