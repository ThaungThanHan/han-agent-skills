# UnrustReact — Feature Plan

> **Status:** Proposed · **Artifact:** AI Agent Skill (`$unrustreact`) · **Version target:** v0.1 MVP  
> **Primary goal:** Help developers regain and improve practical React, Next.js, JavaScript, and TypeScript problem-solving skills through realistic, hands-on coding challenges.

## 1. Product vision

**UnrustReact** is an interactive frontend coding trainer packaged as an Agent Skill. When invoked, it helps a learner choose a challenge, prepares an appropriately minimal coding environment, behaves as a tutor or interviewer according to the selected mode, reviews the learner's actual work, and reinforces transferable concepts.

It should feel like practicing with a knowledgeable frontend interviewer—not asking a chatbot to write an application.

### Guiding principles

1. **Learner writes the solution.** Never solve the assessed portion of a challenge during setup.
2. **Practice over passive explanation.** Require a genuine attempt before detailed solution disclosure, except when the learner explicitly requests a walkthrough.
3. **Realistic frontend work.** Favor components, state, async behavior, debugging, accessibility, testing, and performance—not only algorithm puzzles.
4. **Mode-driven behavior.** The same topic can be taught, practiced independently, or assessed in an interview.
5. **Randomized, not chaotic.** Select varied challenges within constraints, avoid known repeats, and balance topic coverage.
6. **Minimal scaffolding.** Provide only what the learner needs to begin; avoid unnecessary packages and elaborate architecture.
7. **Trustworthy feedback.** Separate verified execution results from reasoning-based reviews. Never claim tests ran unless they ran.
8. **Portable skill.** Use standard `SKILL.md` instructions; degrade gracefully when the host lacks interactive UI, terminal access, or persistent state.

## 2. Target audience and use cases

- **Rusty working developer:** Rebuilds confidence with React/Next.js live coding after a long break.
- **Frontend interview candidate:** Practices timed, unfamiliar challenges with follow-up questions.
- **Intermediate learner:** Understands concepts by implementing increasingly complex features.
- **Experienced engineer:** Practices diagnosing and repairing realistic bugs or extending existing code.

**Primary success outcome:** The learner can independently explain, implement, test, and adapt a solution to an unfamiliar but related frontend problem.

**Non-goals for the MVP:** Job board integration, collaborative real-time IDE, automatic deployment, external coding-judge accounts, AI-generated production applications, and guaranteed hidden/unseen challenges.

## 3. Invocation and configuration

### 3.1 Entry points

| Invocation | Expected behavior |
|---|---|
| `$unrustreact` | Start an interactive configuration flow; do not create a challenge before the user makes a selection or chooses Quick Start. |
| `$unrustreact interview medium nextjs random` | Parse supplied settings, ask only for genuinely blocking ambiguities, then generate the challenge. |
| `$unrustreact learn react hooks` | Infer Learn mode, React stack, hooks topic; ask only if a required setting cannot reasonably be defaulted. |
| `$unrustreact repeat` | Reuse the last session configuration if available in the current session, but generate a new challenge. |
| `$unrustreact review` | Review the current or explicitly identified attempt; request code/path only when it is not accessible. |
| `$unrustreact resume` | Continue an in-session challenge, or use an explicitly available progress record; never pretend to remember unavailable state. |

**Implementation note:** `$unrustreact` is the intended explicit invocation in supporting hosts (e.g., Codex). Exact invocation syntax, interactive selection tools, and command parsing are host-dependent. The skill must also work when the user says “use UnrustReact” in ordinary chat.

### 3.2 Configuration dimensions

| Setting | Choices | Recommended behavior |
|---|---|---|
| **Mode** | Learn, Practice, Interview, Build, Debug, Review | Required for a bare invocation; default to Practice only in Quick Start. |
| **Stack** | JavaScript, TypeScript, React + TypeScript, Next.js + TypeScript | Default to React + TypeScript in Quick Start. |
| **Difficulty** | Easy, Medium, Hard | Default to Medium in Quick Start. |
| **Topic** | Random or a specific category | Default to Random. |
| **Time budget** | 15, 30, 45, 60 minutes, or untimed | Suggest 30 minutes for Practice; 45 for Interview. |
| **Scaffolding** | None, snippet, minimal project, existing project | Suggest snippet for JS/TS-only, minimal project for React/Next.js. |
| **Hints** | Guided, on request, disabled until debrief | Determined by mode; user may override when not in strict interview simulation. |
| **Workspace** | New safe directory or user-specified existing path | Never modify an existing project without confirming the target and intended changes. |

