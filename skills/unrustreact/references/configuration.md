# Configuration and session flow

## Entry behavior

For a bare invocation, present a compact choice prompt:

```text
UnrustReact — choose a session
Mode: Learn / Practice / Interview / Build / Debug / Review
Stack: JavaScript / TypeScript / React + TypeScript / Next.js + TypeScript
Difficulty: Easy / Medium / Hard
Topic: Random or a topic you name
Reply with choices or “quick start”. Optional: time and scaffold.
```

Do not create a challenge at this step. Preserve inline choices, including a user-specified path, time, or scaffold. Ask a follow-up only when an essential choice remains genuinely ambiguous. For a partially specified non-bare request, infer reasonable defaults and state them briefly before beginning.

Quick Start means Practice, React + TypeScript, Medium, Random, 30 minutes, and a minimal new project. For an inline request, default omitted mode to Practice, stack to React + TypeScript, difficulty to Medium, and topic to Random when these defaults do not conflict with the user's words. Suggest 30 minutes for Practice and 45 for Interview; other modes may be untimed. A time budget is a suggestion unless a supported clock is actually used.

Scaffold choices are none, snippet, minimal project, and existing project. Default JS/TS-only work to a snippet and React/Next.js feature work to a minimal project. Honor an explicitly requested level even when another default would be more common. Never infer that a bare invocation chose Quick Start.

## Session commands

- `repeat`: Reuse the last available configuration but generate a different challenge. If no prior configuration is available, ask for choices.
- `reroll`: Replace the proposed challenge with a different topic/behavior fingerprint within the same configuration. Preserve any attempt already made; do not delete files or overwrite the prior task.
- `review` or `submit`: Inspect the current or named attempt. Ask for code/path only when inaccessible or ambiguous.
- `resume`: Continue the in-session task or an explicitly supplied progress record. If neither is available, explain that the prior session is unavailable and offer to start again.
- Settings change: Clarify whether the new setting applies to the active task or the next one when that affects the learner's work. Preserve existing files and attempt notes.

Keep a small in-conversation record: mode, stack, difficulty, topic, time, scaffold, challenge ID and fingerprint, destination, learner TODOs, hint count, observed checks, and review findings. Track repeats only from available history. Do not imply globally unique or unseen challenges.

Do not create `.unrustreact/` progress files by default. If the learner opts in, use a human-readable record in the agreed workspace, tell them what it contains, and omit personal data, secrets, and environment values.
