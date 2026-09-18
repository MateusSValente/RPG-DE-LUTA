# AGENTS.md — RPG-DE-LUTA

## Mandatory first read

Any AI/model/agent working in this repository MUST read, in this order, before changing files:

1. `AGENTS.md`
2. `docs/AI_PRODUCTION_OPERATING_MODEL.md`
3. `docs/ART_PRODUCTION_MEGA_SPEC.md`
4. the feature/version-specific spec for the task
5. the current Git state (branch, HEAD, modified/uncommitted files when local access exists)

For Durotar animation work also read:

- `docs/art/animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`
- the current versioned animation spec
- the relevant Master/Weapon Master

---

# 1. Core operating model

The project is **evidence-first, source-first, fail-closed and gate-driven**.

Default workflow:

```
RECOVER ORIGINAL SOURCE
        ↓
VALIDATE SOURCE
        ↓
EXTRACT / INSPECT WITHOUT MUTATION
        ↓
MEASURE
        ↓
DIAGNOSE
        ↓
DECIDE GO / NO-GO
        ↓
STOP AT THE CURRENT GATE
```

Only after evidence proves a modification is necessary:

```
MINIMUM TARGETED CHANGE
        ↓
VALIDATE
        ↓
PREVIEW
        ↓
RUNTIME QA
        ↓
APPROVAL
```

Do not jump from diagnosis directly to generation, refactor, redraw, replacement or integration.

---

# 2. Preserve what already works

Approved or canonical assets/code are not raw material to casually regenerate.

If the problem may be solved by:

- timing;
- metadata;
- offsets;
- configuration;
- runtime logic;
- data-driven tuning;
- a local fix;

test those routes before replacing approved source.

**Do not solve a technical problem by recreating an approved artistic asset.**

**Do not solve a local bug by rewriting an entire subsystem.**

---

# 3. Source authority

When an original source exists in Git, use it directly.

Preferred evidence order:

1. canonical source file in repository;
2. approved Master/spec;
3. reproducible measurements from the source/runtime;
4. validated derived artifact;
5. diagnostic guide/reference;
6. generated candidate;
7. textual assumption.

A generated image is never authoritative over an approved source asset.

A screenshot/presentation board is never preferred over the raw runtime asset when the raw asset exists.

---

# 4. Fail-closed

Stop when required evidence is missing, ambiguous, corrupted or inaccessible.

Examples:

- expected asset cannot be retrieved;
- dimensions differ from contract;
- binary fails import/load;
- source and spec conflict;
- current branch/state is uncertain before a destructive Git operation.

Never improvise a replacement and present it as the original.

Report exactly what is missing.

---

# 5. Gate discipline

Every substantial task must state the current gate.

At the end of a gate:

1. produce evidence/deliverables;
2. list objective findings;
3. issue GO / NO-GO for the **next gate only**;
4. stop if user approval is required.

Do not execute the next gate just because it is obvious.

If the user explicitly authorizes multiple gates, each gate must still be validated before proceeding.

---

# 6. Measurements before assumptions

Do not inherit old tuning values without re-validating them against the current source.

Examples:

- frame count;
- cycle distance;
- animation FPS;
- root offsets;
- body height;
- baseline;
- hitbox size;
- timings;
- scale.

Historic values are hypotheses unless the current version explicitly locks them.

---

# 7. Existing animation/source rule

For an existing animation:

```
RAW SOURCE
→ LOSSLESS EXTRACTION
→ IN-PLACE PREVIEW
→ WORLD-SPACE / RUNTIME MEASUREMENT
→ DATA/TIMING/OFFSET TUNING
→ QA
```

Only create new drawings if a **specific measured transition** still fails.

Do not force additional frames because a previous plan targeted a certain count.

Frame count is an output of quality requirements, not a quality metric.

---

# 8. New animation rule

For a truly new animation with no approved source:

```
MASTER + WEAPON MASTER
→ VERSIONED ANIMATION_SPEC
→ KEYPOSE PLAN
→ KEYPOSE REVIEW
→ TARGETED IN-BETWEENS IF REQUIRED
→ NORMALIZATION
→ PREVIEW QA
→ RUNTIME QA
```

Generation is subordinate to the Master and spec.

---

# 9. Image generation policy

Use generative image tools only when the task genuinely requires new art.

Never use generation to:

- "extract" an existing frame;
- reproduce an existing canonical sprite;
- create a fake before/after comparison;
- replace a source asset that can be read directly;
- hide an unresolved technical problem.

When new art is justified, generated output is a **candidate**, not an approved asset.

---

# 10. Non-destructive analysis

Diagnostic outputs must be separate from canonical assets.

Allowed examples:

- extracted copies;
- GIF previews;
- debug overlays;
- measurement JSON/CSV/Markdown;
- contact markers;
- baseline overlays.

Do not paint debug information into the source asset.

---

# 11. Runtime authority

CI/import success proves technical loadability, not gameplay quality.

Visual/gameplay assets require Runtime QA.

For motion, distinguish:

- **in-place preview**: continuity, jitter, scale, pose, loop;
- **world-space/runtime preview**: foot slide, stride, displacement, gameplay coherence.

Do not claim foot planting is solved from an in-place preview alone.

---

# 12. Git safety

Do not use destructive commands such as:

- `git reset --hard`;
- `git clean -fd`;
- deleting local experiments;

unless the user explicitly approves and recoverability is proven.

Do not overwrite a `LOCKED` or approved version silently.

Use versioned files/branches.

Do not claim a file/commit exists until verified after the write.

---

# 13. Architecture

The game must remain modular and data-driven.

Avoid:

- monoliths;
- per-frame gameplay `if/elif` scattered through code;
- per-building/per-attack duplicated algorithms;
- runtime art distortion to compensate for bad assets.

Prefer:

- reusable systems;
- declarative data;
- versioned specs;
- isolated debug tooling;
- fail-closed validation.

---

# 14. Evidence standard

When feasible, record objective evidence such as:

- file path + branch/ref;
- dimensions;
- SHA/hash;
- pixel equality for lossless extraction;
- bounding boxes;
- baselines;
- timings;
- measured offsets;
- runtime captures;
- exact failing transition.

Avoid vague conclusions such as "looks weird" when a technical description is possible.

---

# 15. Anti-loop rule

If two consecutive attempts fail for the same underlying reason, STOP and reassess the method.

Do not keep repeating the same operation with slightly different prompts/settings.

Ask:

1. Are we modifying the correct source?
2. Are we solving an art problem or a runtime/data problem?
3. Are we using a derived/generated artifact instead of the canonical source?
4. Did we skip measurement?
5. Did we advance a gate without approval?
6. Is the pipeline itself causing the failure?

The WALK_V3 regeneration loop is the canonical example of what not to repeat.

---

# 16. Handoff requirement

Before ending a substantial workstream, ensure Git contains enough context for another model to continue without relying on chat memory.

Document:

- current gate/status;
- source of truth;
- rejected routes and why;
- current branch/known stable ref when relevant;
- next authorized gate;
- explicit prohibitions;
- measurements/evidence;
- GO/NO-GO decision.

Chat context is supplementary. Git documentation is the durable project memory.