**Interaction design:** If the host supports a structured choice/question tool, use it. Otherwise ask for the four main choices in one compact chat message, with optional defaults for the rest. Preserve any information supplied inline rather than re-asking it. A **Quick Start** option is permitted after bare invocation.

**Configuration preview example:**

```text
UnrustReact — Choose your session
Mode: [Learn] [Practice] [Interview] [Build] [Debug] [Review]
Stack: [JavaScript] [TypeScript] [React + TS] [Next.js + TS]
Difficulty: [Easy] [Medium] [Hard]
Topic: [Random] [Select category]
Optional: time budget, scaffolding

Reply with your choices, or say "quick start".
```

### 3.3 Session state

Maintain an explicit in-session record of selected configuration, challenge ID/title, objectives, files created, progress, hint count, test findings, misconceptions, and review result. Do **not** assume persistent memory across chat sessions.

Optional opt-in local persistence can be introduced later via a human-readable file, e.g. `.unrustreact/progress.json` or `progress.md`. Do not create tracking files without telling the learner; do not store personal data, API keys, or environment secrets.

## 4. Training modes

### Mode A — Learn

**Purpose:** Guided acquisition of a frontend concept.

- Confirm the learner's understanding of the task and relevant concepts.
- Break the challenge into meaningful milestones without implementing them.
- Ask focused questions and provide a graduated hint ladder (see §7).
- Review intermediate attempts and explain *why* an approach works.
- Finish with one variation that requires applying the concept in a slightly new context.

**Completion:** Learner can explain the implementation, its trade-offs, and solve an adjacent variation with less help.

### Mode B — Practice

**Purpose:** Independent, untimed or lightly timed problem-solving.

- Present requirements, examples, constraints, and acceptance criteria.
- Avoid unsolicited hints; respond to questions and review code on request.
- Permit iterative submissions and targeted test feedback.
- Debrief with correctness, missing edge cases, and a cleaner approach if useful.

**Completion:** Learner submits a working attempt and can summarize the main reasoning.

### Mode C — Interview

**Purpose:** Simulate a realistic frontend live-coding interview.

- Define a clear time budget and interviewer expectations.
- Present one unfamiliar, bounded task without naming the intended solution strategy.
- Answer clarification questions as an interviewer, without revealing implementation details.
- Withhold hints unless the candidate explicitly asks, and record their effect on assessment.
- Ask at least one follow-up about edge cases, performance, accessibility, architecture, or requirement changes.
- Debrief only after the candidate declares completion, ends the session, or asks to exit interview mode.

**Timing limitation:** Without a supported timer or live clock, the agent should give a recommended budget, ask the learner to track time, and avoid falsely claiming elapsed minutes or enforcing a deadline.

**Completion:** Evaluation includes implementation evidence, communication, testing, and follow-up reasoning.

### Mode D — Build

**Purpose:** Implement a small but realistic frontend feature inside a scaffold.

- Create a minimal project or use a user-approved existing project.
- Provide a feature specification and TODO boundaries.
- Leave the core feature incomplete.
- Optionally introduce a second requirement after the initial implementation is reviewed.

**Example:** Implement a searchable user directory, then add URL-synchronized filters.

### Mode E — Debug

**Purpose:** Diagnose defects in prewritten or supplied React/Next.js code.

- Supply a small runnable bug scenario, or work on the learner's own code with permission.
- Define observed behavior, expected behavior, and a reproducible case.
- Do not reveal the root cause immediately.
- Let the learner investigate, reproduce, fix, and add a regression check.
- Explain the root cause and preventative practices after the attempt.

**Example categories:** stale closures, missing effect cleanup, race conditions, unstable keys, hydration mismatches, incorrect memoization, invalid state updates.

### Mode F — Review

**Purpose:** Reinforce retention or review a previously attempted challenge.

- Request the learner to reconstruct the approach **before** reading the old solution.
- Test recall with a variation or follow-up.
- Assess what remains weak and recommend a targeted next challenge.
- If reviewing supplied code, distinguish code inspection from executed verification.

**Availability:** Reviewing the current session is part of the MVP; cross-session retention requires opt-in persistence and is a later enhancement.

### Why Random is not a seventh mode

