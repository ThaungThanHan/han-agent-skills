# Documentation storage and optional integrations

Documentation should be useful **without** the future Han Learn dashboard, VS Code extension, or MCP server.

## Resolve a destination explicitly

Use this priority order:

1. **Connected storage tool:** If a verified Han Learn extension/MCP tool is available and configured, use its documented API to save task artifacts externally. Only invoke actual discovered tool names and schemas; never invent a `saveLesson` call.
2. **Configured external library:** If the user or project configuration explicitly supplies a writable external Han Learn library, save there, respecting permissions. Do not assume a specific OS path or create a hidden directory in a user's home without permission.
3. **Explicit user destination:** Save to an exact location supplied by the user.
4. **No configured destination:** Provide readable documents in chat; ask where to persist them. **Do not silently create `learn/`, `.learn/`, or `han-dev/` inside the source repository.**

An optional repository-local destination is acceptable only when the user explicitly requests it. The skill's install folder is not a workspace for generated artifacts.

## Suggested external layout (illustrative only)

```text
<configured-library>/
  projects/
    <project-slug>-<stable-id>/
      tasks/
        001-opportunity-search/
          spec.md
          implementation.md
          learning.md
```

- Disambiguate projects using stable workspace identity, not the visible folder name alone; don't expose sensitive absolute paths in published content.
- Choose collision-safe task IDs. Preserve older task documents and revisions; never overwrite another task just because slugs match.
- Store a revision/commit reference and capture time when actually known. Do not invent IDs or dates.
- Keep agent-generated lessons separate from the user's annotations, highlights, comments, and progress records. Never replace student content when regenerating a lesson.
- Before saving, remove credentials, access tokens, sensitive configuration, and confidential customer information. For private client or company repositories, do not transmit source or documentation to external services without authorization.
- A successful tool call does not prove the web dashboard refreshed; report only what was confirmed.

## Portability

Avoid requiring MCP, Git, VS Code, or a custom dashboard just to draft a spec or answer a question. Without Git baseline evidence, explain the current code and disclose that a reliable before/after diff may be unavailable. Without filesystem access, compose the deliverable in chat instead of claiming to have written it.
