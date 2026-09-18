# WALK_V3_PIPELINE_CORRECTION — 2026-09-18

## Decision

The WALK_V3 route is corrected.

The previous V3 experiment made the pose guide too authoritative and kept trying to regenerate Durotar. That caused identity, armor, sword and pose drift.

From now on:

**existing approved art is authoritative; generated motion guides are diagnostic only.**

Canonical locomotion source:

`assets/characters/durotar/walk.png`

Known contract on stable main:

- 512×128 PNG;
- four 128×128 cells;
- existing Durotar identity and walk posing;
- no regeneration is allowed before the raw four-frame cycle has been audited.

The presentation sheet remains an identity/reference board, but runtime work must start from the raw `walk.png`, not from a recreated image.

---

## New production principle

Do not solve a motion problem by redrawing approved art first.

Order of operations:

`RAW SOURCE → LOSSLESS FRAME EXTRACTION → MEASURE → PREVIEW → RUNTIME TUNING → QA → ONLY THEN ART ADDITIONS IF PROVEN NECESSARY`

Image generation is no longer the default next step.

---

## Four-frame-first rule

WALK_V3 no longer assumes eight authored drawings.

Initial production target:

- W00
- W01
- W02
- W03

These four are the canonical source frames from the existing `walk.png`.

The cycle may remain four drawings if timing, offsets and distance-driven playback pass Runtime QA.

Additional in-betweens are allowed only when QA identifies a specific missing transition that cannot be solved with timing/metadata.

Frame count is not a quality goal.

---

## Source-frame audit

Before assigning CONTACT / DOWN / PASSING / UP labels, inspect the real source frames.

Do not infer phase names from the old V2 or pose-guide model.

For each raw frame record:

- exact cell index;
- body silhouette bounds;
- shared baseline compatibility;
- root/pivot compatibility;
- visible forward/rear foot;
- candidate support foot;
- candidate swing foot;
- sword grip position;
- sword tip position;
- apparent body height;
- gait readability;
- whether the frame is contact, passing, compression, rise, or ambiguous.

Phase labels are assigned only after this audit.

---

## Lossless extraction

The four source frames must be extracted directly from the raw 512×128 asset.

Forbidden:

- screenshots;
- extracting from a presentation board when raw asset exists;
- AI recreation;
- per-frame rescaling;
- per-frame bbox fit;
- repainting identity details.

Allowed:

- exact 128×128 cell slicing;
- metadata;
- non-destructive debug overlays in separate outputs.

---

## Two preview modes

### 1. In-place preview

All frames use the same pivot/root.

Purpose:

- inspect pose continuity;
- inspect body jitter;
- inspect sword jitter;
- inspect loop quality;
- classify gait phases.

### 2. World-space preview

Gameplay displacement is applied.

Purpose:

- measure visible foot slide;
- compare visual stride to logical speed;
- tune cycle distance;
- tune per-frame offsets.

Do not judge foot slide from an in-place preview alone.

---

## Runtime tuning before new art

Tune these data first:

- cycle distance;
- distance thresholds per frame;
- per-frame visual/root offsets if justified;
- start/stop transition;
- Idle→Walk entry frame;
- Walk→Idle exit frame;
- optional frame holds only if they do not break distance coherence.

Preferred locomotion driver:

`phase = travelled_distance % cycle_distance`

Gameplay movement remains authoritative.

---

## Foot-slide measurement

Do not require a theoretical planted-foot model before inspecting the real four frames.

Instead:

1. identify the actual support/contact foot in each source frame;
2. measure its local X;
3. apply candidate world displacement;
4. calculate world-space drift;
5. tune cycle distance and offsets;
6. review at 1× and 0.5×.

If the raw art cannot produce acceptable support behavior after tuning, record the exact bad transition.

Only that transition becomes an art task.

---

## Optional in-between rule

A new frame may be created only when all are true:

1. the four-frame source cycle has been measured;
2. runtime/data tuning was attempted;
3. a specific transition is still visibly deficient;
4. the missing pose is described relative to its two neighboring canonical frames.

New art must preserve both neighboring frames.

Do not regenerate the full character from a text prompt.

Preferred order for a missing frame:

1. deterministic/local pixel edit where possible;
2. constrained region edit using source frames;
3. AI-assisted new in-between as last resort;
4. reject any identity/armor/sword drift.

---

## Authority hierarchy

For WALK_V3:

1. `DUROTAR_MASTER_V1` — identity authority;
2. raw `assets/characters/durotar/walk.png` — walk pose/source authority;
3. `DUROTAR_SWORD_V1` — weapon geometry authority;
4. runtime measurements — locomotion tuning authority;
5. pose guides — diagnostic/reference only;
6. generative output — candidate only, never authority.

---

## Gate sequence

`SOURCE_LOCKED`
→ `RAW_4_FRAME_AUDIT`
→ `IN_PLACE_PREVIEW`
→ `WORLD_SPACE_MEASUREMENT`
→ `RUNTIME_TUNING`
→ `FOUR_FRAME_QA`

If four-frame QA passes:

→ `RUNTIME_QA`
→ `LOCKED`

If four-frame QA fails for a specific visual transition:

→ `TARGETED_INBETWEEN_REQUIRED`
→ `TARGETED_ART_REVIEW`
→ `PREVIEW_QA`
→ `RUNTIME_QA`
→ `LOCKED`

---

## Explicitly retired route

Do not continue:

`POSE GUIDE → regenerate F01 → regenerate F03/F05/F07 → regenerate full strip`

This route is retired because repeated generation changed:

- face;
- proportions;
- armor;
- sword;
- carry;
- pose quality.

---

## Immediate next step

Audit the raw `assets/characters/durotar/walk.png` four frames exactly as stored on the stable branch.

No new sprite generation should occur until that audit and preview are complete.
