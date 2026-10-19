# Minimal scaffolding and verification

Choose the least setup that lets the learner start:

| Level | Output |
| --- | --- |
| None | Challenge statement only. |
| Snippet | Function or component signature, sample input, and learner TODO. |
| Minimal project | Runnable starter with only required files, mock data, scripts, and TODOs. |
| Existing project | Changes confined to a confirmed target and scope. |

For JavaScript/TypeScript-only tasks, prefer a function-level exercise. For a fresh React task, prefer React + TypeScript with a small Vite app. For a Next.js-specific task, prefer a minimal TypeScript App Router app. Use an existing package manager and conventions when the target project has them. Avoid unnecessary libraries, state managers, UI kits, and test frameworks. Check current framework/toolchain guidance when installation commands or versions matter; do not pin guessed or stale versions.

Before writing, inspect the proposed destination. Prefer a new challenge-specific directory. For an existing nonempty project, establish the target and intended files from the learner's request; ask only if either remains unclear. State the files created or changed. Never silently overwrite learner files, and keep a completed answer or answer key out of learner-facing code, fixtures, and TODOs. Make starter code syntactically valid and keep its assessed behavior unimplemented.

When tools permit, check that metadata/scripts exist, install dependencies only when authorized and feasible, then run a build or smoke check. Distinguish baseline failures from task-focused tests expected to fail until the learner completes the TODO. Report the exact commands and outcomes. If tools cannot write or run files, provide copy-pasteable starter files and say explicitly that they were not written or executed.
