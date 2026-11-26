# Specification workflow

Use this reference for a new feature, bug fix, refactor, architecture change, or spec revision. **Specification is a deliverable, not permission to implement.**

## 1. Discover the actual situation

- Identify the current workspace and expected audience. Read repository-specific instructions and relevant code, docs, tests, API definitions, and configuration.
- For a bug, identify the observed failure and reproduction steps when available; distinguish symptoms from hypotheses.
- Find existing patterns and named modules likely to change. Don't invent services, DB tables, endpoints, deployment systems, or contracts.
- Inspect `git status --short` (when Git is available) and check for in-progress user work; do not modify application files during specification.
- Note known assumptions and uncertainty without turning every task into a lengthy interrogation. Use reasonable safe defaults, marking them as assumptions. Ask only when an unresolved decision materially affects correctness or user intent.

## 2. Define a testable contract

Use [the spec template](../assets/spec-template.md) and adapt length to scope. It should answer:

1. **Problem and outcome:** What is wrong or missing? What should a user be able to do?
2. **Existing behavior:** How does the current code behave, with source links?
3. **Requirements:** Numbered and observable; prioritize behavior over implementation trivia.
4. **Non-goals:** What is explicitly out of scope?
5. **Proposed approach:** Key modules/boundaries, data flow and likely code changes; reasons and alternatives when necessary.
6. **Acceptance criteria:** Specific tests or observable expected outcomes, including failure/empty cases.
7. **Constraints, predicted impact, and risk:** Compatibility, performance, security, state, migrations, deployment, accessibility, and rollback if relevant. Use [impact assessment](./impact-assessment.md) to label meaningful planned changes Low / Medium / High / Critical; explain evidence, reach, and uncertainty. Put the highest-impact decisions in the approval summary.
8. **Validation plan:** Unit/integration/e2e/manual checks as appropriate, with stronger negative-path and regression coverage for higher-impact areas; don't claim they ran.
9. **Open decisions and assumptions:** Clearly distinguish verified facts, inference, and choices the user must resolve.

A short bug fix may need fewer details than an RBAC redesign. Avoid giant generic templates. Include an architecture diagram only when it helps explain a meaningful boundary change.

## 3. Review and approval gate

- Present a brief summary, the highest-risk decisions, and explicit approval request.
- Use a stable spec identifier and a revision label such as `v1`, `v2`; retain earlier revisions if the user requests a change history.
- **Never treat creation of a file, acceptance of a summary, or agent self-review as user approval.** Record explicit user approval for the exact spec version in the conversation or an unambiguous already-approved task record.
- If approval is conditional (e.g. "approved except the database change"), revise the spec or narrow the scope before implementing; don't guess.
- If an approved spec becomes impossible due to newly discovered facts, return with a specific amendment rather than implementing a materially different solution.

## Example acceptance criteria

Vague: "Search works well."

Specific:
- A search for a known title returns matching opportunities.
- Changing the search phrase resets pagination to the first page.
- Empty results show an explanatory empty state.
- A failed request shows an error and a retry path, with no stale success message.

The concrete criteria must match the repository's real behavior and user requirements; the example is not a default set to copy.
