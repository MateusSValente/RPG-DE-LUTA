# AI_PRODUCTION_OPERATING_MODEL — RPG-DE-LUTA

**Version:** 1.0.0  
**Status:** NORMATIVE  
**Scope:** AI-assisted engineering, gameplay, art, animation, assets, QA and Git workflows  
**Primary rule:** preserve verified sources, measure before changing, and stop at gates.

---

# 1. Why this document exists

RPG-DE-LUTA is intentionally developed with heavy AI assistance.

The main production risk is not lack of generation capability. It is an AI/model:

- forgetting the actual current state;
- replacing a valid source instead of inspecting it;
- solving the wrong layer of the problem;
- inventing missing facts;
- advancing too many steps at once;
- repeating a failed strategy;
- declaring success without runtime evidence.

This document defines the mandatory operating method so different models can continue the project consistently.

---

# 2. Golden loop

The default method is:

```
SOURCE
  ↓
VALIDATE
  ↓
EXTRACT / OBSERVE
  ↓
MEASURE
  ↓
DIAGNOSE
  ↓
GO / NO-GO
  ↓
STOP
```

If a change is proven necessary:

```
MINIMUM CHANGE
  ↓
VALIDATE
  ↓
PREVIEW
  ↓
RUNTIME
  ↓
QA
  ↓
LOCK / REJECT
```

The project favors **evidence over intuition** and **minimal intervention over recreation**.

---

# 3. Source-first rule

Before creating anything, determine whether the requested thing already exists.

Search in this order:

1. current repository/branch;
2. canonical asset/spec paths;
3. versioned historical sources;
4. user-provided source;
5. only then consider creating a missing artifact.

If a raw asset exists, use it.

Bad:

```
user shows sprite sheet
→ AI redraws sprite from visual reference
→ identity drifts
```

Good:

```
raw sprite exists in Git
→ fetch raw binary
→ validate dimensions/hash
→ slice exact cells
→ analyze unchanged pixels
```

---

# 4. Authority hierarchy

Authority is contextual, but the default ordering is:

## 4.1 Existing approved asset

1. approved/canonical raw source;
2. Master / Weapon Master / locked contract;
3. version-specific spec;
4. objective measurements/runtime evidence;
5. diagnostic guides;
6. generated candidates;
7. prompt assumptions.

## 4.2 New asset that does not yet exist

1. project normative specs;
2. Character/Weapon/Style Master;
3. versioned feature/animation spec;
4. approved key poses/reference;
5. generated candidate.

Generated content never becomes authority merely because it looks plausible.

---

# 5. Fail-closed behavior

A model must stop instead of guessing when:

- source cannot be retrieved;
- source validation fails;
- binary integrity is uncertain;
- dimensions do not match contract;
- two normative documents conflict and hierarchy does not resolve them;
- the user-approved reference is unavailable for an identity-critical generation;
- destructive Git action could erase uncommitted work;
- the next gate requires approval that has not been given.

Required response:

```
BLOCKED
Expected: <what was required>
Observed: <what exists>
Missing/conflict: <exact issue>
Next safe action: <one action>
```

---

# 6. Gate model

Each task should have a named gate.

Examples:

- SOURCE_DISCOVERY
- SOURCE_VALIDATION
- RAW_FRAME_AUDIT
- IN_PLACE_PREVIEW
- WORLD_SPACE_MEASUREMENT
- RUNTIME_TUNING
- KEYPOSE_REVIEW
- PREVIEW_QA
- RUNTIME_QA
- LOCKED

At a gate boundary:

- state what was validated;
- provide artifacts/evidence;
- identify exact failures;
- give GO/NO-GO only for the next gate;
- stop when approval is required.

A GO for analysis does not mean GO for art generation.
A GO for import does not mean GO for Runtime QA.
A GO for Runtime QA does not automatically mean LOCKED.

---

# 7. Preserve approved work

Before replacing something, ask whether the defect belongs to:

- source art;
- timing;
- metadata;
- runtime offsets;
- gameplay movement;
- code;
- data/configuration;
- import pipeline;
- presentation/debug tooling.

Fix the responsible layer.

Examples:

- foot sliding may be stride/timing/root displacement, not a reason to redraw the character;
- a baseline mismatch may be metadata before it is an art defect;
- a hitbox problem must not be solved by enlarging the sword sprite;
- missing visual punch must not automatically be hidden with VFX.

---

# 8. Analysis must be non-destructive

Create derived diagnostic artifacts instead of editing sources.

Examples:

- exact extracted frames;
- contact-sheet copies;
- GIF/MP4 previews;
- overlays;
- measurement reports;
- JSON metadata;
- temporary debug scenes.

The canonical asset remains untouched until a specific modification receives authorization.

---

# 9. Binary asset protocol

For PNG/WebP/audio/model binaries:

1. retrieve the canonical file;
2. verify it can be decoded/imported;
3. record expected and actual dimensions/type;
4. hash it when useful;
5. validate derived extraction against the source;
6. only then use it downstream.

For a lossless frame slice, verify pixel equality between the source region and output.

Technical loadability and visual approval are separate gates.

