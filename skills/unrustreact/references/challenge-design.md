# Challenge design

## Pick a fitting task

Filter by the learner's stack, mode, difficulty, topic, time, and available environment. Suitable topic families include state and events; forms; hooks and effects; async loading/error handling; component composition; search/sort/pagination; TypeScript data modeling; rendering performance; accessibility; routing and URL state; Next.js server/client behavior; and testing/debugging. A JavaScript-only task must not require React. Label Next.js-specific behavior clearly.

Calibrate scope:

| Difficulty | Scope |
| --- | --- |
| Easy | One self-contained behavior and a few clear edge cases. |
| Medium | Two or three interacting concepts with meaningful edge cases. |
| Hard | Several concerns or trade-offs plus a bounded follow-up change. |

Make difficulty reflect conceptual work, not vague wording or a large setup. Select a different fingerprint (topic + core behavior + important constraints) on `reroll` or `repeat` when available history permits. Do not claim statistical randomness or that the learner has never seen a task.

## Challenge contract

Every generated challenge identifies its ID (session-local is fine), title, mode, stack, difficulty, topic, and suggested time. Include:

1. A realistic scenario and the learner's goal.
2. Numbered, testable functional requirements.
3. Given data shapes, mock API behavior, or starter project details.
4. Observable acceptance criteria and relevant edge cases.
5. Submission instructions and a clear boundary between scaffolded code and learner-owned work.

In Learn mode, reveal milestones progressively when useful. In Interview mode, give enough information to make the task fair, but do not disclose the intended implementation strategy or hidden answer key. Keep requirements feasible within the time and difficulty. Avoid unspecified APIs and contradictory behavior.

Before presenting, check stack compatibility, solvability, acceptance criteria, time, edge cases, and answer leakage in starter code or fixtures. Repair the task if any check fails. Favor practical frontend behavior over algorithm puzzles unless the user requests an algorithm exercise.
