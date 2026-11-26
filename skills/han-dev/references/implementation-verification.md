# Implementation and verification

Read after explicit approval of a specific spec revision.

## Before writing code

1. Restate the approved scope and acceptance criteria.
2. Re-read affected files. Compare any changes since specification approval; if the premise changed materially, ask for amended approval.
3. Identify the baseline without erasing user work:
   - In Git: examine `git status --short`, relevant `git diff -- <paths>`, and `git diff --cached -- <paths>`; inspect untracked relevant files.
   - Capture the **actual initial content** of relevant existing files when feasible. `HEAD` is not necessarily the correct "before" state if the user has uncommitted changes.
   - Record which preexisting changes are user-owned. Avoid attributing them to Han Dev.
   - In a non-Git workspace, preserve a comparison snapshot through an approved mechanism and disclose if a full baseline is unavailable.
4. Do not stage/commit, overwrite or discard existing changes without authorization.

## Implement

- Follow the smallest coherent path from approved requirement to tested behavior. Respect existing conventions and ownership boundaries.
- Write tests reflecting behavior and acceptance criteria when practical; do not manufacture tests merely to look comprehensive.
- Cover successful and meaningful failure paths, such as invalid input, loading/empty states, permissions, retries, and cleanup, only where relevant.
- Avoid unnecessary dependencies, unrelated refactors, and speculative abstractions.
- If work touches credentials, user information, permissions, financial data, or potentially destructive migrations, exercise the required project safety and approval controls. Use [impact assessment](./impact-assessment.md) to prioritize higher-risk code paths and checks.
- When a new issue requires materially expanding scope, pause the affected work and present a spec amendment.

## Verify

- Select applicable checks from project scripts, existing tests, type checks, lint rules, build commands, and targeted manual reproduction. Do not invent command names.
- Run checks only with permitted tools and appropriate safeguards for destructive or external operations.
- Report each check as **passed**, **failed**, **not run**, or **blocked**, with reason and salient output; distinguish test existence from execution.
- Do not conflate passing unit tests with production correctness or security guarantees.
- If checks fail, investigate and fix issues within approved scope; if blocked, clearly state uncertainty.

## Finish

- Inspect final relevant files and diff for accidental changes.
- Distinguish new files, modified files, removed files, and unchanged planned files.
- Check acceptance criteria individually against evidence and mark unverified ones.
- Reassess **actual change impact** independently of test status, including affected callers and failure modes. Call out unverified High/Critical paths explicitly.
- Produce the implementation report and learning lesson; see [change analysis](./change-analysis-and-teaching.md) and [impact assessment](./impact-assessment.md).
- No automatic commits, pushes, deployments, or PRs. Those are separate actions requiring user authorization.
