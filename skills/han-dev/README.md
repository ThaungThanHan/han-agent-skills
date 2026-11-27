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
Write and save spec.md in .dev-docs/<task-id>/
      ↓
Show the approval summary in chat
      ↓
YOU REVIEW AND APPROVE THE SPEC
      ↓
Implement the approved change
      ↓
Run applicable checks and inspect the results
      ↓
Compare the real code before and after
      ↓
Save implementation.md, code-walkthrough.md and learning.md beside spec.md (default)
      ↓
Ask questions, revisit concepts, and keep learning
```

**The approval step is required.** Han Dev must not edit application code, tests, configuration, or dependencies for a new task before you approve its specific specification. If implementation reveals a material scope change, it returns for approval of an amendment.

### Four task documents

| Document | Purpose |
| --- | --- |
| `spec.md` | **What should be built:** requirements, existing behavior, proposed approach, acceptance criteria, risks, and boundaries. |
| `implementation.md` | **What was actually built:** files changed, verification results, deviations, and remaining limitations. |
| `code-walkthrough.md` | **How to read the changed code:** every task-owned addition, modification, and deletion, ordered **Critical → High → Medium → Low**, with real code blocks, before/after comparisons, source references, and careful explanations for High/Critical changes. |
| `learning.md` | **What you should understand:** underlying concepts, mental models, architecture/design reasoning, trade-offs, and optional understanding checks. It links to the code walkthrough instead of duplicating it. |

Documents are separate so that the *plan* is never confused with the *implemented result*. Learning explanations are based on inspected source and actual changes, not invented snippets or unverified test claims.

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

Read the generated `spec.md` (or the chat specification if you selected `--spec=chat`), including requirements, approach, assumptions, and acceptance criteria. You can request revisions:

> `Revise spec v1: search should match opportunity titles only, not descriptions.`

When the specification matches your intent, explicitly approve the version:

> `I approve spec v2 for opportunity filtering. Implement it with han-dev.`

Han Dev implements that approved scope, runs feasible checks, inspects the task-owned diff, and explains the result. Failed or unavailable checks are reported as such.

### 4. Learn from the change

By default, read `.dev-docs/<task-id>/code-walkthrough.md` to study the **actual code, highest impact first**. Read `learning.md` for the underlying concepts and practice. Then ask follow-up questions, for example:

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

## Choosing chat or Markdown output

Han Dev separates how it presents the **specification** from how it presents the **post-implementation teaching**. You can set these options in your task request; they are instructions interpreted by the skill, not native VS Code CLI flags.

| Option | Default | Meaning |
| --- | --- | --- |
| `--spec=chat` | No | Show the reviewable specification in chat and ask for approval. No `spec.md` is created. |
| `--spec=markdown` | **Yes** | Save `spec.md` in the task folder before implementation; show an approval summary in chat. |
| `--spec=both` | No | Show the specification in chat and save it as Markdown. |
| `--docs=markdown` | **Yes** | Automatically save `implementation.md`, `code-walkthrough.md`, and `learning.md` after implementation and verification. |
| `--docs=chat` | No | Include an impact-ordered source-code walkthrough and explanations in chat without saving post-implementation files. |
| `--docs=both` | No | Save the documents and explain the implementation in chat. |

**Normal usage — no flags necessary:**

> `/han-dev Add search and status filters to the admin opportunities table.`

Han Dev first saves the full specification to `.dev-docs/<task-id>/spec.md` and shows an approval summary in chat. After you approve it and implementation finishes, Han Dev **automatically saves** the implementation report, impact-ordered code walkthrough, and conceptual learning lesson in that **same task folder**. You do not need to request documentation separately.

**Other combinations:**

```text
/han-dev --spec=both --docs=both Implement search and filters
/han-dev --spec=markdown --docs=chat Implement pagination
/han-dev --docs=chat Fix the loading indicator
```

### Where Markdown documents go

The default destination is a `.dev-docs/` directory **inside the selected project root**. Han Dev creates it if needed, as part of the default Markdown specification workflow. Each task gets its own subfolder to prevent overwriting other tasks.

```text
todo-app/
├── src/
└── .dev-docs/
    └── 001-search-and-filters/
        ├── spec.md
        ├── implementation.md
        ├── code-walkthrough.md
        └── learning.md
```

Both specification and post-implementation teaching default to Markdown, so all **four files** appear in **one shared task folder**. Override with `--spec=chat` to omit `spec.md`, or `--docs=chat` to omit the post-implementation files. The agent still shows a clear summary and requests explicit approval in chat, even when the full specification is saved as Markdown.

You can explicitly request another output destination. No Han Learn extension, MCP server, or dashboard is required. If the coding agent lacks file-writing access, it must provide the documentation in chat and say that it could not save the files.

The skill does not automatically update `.gitignore`; you can decide whether to commit `.dev-docs/` to source control.

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
| `references/code-walkthrough.md` | Required coverage, code excerpts, sorting, source locations, and code-reading depth. |
| `references/impact-assessment.md` | Impact labels and explanation priorities. |
| `references/qa-and-followups.md` | Code-grounded Q&A and prerequisite recovery. |
| `references/storage-and-integrations.md` | Where and how task documents may be saved. |
| `assets/` | Markdown templates for the four task documents, including `code-walkthrough-template.md`. |

---

**Han Dev** helps you **learn while building**. **Han Learn** helps you **study and master a codebase** more deeply afterward.
