# WALK_V3_SPEC — Durotar

**Status:** SOURCE_FRAME_AUDIT  
**Animation ID:** `DUROTAR_WALK_V3`  
**Supersedes:** `DUROTAR_WALK_V2` (RUNTIME_QA_FAILED / prototype reference)  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Canonical Walk Source:** `assets/characters/durotar/walk.png`  
**Source layout:** 512×128 / four 128×128 cells  
**Gameplay simulation:** 60 Hz

---

## 1. Corrected production decision

WALK_V3 starts from the existing raw four-frame walk.

Do not regenerate Durotar to solve locomotion.

Production order:

`RAW WALK SOURCE → LOSSLESS 4-FRAME EXTRACTION → SOURCE AUDIT → IN-PLACE PREVIEW → WORLD-SPACE MEASUREMENT → RUNTIME/DATA TUNING → QA`

Only if a measured transition still fails after runtime/data tuning may a targeted in-between be created.

The previous eight-pose joint guide is retained as diagnostic history only. It is not pose authority.

---

## 2. Authority hierarchy

1. `DUROTAR_MASTER_V1` — identity;
2. raw `walk.png` — locomotion pose/source;
3. `DUROTAR_SWORD_V1` — weapon identity/proportions;
4. measured runtime behavior — cycle-distance/offset tuning;
5. pose guides — diagnostic only;
6. generated images — candidate only.

---

## 3. Frame-count decision

Initial authored drawings: **4 canonical source frames**.

Do not force eight drawings.

The walk may ship with four drawings if it passes:

- readability;
- loop;
- start/stop;
- left/right mirror;
- baseline;
- sword consistency;
- world-space foot-slide QA.

Additional drawings require evidence from QA.

---

## 4. Source-frame audit

Raw cell ids:

- W00
- W01
- W02
- W03

Do not assign CONTACT / DOWN / PASSING / UP labels yet.

For each source frame measure first:

- silhouette bounds;
- apparent body height;
- baseline;
- candidate support foot and local X;
- candidate swing foot;
- sword grip;
- sword tip;
- root/pivot compatibility;
- gait function.

Phase labels are results of the audit, not assumptions imported from V2.

---

## 5. Geometry contract

Runtime cell:

- 128×128;
- baseline Y=116 where the source actually conforms;
- logical pivot target (64,116);
- facing RIGHT;
- nearest-neighbor;
- transparent background;
- no runtime scaling to hide art errors.

### Normalization

The raw source is already a 4-cell runtime sheet.

Forbidden:

- independent bbox fit;
- independent scaling;
- AI redraw during extraction.

If metadata offsets are required, keep them data-driven and documented.

---

## 6. Playback model

Preferred locomotion progression is based on travelled distance, not fixed FPS alone.

Conceptually:

```
phase_distance = total_walk_distance % cycle_distance_px
```

However, the cycle distance is **not locked to 56 px anymore**.

It must be derived/tuned from the actual four source frames and Runtime QA.

Do not inherit V2's 56 px merely because it existed.

---

## 7. Foot-slide procedure

For each audited source frame:

1. identify the visible candidate support contact;
2. record its local X;
3. test a candidate cycle distance;
4. compute support contact in world-space;
5. measure drift across relevant neighboring frames;
6. tune cycle distance and data offsets;
7. validate at 1× and 0.5×.

If a support phase cannot be made convincing with the canonical frames, document the exact transition before requesting new art.

---

## 8. Sword policy

Do not alter the sword during the four-frame audit.

Evaluate the existing carry first.

`DUROTAR_SWORD_V1` remains the authority for any future art modification.

A new frame may not resize, curve, redesign, shorten or lengthen the weapon to fit.

---

## 9. New-art gate

New art is blocked until FOUR_FRAME_QA fails for a specific documented visual reason.

If new art is required:

- create only the missing transition;
- use the two neighboring canonical source frames;
- preserve identity/armor/weapon;
- prefer local/region edits;
- do not regenerate the full strip.

---

## 10. QA outputs

Before Godot changes, produce:

- exact extracted W00–W03;
- in-place 1× preview;
- in-place 0.5× preview;
- world-space 1× preview;
- world-space 0.5× preview;
- debug overlay for baseline/root/contact candidates;
- measurement report.

---

## 11. Runtime QA

Minimum:

- RIGHT and mirrored LEFT;
- normal speed and 0.5×;
- 30 s continuous movement;
- repeated start/stop;
- Idle→Walk and Walk→Idle;
- camera static and moving;
- no scale jitter;
- no baseline pop;
- no unacceptable foot slide;
- sword remains legible and consistent.

---

## 12. State machine

`SOURCE_LOCKED → RAW_4_FRAME_AUDIT → IN_PLACE_PREVIEW → WORLD_SPACE_MEASUREMENT → RUNTIME_TUNING → FOUR_FRAME_QA`

Pass:
`→ RUNTIME_QA → LOCKED`

Specific visual-transition failure:
`→ TARGETED_INBETWEEN_REQUIRED → TARGETED_ART_REVIEW → PREVIEW_QA → RUNTIME_QA → LOCKED`

---

See `WALK_V3_PIPELINE_CORRECTION_2026-09-18.md` for the rationale and retired route.