**Random** describes **how a challenge is selected**; **mode** describes **how the agent behaves**. Every training mode except a direct code review can support random topic selection. This prevents unnecessary duplication of logic.

## 5. Challenge generation system

### 5.1 Topic taxonomy

1. React state and event handling
2. Controlled forms and validation
3. Hooks, effects, and cleanup
4. API calls, async flows, loading/error states
5. Component composition and reusable interfaces
6. Sorting, filtering, searching, and pagination
7. Data modeling and TypeScript generics
8. Rendering and performance optimization
9. Accessibility and keyboard interaction
10. Routing, URL state, and navigation
11. Next.js Server/Client Components and rendering behavior
12. Testing, error diagnosis, and regression prevention

Choose only topics appropriate for the selected stack. JS-only challenges must not quietly require a React environment. Next.js-specific features must be labeled as such.

### 5.2 Difficulty calibration

| Level | Target challenge | Typical scope |
|---|---|---|
| **Easy** | One self-contained behavior; clear inputs/outputs; few edge cases | Toggle, controlled input, filtering a list, fixing a simple event bug |
| **Medium** | Combine two or three concepts with meaningful edge cases | Search + pagination, API states, custom hook, reusable form, stale async response handling |
| **Hard** | Multiple interacting concerns, trade-offs, and follow-up changes | Generic DataTable, virtualized list reasoning, complex async state, URL-synchronized server pagination |

Difficulty must reflect conceptual burden and expected implementation size—not artificially vague requirements. An Easy challenge should not require a large multi-file setup.

### 5.3 Required challenge contract

Every generated challenge must contain:

- **ID, title, mode, stack, difficulty, topic, suggested time**
- **Scenario:** realistic user or product context
- **Goal:** what the learner is responsible for building or fixing
- **Functional requirements:** testable and numbered
- **Given inputs:** data shapes, mock API behavior, or starter project
- **Acceptance criteria:** observable outcomes
- **Edge cases / constraints:** a suitable subset, without leaking the intended implementation
- **Submission instructions:** what to share or where to work
- **Explicit ownership boundary:** what is scaffolded versus what the learner must implement

In Learn mode, examples and milestones can be revealed progressively. In Interview mode, give enough information to make the task fair, without disclosing a completed solution or the evaluation answer key.

### 5.4 Random selection and non-repetition

- Filter candidate categories by mode, stack, difficulty, and available environment.
- Favor under-practiced topics when a reliable session history exists; otherwise use balanced variety.
- Track challenge fingerprints (topic + core behavior + constraints) in the current session to minimize repeats.
- Offer **reroll** to replace a challenge without restarting configuration.
- Treat “random” as varied generation, not guaranteed statistical randomness or globally unique questions.
- Do not claim a challenge is new to the user without supporting history.

### 5.5 Challenge quality checks (before showing)

Check internally that the challenge:

1. Is compatible with the selected stack and mode.
2. Has a clear, feasible objective and unambiguous acceptance criteria.
3. Fits the time/difficulty budget reasonably.
4. Avoids contradictory requirements and unspecified APIs.
5. Does not contain the solution in starter code or a purported test fixture.
6. Has useful edge cases and a reviewable final result.

Regenerate or repair the challenge if it fails the checks.

## 6. Scaffolding and workspace behavior

### 6.1 Scaffolding levels

| Level | Deliverable | Use when |
|---|---|---|
| **None** | Problem statement only | Algorithmic JS/TS exercise or existing setup |
| **Snippet** | Function/component signature + sample inputs | Small conceptual challenge |
| **Minimal project** | Runnable app with dependencies, starter files, mock data, TODOs | React/Next.js feature challenge |
| **Existing project** | Restricted modifications in a confirmed directory | Real codebase practice/debugging |

### 6.2 Starter implementations

- **React:** Prefer React + TypeScript with a lightweight Vite setup for new, framework-agnostic React challenges.
- **Next.js:** Prefer a minimal Next.js App Router + TypeScript setup for Next-specific challenges.
- **JS/TS only:** Prefer a function-level exercise without framework boilerplate.
- Follow the environment's existing package manager where one is already established; avoid unnecessary UI libraries, state management libraries, and test frameworks.
- Do not hardcode stale version numbers; resolve compatible versions only when dependency installation is permitted and feasible.

**Illustrative project layout (only create files actually needed):**

