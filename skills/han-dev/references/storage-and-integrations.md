# Documentation storage and optional integrations

Documentation should be useful **without** the future Han Learn dashboard, VS Code extension, or MCP server.

## Resolve the project root and output destination

The default is the **project-local `.dev-docs/` directory**, deliberately outside application source modules but inside the project root. This convention is user-authorized for Han Dev documentation; it does not require a Han Learn dashboard, MCP server, or configured external library.

1. **Choose the project root carefully:** Honor an explicitly selected project directory first. Otherwise use the one active VS Code workspace folder or a clearly established current project; if a multi-root workspace is ambiguous, resolve the intended project before writing. Do not jump to the Git repository root when an explicit project/package target is different.
2. **Honor an explicit destination override:** If the user expressly specifies an alternate writable folder or connected storage tool, use it instead. Only call tools that actually exist and verify successful saves.
3. **Create when required:** For `--spec=markdown|both` and/or `--docs=markdown|both`, create `<project-root>/.dev-docs/` if it does not exist, then a collision-safe task subfolder. Do not create the directory if both outputs are chat-only.
4. **Store the default four files in one task folder:** `--spec=markdown` (default) saves `spec.md` during the specification phase; `--docs=markdown` (default) saves `implementation.md`, `code-walkthrough.md`, and `learning.md` there after implementation. Reuse the same unique task folder for both phases. The flags remain independent: `--spec=chat` omits `spec.md`; `--docs=chat` omits post-implementation Markdown files.
5. **Stay within the selected destination:** Guard against unsafe path traversal, file collisions, symlink escapes, overwrites of another task, and accidental inclusion of generated docs in application-code edits. Do not edit `.gitignore` automatically; users may choose whether to version-control `.dev-docs/`.
6. **Verify each save:** Report exact confirmed saved paths. If filesystem access or write permissions are absent, provide the relevant documents in chat and explicitly disclose that files were not created. Never invent a path or claim a server/dashboard has refreshed.

## Default task layout

```text
<project-root>/
  .dev-docs/
    <unique-task-id>-<short-slug>/
      spec.md             # default: created during specification phase
      implementation.md   # by default after approved implementation
      code-walkthrough.md # by default after approved implementation
      learning.md         # by default after approved implementation
```

- Use a short, stable identifier for each task and an increment/revision scheme that avoids overwriting previous tasks. An explicit human-readable slug is helpful, but not sufficient to guarantee uniqueness. **Keep the task identifier stable between specification, approval, implementation, and learning.**
- When `--spec=chat` is explicitly selected, place an accurate summary of the approved scope and acceptance criteria in the later implementation report; **do not pretend a file-based specification exists**.
- Store a revision/commit reference and capture time only when actually known. Do not invent IDs or dates. In `code-walkthrough.md`, include source paths, symbols, relevant line ranges where verified, and short before/after excerpts tied to the captured pre-task baseline; keep source links relative to the task folder when possible.
- Keep generated lessons separate from student annotations, highlights, comments, and progress records. Never overwrite student content when regenerating a lesson.
- Remove credentials and sensitive values from generated content. For private company projects, do not transmit code or documentation to external services without authorization.

## Portability

Avoid requiring MCP, Git, VS Code, or a custom dashboard just to draft a spec or answer a question. Without Git baseline evidence, explain the current code and disclose that a reliable before/after diff may be unavailable. Without filesystem access, compose the deliverable in chat instead of claiming to have written it.
