# DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1

**Status:** ACTIVE PRODUCTION STANDARD  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Runtime:** Godot 4.7.2 / 60 Hz gameplay simulation  
**Art Style:** `PIXEL_STYLE_V1`

---

## 1. Production decision

Durotar will use **more authored poses than the prototype**, but frame count is not the quality target by itself.

The quality target is:

1. strong readable key poses;
2. responsive gameplay timing;
3. stable character identity;
4. stable weapon identity;
5. frame-specific timing;
6. clean transitions;
7. predictable contact and impact.

The project must not use a single fixed animation FPS as the only timing system for combat. Each authored drawing may have its own hold duration.

Gameplay remains at **60 Hz**. Animation drawings are held for a configurable number of simulation ticks.

---

## 2. Production frame targets

These are the approved production targets for the first Durotar vertical slice.

| Animation | Authored drawings target | Notes |
|---|---:|---|
| Idle | 6 | subtle breathing / readiness, no foot slide |
| Walk | 8 | full contact/down/passing/up cycle |
| Light 1 | 6 | fast opener |
| Light 2 | 6 | complementary second strike |
| Light 3 / Finisher | 8 | stronger silhouette and commitment |
| Heavy | 10 | anticipation, acceleration, impact, follow-through, recovery |
| Block Enter | 3 | transition into guard |
| Block Hold | 1–2 | stable readable defensive pose |
| Block Hit | 4 | impact while maintaining defense |
| Hurt Light | 4 | small recoil |
| Hurt Heavy | 6 | larger recoil |
| Knockdown | 8 | fall/ground state |
| Get Up | 8 | recover to neutral |

These targets can only change through a versioned animation spec, not ad-hoc during implementation.

---

## 3. Timing model

### Rule

`Authored drawings != simulation frames`.

At 60 Hz:

- 1 tick = 16.67 ms;
- an authored drawing may hold for 1, 2, 3, 4 or more ticks;
- holds are part of game feel and must be specified per frame.

### Why

Limited 2D animation works when key poses, anticipation and timing are strong. More drawings are useful only when they improve readability, weight or continuity.

---

## 4. Mandatory animation spec before generation

No new Durotar animation may be generated without a versioned `ANIMATION_SPEC` containing:

- animation id/version;
- intent;
- frame count;
- facing direction;
- per-frame pose description;
- per-frame hold duration;
- baseline/pivot rules;
- planted foot definition;
- body vertical offset budget;
- hand/weapon relationship;
- foreshortening declaration where applicable;
- startup/active/recovery mapping for attacks;
- BODY / WEAPON / VFX requirements;
- prohibited changes;
- acceptance tests.

**Missing specification = generation blocked.**

---

## 5. Generation gate — key poses first

For cyclic animations such as Walk:

1. specify all frames;
2. generate only the key poses first;
3. approve identity, silhouette, feet, weapon and baseline;
4. only then generate the in-between poses;
5. normalize assets;
6. test in runtime;
7. lock the approved version.

For `WALK_V2`, the first art pass is only:

- F01 — CONTACT_L;
- F03 — PASSING_L;
- F05 — CONTACT_R;
- F07 — PASSING_R.

F02/F04/F06/F08 are blocked until the first four pass review.

---

## 6. Runtime and export contract

Character runtime assets:

- PNG RGBA;
- nearest-neighbor;
- no anti-aliasing;
- no baked ground shadow;
- baseline `Y = 116` for `HUMANOID_STANDARD_V1` where the animation contract uses the standard cell;
- logical pivot `64,116` unless animation spec explicitly documents a larger layer canvas;
- body height target remains `96 px ±3` for neutral/locomotion poses;
- no runtime scaling to correct bad art.

If an attack requires extra space for a weapon/VFX layer, BODY identity remains normalized and the additional layer may use an animation-specific canvas declared by its spec.

---

## 7. BODY / WEAPON / VFX policy

### BODY

Contains Durotar only. No slash trails or impact flashes.

### WEAPON

Must follow `DUROTAR_SWORD_V1_SPEC.md`.

### VFX

Independent visual reinforcement. It may never be required for the physical weapon to make sense.

For the vertical slice, a validated BODY+WEAPON baked runtime image is acceptable when it is pixel-identical to the approved layered source. VFX remains separate.

---

## 8. Animation approval states

Each animation version moves through:

`SPEC_DRAFT → KEYPOSE_REVIEW → KEYPOSE_APPROVED → INBETWEEN_PRODUCTION → NORMALIZED → RUNTIME_QA → LOCKED`

Failure at any gate returns to the previous production step.

Do not silently edit a `LOCKED` animation. Create a new version (`WALK_V3`, etc.).

---

## 9. Runtime QA requirements

Every animation must be reviewed inside the 640×360 game viewport.

Minimum checks:

- normal speed;
- 0.5× playback/debug speed;
- right-facing;
- mirrored left-facing;
- transition from previous/next state;
- baseline stability;
- weapon identity;
- silhouette readability;
- no crop/clipping;
- no frame with accidental scale change.

Walk additionally requires foot-slide review.

Attacks additionally require hit/whiff review and startup/active/recovery synchronization.

---

## 10. Market-informed production principle

The project follows a limited-animation/action-game approach:

- prioritize handpicked poses over indiscriminate smoothness;
- anticipation and timing matter more than raw frame count;
- hit pause, VFX and camera reinforce an already-readable attack rather than compensating for weak poses;
- generous but predictable brawler hit logic is handled in gameplay data, not by distorting sprite art.

This standard is deliberately designed to scale to the second playable character after Durotar's vertical slice is approved.