```text
unrustreact-challenge/
├── package.json
├── src/
│   ├── App.tsx
│   ├── components/
│   │   └── SearchableList.tsx    # TODO: learner implementation
│   └── data/
│       └── users.ts
├── CHALLENGE.md
└── [minimal config files required by chosen toolchain]
```

For Next.js, use `app/` or `src/app/` instead of forcing the React/Vite layout.

### 6.3 Safe file operations

- Inspect the proposed destination before writing anything.
- Prefer a new challenge-specific directory; never silently overwrite user files.
- State which files will be created or changed.
- Respect the host's approval policy for shell commands, dependency installs, network access, and edits.
- Avoid modifying source outside the agreed workspace.
- Keep any completed answer or answer key out of learner-facing starter files.
- In a host without filesystem tools, provide copy-pasteable starter files and openly state that they were **not** written or executed.

### 6.4 Validation

When tools permit, verify:

1. Project metadata and scripts are present.
2. Dependencies install using the chosen toolchain (only when allowed).
3. The starter project builds or starts without unrelated errors.
4. Provided baseline tests (if any) run as intended.
5. Challenge-specific learner TODOs remain unsolved.

Some task-focused tests may intentionally fail until the learner implements the feature. Differentiate those expected failures from broken scaffolding. Report exactly what was executed, what passed/failed, and what could not be verified.

## 7. Tutoring, hints, and solution boundaries

### Progressive hint ladder

1. **Comprehension:** Rephrase the objective or highlight a relevant edge case.
2. **Conceptual:** Point toward the concept or state transition without naming the full algorithm.
3. **Structural:** Suggest a decomposition, data shape, or component boundary.
4. **Targeted pseudocode:** Help with the exact step where the learner is stuck.
5. **Worked explanation / code:** Only with explicit learner request or after the attempt has ended.

Rules:

- Ask one focused guiding question at a time when tutoring.
- Do not repeatedly insist on Socratic questioning when the learner asks for a direct explanation.
- Avoid providing near-complete code as a “small hint.”
- Admit uncertainty or errors, correct them, and keep the learner's original reasoning visible.
- Avoid praise that is unsupported by the submitted work.
- When revealing a full solution, explain the decisions and trade-offs rather than just pasting code.
- Interview mode should record requested hints, but a hint is not automatically a failure.

## 8. Code review and mastery feedback

Review submitted code for correctness first, then technical quality. Use a consistent but context-aware rubric:

| Criterion | Suggested weight | Evidence |
|---|---:|---|
| Correctness and acceptance criteria | 35% | Demonstrated behavior; tests; edge cases |
| React/Next.js and TypeScript fundamentals | 20% | State flow, hooks, types, server/client boundaries |
| Code clarity and maintainability | 15% | Naming, cohesion, unnecessary complexity |
| Testing and debugging process | 15% | Reproduction, assertions, edge-case checks |
| Communication and trade-offs | 15% | Explanations, clarification, improvements |

**Accessibility is a cross-cutting requirement** where applicable: keyboard use, labels, semantic markup, and sensible focus behavior must be considered within correctness and code quality.

In interview mode, record whether conclusions are based on observed implementation, user explanations, or executed tests. Do not derive a precise numeric score from missing evidence; mark relevant criteria **not assessed** instead.

### Review output format

1. **Result:** Met / Partially met / Not met / Not assessed, with concise rationale.
2. **Verified findings:** What was actually tested or inspected.
3. **Top 1–3 issues:** Repro steps or code references when available.
4. **What worked:** Evidence-based strengths.
5. **Improvement path:** Minimal actionable changes, without automatically rewriting the solution.
6. **Transfer check:** One adjacent question or requirement change.
7. **Next recommendation:** Reattempt, review concept, or advance difficulty.

Mastery is not equivalent to passing one attempt. Longer-term mastery requires independent reconstruction and a different related problem, preferably after a delay.

## 9. Workflow/state machine

```text
Invoke skill
   |
   v
Parse input --> Missing config? --> Ask choices / Quick Start
   |                                |
   +--------------------------------+
   |
   v
Resolve mode + stack + difficulty + topic + constraints
   |
   v
Choose or generate problem --> Quality check --> Reroll if requested
   |
   v
Prepare snippet/project (if requested) --> Validate baseline
   |
   v
Present challenge with acceptance criteria + learner TODOs
   |
   v
Learner attempts <--> Mode-specific guidance / clarification
   |
   v
Learner submits or ends session --> Inspect/test available artifacts
   |
   v
Debrief + feedback + transfer question
   |
   v
Continue / New problem / Repeat / Review / Exit
```

