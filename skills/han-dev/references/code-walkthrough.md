# Code walkthrough — coverage, comparison, and reading order

`code-walkthrough.md` is Han Dev's **primary source-code teaching artifact**. Produce it **automatically** after implementation and verification whenever `--docs=markdown|both` (`--docs=markdown` is the default for a new task), alongside `implementation.md` and `learning.md` under the existing `.dev-docs/<task-id>/` directory. Under `--docs=chat`, provide equivalent code-reading coverage in chat without writing a file. Keep `spec.md` as the approval record and `implementation.md` as the outcome/verification record; reserve `learning.md` for concepts, motivation, mental models, trade-offs, and practice.

## Establish full task-owned change coverage

1. Record a pre-edit baseline, including staged, unstaged, and relevant untracked files, **before** changing application code. Compare that captured state to the final verified implementation; `git diff HEAD` alone is insufficient when user changes predate the task.
2. Inventory **every task-owned new, modified, or deleted code section**, including meaningful application code, tests, scripts, and relevant configuration-as-code. Identify file, symbol/section, change type, impact level, and a final source pointer. Include renamed/moved code and explain the semantic effect, if any.
3. Document **all changed sections**, even Low impact, in a coverage index and in an explanation or a clearly referenced group. Closely related edits may form one walkthrough unit, but list the included files/sections. For repetitive generated/lockfile/mechanical changes, summarize the transformation, rationale, and affected paths in an explicitly marked grouped-coverage row rather than dumping huge code blocks. Never silently omit these changes.
4. Distinguish **task-owned edits**, **preexisting user work**, and **changes made by others during the task**. Do not claim ownership of unrelated changes. If an accurate inventory is impossible, explain exactly which changes/baselines are unavailable; do not claim complete coverage.

## Impact-first ordering

- Assess each meaningful changed behavior with [impact assessment](./impact-assessment.md) based on actual consequences, not lines modified. Rank walkthrough units **Critical first, then High, Medium, and Low**. Include only tiers that apply. Within a tier, organize related pieces by execution flow or dependency order so the code can be followed.
- Begin with an **Impact and coverage overview**: overall impact and a table listing all walkthrough units, change types, source pointers, and links to their sections. Sort the table by the same impact order. Explain *why* each High/Critical unit deserves attention.
- Give **High/Critical** units careful line-by-line or logical-block reading of decision points, inputs/outputs, state changes, callers, trust/data boundaries, error paths, edge cases, trade-offs, and actual check evidence. Add small Mermaid diagrams when they improve understanding. For Medium, explain the main code branches and before/after behavior. For Low, use short but accurate code explanations.
- If an entire task is Low impact, still produce a readable walkthrough and honest coverage inventory; don't add fake complexity.

## Required walkthrough unit

For every meaningful changed section or coherent group, include:

- **Heading:** `[Change type] What changed` with **impact level** and specific rationale.
- **Location:** actual repository-relative file path, function/class or identifiable code section, and verified line range where available. Prefer clickable Markdown relative links from the task folder to source (e.g. `../../src/auth/service.py`); line numbers are secondary and may drift. State baseline/final revision only if known.
- **Before and after:** for modifications show short **verbatim** source snippets with language-tagged fenced Markdown blocks and precise labels. For new code, state **Before: did not exist in the recorded baseline** and show actual new code. For removals, show the actual old code and state **After: removed**; don't invent an after snippet. If the pre-edit baseline was not recorded or is unreliable, say **Before: unavailable; comparison unverified**, and teach only the inspected current code. For changes that cross files, show the relevant connected snippets and trace how they relate. **Never fabricate code or edits.**
- **Read the code:** explain what each important line/block does in plain language, why this approach exists, how it participates in real execution, how it relates to upstream/downstream code, and any important assumptions. Walk High/Critical code more thoroughly; do not merely paraphrase identifiers or paste diffs without explanation.
- **Behavior and safety:** concrete before/after scenario where supported; error paths, side effects, affected callers and test or runtime evidence, calibrated to impact. Link to the full check report in `implementation.md`. Distinguish observed design choice from inferred intent.
- **Code-reading takeaway:** one practical observation the reader can carry into their next modification. Optional mini trace/checkpoint for impactful code.

For large implementations, excerpt **logical blocks**, not entire files, and reference the surrounding source. Explain full changed-section coverage without reprinting all changed lines. Quote secrets, tokens, private data, and credentials **never**; redact safely and say so. Illustrative pseudocode must be clearly marked and must never be presented as verified before/after evidence.

## Final coverage and validation

End with a **Complete change coverage** table containing every affected code file/section or an explicit grouped-mechanical entry, its change type, impact, and the walkthrough section where explained. Note exclusions (preexisting edits not owned by Han Dev), unverified before states, and source links that may no longer match. Validate that:

- Every task-owned changed code section appears in the inventory and is explained or explicitly grouped with a rationale.
- The walkthrough headings are sorted Critical → High → Medium → Low; each tier is internally readable.
- Actual snippets match recorded pre-task snapshots and final checked source; new/removal labels are truthful.
- Source links and function names are real, relative paths resolve when possible, and line numbers were checked if given.
- High/Critical units discuss execution, failure, affected dependents, verification gaps, and safe-change concerns, not just the happy path.
- `implementation.md` records results/tests, `learning.md` teaches concepts, and neither pretends the walkthrough was written when it was not.
