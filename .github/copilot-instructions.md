# RPG-DE-LUTA — AI/Copilot Instructions

Before changing this repository, read:

1. `/AGENTS.md`
2. `/docs/AI_PRODUCTION_OPERATING_MODEL.md`
3. the task-specific/versioned spec

Mandatory behavior:

- source-first;
- evidence-first;
- fail-closed;
- non-destructive analysis;
- minimum targeted change;
- GO/NO-GO at gates;
- stop before the next gate when approval is required;
- never regenerate an approved asset merely to solve timing/runtime/data problems;
- preserve modular/data-driven architecture.

If any instruction here conflicts with `AGENTS.md`, follow `AGENTS.md`.