**Interruptions:** A learner may change mode, stack, or difficulty. Clearly explain whether the change applies to the active challenge or a newly generated one. Preserve the original attempt unless the user explicitly asks to discard it.

## 10. Skill package and ownership

Follow the Agent Skills convention: required `SKILL.md` with YAML frontmatter (`name: unrustreact`, a clear trigger-oriented `description`), plus only resources that directly support execution. Keep the main instructions concise and progressively load focused references.

```text
unrustreact/
├── SKILL.md                         # Entry point, routing, guardrails
├── references/
│   ├── configuration.md             # Parsing, defaults, session behavior
│   ├── challenge-design.md          # Taxonomy, difficulty, quality rubric
│   ├── modes.md                     # Learn, Practice, Interview, Build, Debug, Review
│   ├── scaffolding.md               # Minimal templates and validation
│   └── evaluation.md                # Review, hints, mastery, test scenarios
└── assets/                          # Add only if static templates prove useful
    └── [optional starter templates]
```

Add `scripts/` **only** if a deterministic helper materially improves reliability, e.g. scaffold validation or challenge metadata linting. Avoid speculative wrappers or premature multi-agent orchestration. For Codex-specific UI/invocation configuration, consider an optional `agents/openai.yaml` only when actual Codex behavior requires it; do not assume host-specific capabilities are universal.

## 11. Delivery roadmap

### Phase 1 — MVP (must-have)

- [ ] Create valid `SKILL.md` metadata and clear activation instructions.
- [ ] Support bare `$unrustreact` with interactive chat configuration and Quick Start.
- [ ] Parse inline configuration and avoid redundant follow-up questions.
- [ ] Implement Learn, Practice, and Interview behaviors.
- [ ] Implement random/topic-based challenge selection for JS, TS, React, and Next.js.
- [ ] Define difficulty calibration and mandatory challenge contract.
- [ ] Generate snippets and minimal runnable React/Next.js scaffolds.
- [ ] Preserve learner-owned implementation boundaries and safe workspace handling.
- [ ] Review attempts using a concise, evidence-based rubric.
- [ ] Track active configuration, hint usage, and challenge identity within the session.
- [ ] Validate the skill metadata and run realistic end-to-end test cases.

**MVP exit condition:** A user can invoke the skill, choose a mode, receive a feasible unsolved challenge, work on it, request feedback, and get a grounded review—without the agent implementing the task for them.

### Phase 2 — Expanded practice

- [ ] Add Build and Debug modes with prepared defect patterns.
- [ ] Add Review mode for reconstructing previously attempted solutions within a session.
- [ ] Add reroll and repeat commands.
- [ ] Add progressive requirement changes and interview follow-up questions.
- [ ] Add optional baseline tests and robust scaffold verification.
- [ ] Expand topic coverage, particularly async races, accessibility, testing, and Next.js boundaries.

### Phase 3 — Adaptive retention (optional)

- [ ] Introduce opt-in local progress persistence.
- [ ] Track attempts, hint dependence, recurring misconceptions, and topic coverage.
- [ ] Recommend next topics based on demonstrated weakness, not just successful completions.
- [ ] Add delayed recall and transfer challenges.
- [ ] Validate whether stronger reviewer separation improves review quality enough to justify extra tokens.

## 12. Acceptance tests and quality gates

Use an isolated temporary workspace for tests so evaluation cannot overwrite real user files. Test **agent behavior and generated artifacts**, not just the wording in `SKILL.md`.

| ID | Scenario | Expected outcome |
|---|---|---|
| T01 | Bare `$unrustreact` | Presents compact configuration; no premature challenge. |
| T02 | Full inline invocation | Starts directly, with parsed mode/stack/difficulty/topic. |
| T03 | Partial configuration | Asks only for missing essential information or uses stated defaults. |
| T04 | Learn + Easy + React | Explains milestones; gives graduated hints; learner retains implementation. |
| T05 | Interview + Medium + Next.js | Bounded task, interviewer behavior, no solution leak, debrief after attempt. |
| T06 | Random selection twice | Different challenge fingerprints where possible; reroll works. |
| T07 | React/Next.js project scaffold | Baseline is runnable or limitations are reported; core TODO is unsolved. |
| T08 | Existing nonempty workspace | No silent overwrite; scope and changes confirmed. |
| T09 | User submits incorrect code | Finds concrete issue, distinguishes observed from inferred findings. |
| T10 | User asks for full solution | Honors explicit request and explains reasoning clearly. |
| T11 | No terminal/file tools available | Provides honest, usable copy-paste scaffold with no fabricated validation. |
| T12 | User changes mode mid-session | Preserves work; explains whether a new challenge is required. |
| T13 | Debug mode (Phase 2) | Reproducible bug, no premature root cause, regression guidance. |
| T14 | Review/retention (Phase 3) | Verifies recall or transfer; does not fabricate past performance. |