---

# 10. Animation protocol — existing source

If an animation already exists:

```
SOURCE_LOCKED
→ LOSSLESS_EXTRACTION
→ RAW_FRAME_AUDIT
→ IN_PLACE_PREVIEW
→ WORLD_SPACE_MEASUREMENT
→ RUNTIME/DATA_TUNING
→ QA
```

Do not assume the phase labels.

Derive them from the real frames.

Do not inherit old cycle distance/timing automatically.

Measure the source and runtime first.

Only create a new drawing when a particular transition remains deficient after data/runtime tuning.

---

# 11. Animation protocol — new source

If no approved animation exists:

```
MASTER
→ ANIMATION_SPEC
→ KEYPOSE_PLAN
→ KEYPOSE_REVIEW
→ ONLY NECESSARY IN-BETWEENS
→ NORMALIZATION
→ PREVIEW_QA
→ RUNTIME_QA
```

Frame count is a planning hypothesis.

It may increase or decrease if evidence supports the change.

Do not equate more frames with higher quality.

---

# 12. In-place versus world-space

These are different tests.

## In-place

Same root/pivot for every frame.

Use it to inspect:

- scale drift;
- baseline drift;
- upper-body jitter;
- weapon jitter;
- silhouette;
- loop continuity.

## World-space

Apply the real or candidate gameplay displacement.

Use it to inspect:

- planted-foot drift;
- stride distance;
- cycle-distance coherence;
- acceleration/start/stop;
- movement responsiveness.

A foot can look stable in-place and still slide in world-space.

---

# 13. Generative-art gate

Image generation is allowed when:

- genuinely new art is required; or
- a specific missing transition/region has been proven necessary.

It is not allowed as a substitute for extraction or measurement.

For existing art, prefer:

1. no art change;
2. data/runtime correction;
3. deterministic/local pixel correction;
4. constrained regional edit;
5. generated new content only as the last reasonable route.

Every generated result is `CANDIDATE` until validated.

---

# 14. The anti-loop rule

A repeated failure is evidence about the method.

After two failures with the same root cause:

```
STOP
→ identify common cause
→ roll back to last trusted source/gate
→ change method
```

Do not produce attempt #3 by merely changing prompt wording.

Canonical WALK_V3 lesson:

```
wrong:
pose guide → regenerate Durotar → identity drift → regenerate Durotar again

correct:
raw walk.png → validate → exact extraction → measure → runtime test
```

---

# 15. Objective reporting

Prefer technical statements:

- "source is 512×128";
- "frame bbox is 68×99";
- "bottom opaque pixel reaches Y=118";
- "W03→W00 requires the largest in-place alignment";
- "pixel equality PASS";

over:

- "looks off";
- "feels weird";
- "seems better".

Human visual judgment still matters, but technical claims require technical evidence.

---

# 16. Git as durable memory

Git is the long-term continuity layer.

Important discoveries should become one of:

- normative docs;
- versioned specs;
- audit reports;
- issue comments;
- tests;
- manifests.

A future model should not need the original chat to understand why a route is blocked or approved.

For substantial changes, record:

- what changed;
- why;
- evidence;
- rejected alternative;
- current gate;
- next gate.

---

# 17. Safe Git behavior

Before destructive action, establish recoverability.

Do not casually execute:

`git reset --hard`
`git clean -fd`

Do not overwrite approved versions.

Do not push experimental runtime changes to stable main solely to make local work easier.

Use versioned branches/assets/specs.

Verify writes after mutation.

---

# 18. Modular engineering rule

AI-assisted speed must not create architectural debt.

Systems should be:

- modular;
- data-driven;
- reusable;
- testable;
- observable with debug tooling.

A new content variant should prefer configuration over duplicated algorithms.

If a new asset/location/attack requires copied logic, evaluate whether the shared abstraction is missing.

---

# 19. Required handoff block

A workstream handoff should contain:

```
PROJECT:
BRANCH:
KNOWN STABLE REF:
CURRENT GATE:
SOURCE OF TRUTH:
VALIDATED EVIDENCE:
CURRENT DECISION:
REJECTED ROUTES:
DO NOT:
NEXT AUTHORIZED GATE:
ACCEPTANCE CRITERIA:
```

This block should be reproducible from repository documentation/issues.

---

# 20. Canonical example — WALK_V3

The WALK_V3 correction is the reference implementation of this operating model.

Read:

- `docs/art/animation/durotar/WALK_V3_PIPELINE_CORRECTION_2026-09-18.md`
- `docs/art/animation/durotar/WALK_V3_RAW_4_FRAME_AUDIT.md`
- `docs/art/animation/durotar/WALK_V3_SPEC.md`

Key lesson:

**The existing four-frame walk is the source to measure, not something to recreate before proving recreation is necessary.**

---

# 21. Final decision rule

Before any change ask:

> Do I have evidence that this exact layer is the source of the problem?

If the answer is no:

**measure first.**

Before generating anything ask:

> Does the source already exist?

If yes:

**use the source.**

Before advancing ask:

> Did the current gate pass and is the next gate authorized?

If no:

**stop.**
