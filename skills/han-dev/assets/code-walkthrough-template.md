# [Task title] — Code Walkthrough

**Task ID:** [ID]  
**Approved specification:** [`spec.md`](./spec.md) [when saved; otherwise describe approved chat revision]  
**Compared states:** [Captured pre-task baseline → final inspected state; identify references if actually known]  
**Coverage status:** [Complete for identified task-owned changes / Partial — specify missing evidence]

> Read this document to understand **actual changed source code**, sorted from **Critical → High → Medium → Low** impact. `implementation.md` records results and verification; `learning.md` teaches prerequisite concepts and deeper design principles.

## 1. Impact and coverage overview

**Overall task impact:** [Highest supported level + brief evidence]  
**Top code paths to understand:** [Most consequential 1–3 behaviors and why]

| Priority | Changed code section | Change type | Impact and reason | Walkthrough |
| --- | --- | --- | --- | --- |
| 1 | [`path/to/file`](../../path/to/file) · `symbol()` | Added / Modified / Removed | Critical — [actual consequence] | [Read section](#critical-impact) |
| 2 | [Next actual section] | [Type] | High — [reason] | [Read section](#high-impact) |

*Create entries for every task-owned change. Skip empty impact tiers; examples in this template are placeholders, not source evidence.*

## 2. Critical impact

### [Added / Modified / Removed] — [Behavior or code section]

**Impact:** Critical — [specific, evidence-based consequence; not just file type]  
**Location:** [`path/to/file`](../../path/to/file) · `Class.method()` · [verified lines if available]  
**Related callers:** [actual upstream/downstream source paths]  
**Baseline:** [Known source snapshot / unavailable]

**Before (captured source; if available):**

```text
[Paste a *verbatim* short old-code excerpt here; NEVER invent one. If new, write “No prior code in the baseline” instead.]
```

**After (verified final source; if applicable):**

```text
[Paste a *verbatim* short new-code excerpt with the correct language tag. For deleted code, write “Removed” rather than inventing replacement code.]
```

**Read the code, step by step:** [Teach important inputs, guards, branches, state updates, outputs, and why each matters.]  
**Trace one real execution:** [Trigger → key function calls → outputs, errors, state/data boundaries. Optional verified Mermaid.]  
**Failure, safety, and compatibility:** [Consequential edge cases, safeguards, rollback/recovery when applicable.]  
**Verified / not verified:** [Actual relevant check evidence and limitations; link `implementation.md`.]  
**What to watch when editing this:** [A precise maintenance warning or self-check.]

## 3. High impact

[Repeat the walkthrough unit with actual source blocks; include callers, execution path, edge cases, tests/unknowns and alternatives.]

## 4. Medium impact

[Repeat with focused before/after snippets and readable code-branch explanations.]

## 5. Low impact

[Explain each change briefly with a real code excerpt or an explicit grouped mechanical-change entry and file references. Do not omit sections merely because impact is Low.]

## 6. Complete change coverage

| Task-owned code file / section | Type | Impact | Explained in | Evidence / gap |
| --- | --- | --- | --- | --- |
| [`path`](../../path) · `symbol` | Added / Modified / Removed / Moved / Grouped | [Level] | [Section anchor] | [Recorded baseline/final source or limitation] |

**Excluded as preexisting/non-task changes:** [Paths or statement that none were observed; don't assume.]  
**Baseline gaps:** [If the before state wasn't reliably captured, clearly identify affected units.]  
**Source freshness:** [When checked; state that line numbers/links may drift after future edits.]  
**Mechanical/generated coverage:** [List any grouped files and why excerpts were abbreviated; never silently omit.]

*Delete unused tier headings and template placeholders when generating a real walkthrough; keep the remaining sections in descending impact order.*