### Evaluation method

1. **Instruction review:** Check activation, mode routing, conflicting instructions, prompt clarity, and overlong references.
2. **Execution review:** Invoke the real skill against representative scenarios and inspect the resulting files, challenge statements, build/test output, and feedback.
3. **Regression review:** After changes, rerun core scenarios and compare correctness, solution leakage, setup time, and unnecessary token usage.

Start with one implementer/tester pass. Optionally use an independent reviewer for high-impact or disputed findings; multiple agents are not inherently better and should be justified by observed quality improvement.

### MVP quality bar

- [ ] Valid Agent Skills metadata (`name` matches directory; useful `description`).
- [ ] All six modes are described, with MVP modes actually tested; phase-gated modes are not falsely presented as implemented.
- [ ] Every generated task is solvable and has testable acceptance criteria.
- [ ] No answer leakage in starter code, TODOs, sample data, or visible test fixtures.
- [ ] No destructive file operations without approval.
- [ ] Reported build/test results are reproducible and not fabricated.
- [ ] Challenge matches requested mode, stack, difficulty, and topic.
- [ ] A learner can progress from setup to feedback without dead ends.

## 13. Example user journey

**User:** `$unrustreact interview medium react random`

**Agent:**

> **Challenge: Searchable User Directory** · React + TypeScript · Medium · 45 minutes  
> Build a directory that filters users by name, supports ascending/descending sorting, and paginates 10 results per page. Search and sort changes must reset the page when appropriate. Provide an empty state and accessible input labels.  
> Starter project and sample data are available; you must implement filtering, sorting, and pagination yourself.  
> You may ask clarification questions. Say **submit** when ready for review.

**User:** Asks about sorting behavior, implements solution, submits.

**Agent:** Inspects available source; runs available checks; identifies verified issues; asks about page-reset behavior or keyboard accessibility; gives a debrief and one follow-up requirement.

**Success signal:** The learner can adapt the implementation when asked to synchronize query parameters with the URL, without being shown a completed rewrite.

## 14. Open design decisions (recommended defaults)

| Decision | Recommended choice | Rationale |
|---|---|---|
| Main entry behavior | Configure first; allow Quick Start | Discoverable without forcing setup on returning users |
| Default stack | React + TypeScript | Broad frontend relevance |
| First implemented modes | Learn, Practice, Interview | Highest immediate utility and least scaffolding complexity |
| Random as mode or selector | Selector | Avoid duplicated behavior |
| Default frontend scaffold | Vite for React; App Router for Next.js | Lightweight and framework-appropriate |
| Auto-generated tests | Baseline smoke checks first | Avoid accidentally shipping solution-bearing tests |
| Progress persistence | Opt-in, post-MVP | Portable and privacy-conscious |
| Agent architecture | One mode-switching agent | Lower cost and less context fragmentation; split only if proven beneficial |

## 15. Definition of done for skill creation

The skill is ready for a v0.1 release when the MVP checklist and relevant acceptance tests pass **in the intended host environment**, a new learner can start with `$unrustreact` and complete an honest end-to-end practice session, and the generated scaffold is minimal, safe, and demonstrably usable. Record unsupported environments as limitations rather than silently simulating capabilities.

---

### Standards and implementation references

- [Agent Skills Specification](https://agentskills.io/specification) — required `SKILL.md` frontmatter, directory layout, and progressive disclosure.
- [OpenAI Codex skill-creator sample](https://github.com/openai/codex/blob/main/codex-rs/skills/src/assets/samples/skill-creator/SKILL.md) — guidance for minimal skill packaging, validation, and forward-testing.

*This file is a feature and implementation plan—not the finished `SKILL.md` or a deployed scaffolder.*
