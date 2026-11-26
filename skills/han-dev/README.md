# Han Dev

**Build with AI. Understand every change.**

Han Dev (`han-dev`) is an Agent Skill for **specification-first software development with continuous learning**. It helps a coding agent turn your rough task description into a reviewable specification, implement the approved change, and teach you how the code works and why it was changed.

Unlike a coding assistant that only reports “Done,” Han Dev is designed to make you an active participant in the development process.

## What Han Dev does

```text
Your task draft
      ↓
Investigate the existing codebase
      ↓
Write a task specification
      ↓
YOU REVIEW AND APPROVE THE SPEC
      ↓
Implement the approved change
      ↓
Run applicable checks and inspect the results
      ↓
Compare the real code before and after
      ↓
Assess change impact (Low / Medium / High / Critical)
      ↓
Explain high-impact changes first and in greater depth
      ↓
Write implementation and learning documents
      ↓
Ask questions, revisit concepts, and keep learning
```

**The approval step is required.** Han Dev must not edit application code, tests, configuration, or dependencies for a new task before you approve its specific specification. If implementation reveals a material scope change, it returns for approval of an amendment.

### Three task documents

| Document | Purpose |
| --- | --- |
| `spec.md` | **What should be built:** requirements, existing behavior, proposed approach, acceptance criteria, risks, and boundaries. |
| `implementation.md` | **What was actually built:** files changed, verification results, deviations, and remaining limitations. |
| `learning.md` | **What you should understand:** real before/after code, execution flow, design reasoning, trade-offs, and optional understanding checks. |

Documents are separate so that the *plan* is never confused with the *implemented result*. Learning explanations are based on inspected source and actual changes, not invented snippets or unverified test claims. **Impact levels** help Han Dev focus your reading time on changes that matter most.

## Impact-first learning

After implementation, Han Dev assesses **what each meaningful code change can affect**. High-impact changes receive deeper explanations, not merely more technical jargon.

| Impact | Example | Explanation depth |
| --- | --- | --- |
| **Low** | Copy or isolated visual change | Short summary and checks |
| **Medium** | A bounded feature behavior change | Before/after and one walkthrough |
| **High** | Shared authentication/session logic, API contracts, data flows or concurrency | Detailed flow, real code excerpts, affected callers, edge cases, trade-offs, and verification |
| **Critical** | Credible exposure, authorization bypass, irreversible data loss or serious service interruption | High-level depth plus safeguards, recovery/rollback and explicit verification limits |

Examples are illustrative; impact must be justified from the actual repository, not assigned based on filenames or lines changed. The spec includes an **initial predicted impact**; after implementation, the documentation reports **actual observed change impact**. Passing tests improves confidence but doesn't lower the impact level.

For example, ask:

> `han-dev explain: Focus on the high-impact authentication changes and why they need extra safeguards.`

## Getting started

### 1. Install the skill

Copy this entire directory into a location your coding agent discovers. For this repository, the canonical source location is:

```text
han-agent-skills/
└── skills/
    └── han-dev/
        ├── SKILL.md
        ├── README.md
        ├── references/
        └── assets/
```

Run your repository's installer or configure your agent to discover that skill directory. Depending on the VS Code agent setup, supported workspace locations can include `.github/skills/han-dev/` or `.agents/skills/han-dev/`. Simply keeping a skill in the repository's top-level `skills/` directory does not guarantee automatic discovery.

### 2. Give Han Dev your task draft

Describe the outcome in your own words. You do **not** need to write a formal specification.

> `/han-dev Add search and status filters to the admin opportunities table. Reset pagination when the filters change.`

Han Dev first examines the relevant project code and prepares a specification. **At this point it stops, without implementing the feature.**

### 3. Review and approve the specification

Read the requirements, approach, assumptions, and acceptance criteria. You can request revisions:

> `Revise spec v1: search should match opportunity titles only, not descriptions.`

