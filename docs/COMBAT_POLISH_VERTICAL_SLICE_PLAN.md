# RPG-DE-LUTA — Combat Polish / Vertical Slice Plan

Status: **EXECUTION STARTED**  
Escopo atual: **Durotar + arena de teste + boneco/alvo de treino**  
Objetivo: validar uma vertical slice de combate com padrão comercial antes de ampliar conteúdo.

---

## 1. Production model

The project follows:

`SOURCE → VALIDATE → MEASURE → DIAGNOSE → MINIMUM CHANGE → PREVIEW → RUNTIME QA`

See:

- `AGENTS.md`
- `docs/AI_PRODUCTION_OPERATING_MODEL.md`

Frame count is not itself a quality metric.

### Planning targets

| Animation | Planning target |
|---|---:|
| Idle | 6 |
| Walk | 4 canonical source frames first; additions only if QA proves necessary |
| Light 1 | 6 |
| Light 2 | 6 |
| Light 3 / Finisher | 8 |
| Heavy | 10 |
| Block Enter | 3 |
| Block Hold | 1–2 |
| Block Hit | 4 |
| Hurt Light | 4 |
| Hurt Heavy | 6 |
| Knockdown | 8 |
| Get Up | 8 |

Targets may change through a versioned spec and evidence.

Active contracts:

- `docs/ART_PRODUCTION_MEGA_SPEC.md`
- `docs/art/reference/durotar/DUROTAR_SWORD_V1_SPEC.md`
- `docs/art/animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`
- `docs/art/animation/durotar/WALK_V3_SPEC.md`
- `docs/art/animation/durotar/WALK_V3_PIPELINE_CORRECTION_2026-09-18.md`

WALK_V2 remains historical/rejected reference.

---

## 2. Mandatory principles

1. modular, non-monolithic architecture;
2. data-driven combat;
3. fail-closed validation;
4. preserve canonical sources;
5. measure before changing;
6. BODY / WEAPON / VFX responsibilities separated when useful;
7. `DUROTAR_SWORD_V1` locked;
8. nearest-neighbor / pixel fidelity;
9. Runtime QA is mandatory;
10. do not create art to hide unresolved runtime/data problems;
11. do not force frame counts without evidence;
12. LOCKED versions are never silently overwritten.

---

# 3. Operational roadmap

## Phase 0 — Pipeline / technical QA — P0

- Godot 4.7.2 import/load validation;
- mandatory asset dimensions;
- corrupt binary = fail;
- launcher/import flow reliable;
- local cache is not source of truth.

**Gate:** clean/reproducible source must display required runtime assets.

---

## Phase 1 — Durotar + sword contract — P0

Status: **CONTRACT CREATED**.

Weapon contract:

`docs/art/reference/durotar/DUROTAR_SWORD_V1_SPEC.md`

All future Durotar frames must preserve the Weapon Master.

---

## Phase 2 — WALK_V3 locomotion — P0

Status: **SOURCE-FIRST AUDIT / MEASUREMENT**.

Canonical raw source:

`assets/characters/durotar/walk.png`

Known layout:

- 512×128;
- four 128×128 frames;
- W00/W01/W02/W03.

WALK_V2 was technically loadable but failed Runtime QA.

The V3 route does **not** begin by regenerating Durotar.

Current gate sequence:

`SOURCE_LOCKED → RAW_4_FRAME_AUDIT → IN_PLACE_PREVIEW → WORLD_SPACE_MEASUREMENT → RUNTIME_TUNING → FOUR_FRAME_QA`

If four-frame QA passes:

`→ RUNTIME_QA → LOCKED`

If a specific visual transition remains deficient:

`→ TARGETED_INBETWEEN_REQUIRED → TARGETED_ART_REVIEW → PREVIEW_QA → RUNTIME_QA → LOCKED`

### Evidence already produced

`docs/art/animation/durotar/WALK_V3_RAW_4_FRAME_AUDIT.md`

RAW audit conclusion:

- original source validated;
- four cells extracted losslessly;
- identity preserved;
- W03→W00 is highest-risk in-place transition;
- clear leg exchange is not present in the raw four frames;
- **GO only to WORLD_SPACE_MEASUREMENT**;
- **NO GO for new art** until measurement/runtime tuning.

### DoD

- acceptable world-space foot slide;
- coherent visual stride versus logical movement;
- stable scale/baseline;
- Idle↔Walk without unacceptable pop;
- left/right;
- no weapon-identity violation;
- runtime capture reviewed at normal and 0.5×.

---

## Phase 3 — Idle polish — P0

Starts only after Walk locomotion reaches its required gate/lock for vertical-slice dependency.

Before creating new Idle art, audit any existing canonical Idle source using the same source-first protocol.

---

## Phase 4 — AttackProfile data-driven — P0

Reusable contract:

- id;
- startup_ms;
- active_ms;
- recovery_ms;
- damage;
- hitbox;
- lane_tolerance;
- forward_motion_px;
- knockback_px;
- hitstop_attacker_ms;
- hitstop_target_ms;
- cancel_from_ms;
- cancel_to[];
- vfx_id;
- sfx_id;
- camera_impulse_id.

States:

`READY → STARTUP → ACTIVE → RECOVERY → READY`

---

## Phase 5 — Light Combo — P0

`Light 1 → Light 2 → Light 3/Finisher`

Each attack receives its own versioned spec.

If usable canonical source art already exists, audit it before generating replacements.

---

## Phase 6 — Heavy — P0

Requirements:

- clear anticipation;
- readable acceleration;
- impact;
- follow-through;
- committed recovery;
- VFX separate;
- physical sword remains legible.

Existing Heavy source must be audited before replacement.

---

## Phase 7 — Hit feedback — P1

Order:

1. attacker pose;
2. target reaction;
3. hitstop;
4. knockback;
5. hit flash/material;
6. VFX;
7. SFX hook;
8. selective camera impulse.

VFX does not repair unreadable animation.

---

## Phase 8 — Defense — P1

States:

- Block Enter;
- Block Hold;
- Block Hit.

Block Hold must read as defense in a frozen screenshot.

---

## Phase 9 — Hitbox / hurtbox / lane forgiveness — P1

- independent hurtbox;
- per-attack hitbox;
- data-driven lane tolerance;
- debug F2;
- no active hitbox in recovery.

---

## Phase 10 — Arena / HUD / dummy — P2

- ground contrast below character;
- separate runtime contact shadow;
- debug HUD toggle;
- durable/resettable QA dummy;
- parallax after core approval.

---

## Phase 11 — QA / GO-NO-GO — P0

Minimum suite:

- sustained Idle/Walk;
- repeated Light/Heavy hit + whiff;
- defense stability;
- left/right states;
- reach/lane tests;
- asset CI green;
- runtime capture;
- frame-by-frame review where needed.

GO only when:

- P0 complete;
- no blocker/critical;
- Durotar identity approved;
- combat states readable;
- hit versus whiff readable;
- architecture remains modular/data-driven.

---

# 4. Next authorized Walk gate

For WALK_V3 the next gate after the completed RAW audit is:

**WORLD_SPACE_MEASUREMENT**

Do not generate new Walk art before that gate determines whether a specific transition requires it.