When the specification matches your intent, explicitly approve the version:

> `I approve spec v2 for opportunity filtering. Implement it with han-dev.`

Han Dev implements that approved scope, runs feasible checks, inspects the task-owned diff, and explains the result. Failed or unavailable checks are reported as such.

### 4. Learn from the change

Read `learning.md` for a guided explanation of the actual implementation. Then ask follow-up questions, for example:

> `han-dev ask: Why is the search term included in the TanStack Query key?`

> `han-dev diff: Show what changed before and after in the data-fetching hook.`

> `I'm confused by cache invalidation. Teach the prerequisites, then relate them to this change.`

Han Dev answers from the relevant source code when accessible and can explain concepts from the ground up. Q&A does **not** silently trigger additional code edits.

## Ways to use it

These are **example intents**, not guaranteed CLI subcommands. Actual invocation syntax depends on the agent host; in a compatible VS Code chat environment, the skill may be available as `/han-dev`.

| What you ask | What Han Dev does |
| --- | --- |
| `han-dev: <task draft>` | Investigates and drafts a specification; waits for approval. |
| `han-dev spec: <task>` | Creates or revises a specification without implementing. |
| `han-dev implement` | Implements the identifiable, explicitly approved spec revision. |
| `han-dev explain` | Teaches the implementation using current source. |
| `han-dev diff` | Explains verified changes against the recorded baseline. |
| `han-dev ask: <question>` | Answers a focused, code-grounded question. |
| `I'm confused about <concept>` | Teaches the minimum prerequisites and returns to the code. |

You can also request *spec-only*, *explanation-only*, or *diff-only* assistance without triggering the entire workflow.

## Where the documents go

Han Dev **does not automatically place learning files inside your application repository**. When saving is available, it prefers:

1. An explicitly configured Han Learn storage tool or external project library.
2. Another destination you explicitly provide.
3. Otherwise, readable documents in chat until a destination is chosen.

For example, an external library could contain:

```text
han-learn-library/
└── projects/
    └── todo-app-<stable-id>/
        └── tasks/
            └── 001-search-and-filter/
                ├── spec.md
                ├── implementation.md
                └── learning.md
```

No Han Learn extension, MCP server, or dashboard is required to use the skill. The external storage integration is optional, and Han Dev must not invent tool availability or saved-file locations.

## Important boundaries

- **Spec first:** explicit approval is required before changing application code.
- **Respect your work:** preserve preexisting edits and distinguish them from agent-owned changes.
- **Stay in scope:** ask before implementing materially different requirements.
- **Verify honestly:** report passed, failed, blocked, and unrun checks accurately.
- **Use real evidence:** cite inspected source and compare against the actual pre-change baseline when available; do not fabricate before/after code.
- **No surprise releases:** don't automatically commit, push, deploy, or open a pull request.
- **Protect private data:** avoid leaking secrets and sending confidential source to external services without authorization.

An Agent Skill is a set of instructions for a compatible coding agent, **not** a standalone executable or a hard-enforced permissions system. It needs the agent to have the appropriate code-reading, editing, and verification tools.

## What's included

| Path | Description |
| --- | --- |
| `SKILL.md` | Main behavior, approval gate, and workflow instructions. |
| `references/specification-workflow.md` | How to investigate a task and write a testable specification. |
| `references/implementation-verification.md` | How to implement safely and report checks. |
| `references/change-analysis-and-teaching.md` | How to compare changes and teach them clearly. |
| `references/impact-assessment.md` | Impact levels, prioritization, and deeper teaching for consequential changes. |
| `references/qa-and-followups.md` | Code-grounded Q&A and prerequisite recovery. |
| `references/storage-and-integrations.md` | Where and how task documents may be saved. |
| `assets/` | Markdown templates for the three task documents. |

---

**Han Dev** helps you **learn while building**. **Han Learn** helps you **study and master a codebase** more deeply afterward.
