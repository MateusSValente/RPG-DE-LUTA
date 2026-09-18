# WALK_V3_SPEC — Durotar

**Status:** SPEC_DRAFT / MOTION DESIGN  
**Animation ID:** `DUROTAR_WALK_V3`  
**Supersedes:** `DUROTAR_WALK_V2` (RUNTIME_QA_FAILED / prototype reference)  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Facing Master:** RIGHT  
**Authored drawings target:** 8  
**Gameplay simulation:** 60 Hz

---

## 1. Production decision

WALK_V3 must not ask image generation to invent locomotion.

The production order is:

`MASTER → MOTION DATA → POSE GUIDE → KEYPOSE QA → FULL 8-FRAME GENERATION → SINGLE-SCALE NORMALIZATION → PREVIEW QA → GODOT → RUNTIME QA`

Biomechanics are authoritative. Generated art must conform to the approved motion plan.

No final Durotar sprite may be generated before the pose guide passes review.

---

## 2. Problems from WALK_V2 that V3 must solve

V3 exists because V2 failed Runtime QA due to:

- visible foot sliding;
- excessive crouch/shuffle read;
- ambiguous near/far-leg anatomy;
- malformed F07/F08 leg/foot read;
- sword masking the gait;
- sword tip reading as ground contact;
- rigid torso/weapon relationship;
- Idle→Walk posture pop;
- per-frame independent normalization causing scale/root drift.

Any recurrence of one of these blockers is NO-GO.

---

## 3. Leg naming convention

Do not use ambiguous LEFT/RIGHT naming in art direction.

For a RIGHT-facing sprite:

- **NEAR LEG** = leg visually closest to camera;
- **FAR LEG** = leg visually behind the body.

Every frame must explicitly declare:

- support_leg;
- swing_leg;
- planted_contact;
- phase.

---

## 4. Cycle

| Frame | Phase | Support | Swing | Distance phase |
|---|---|---|---|---:|
| F01 | CONTACT_NEAR | NEAR | FAR | 0 px |
| F02 | DOWN_NEAR | NEAR | FAR | 7 px |
| F03 | PASSING_FAR | NEAR | FAR | 14 px |
| F04 | UP_NEAR | NEAR | FAR | 21 px |
| F05 | CONTACT_FAR | FAR | NEAR | 28 px |
| F06 | DOWN_FAR | FAR | NEAR | 35 px |
| F07 | PASSING_NEAR | FAR | NEAR | 42 px |
| F08 | UP_FAR | FAR | NEAR | 49 px |

Provisional cycle distance: **56 px**.

Initial QA speed: **120 px/s**.

These values preserve the useful V2 playtest baseline but are not balance constants.

---

## 5. Phase driver

WALK_V3 locomotion phase is driven primarily by **distance travelled**, not by a fixed animation FPS.

Conceptually:

```
phase_distance = total_walk_distance % cycle_distance_px
```

At the initial 56 px cycle:

- F01 sample: 0 px;
- F02: 7 px;
- F03: 14 px;
- F04: 21 px;
- F05: 28 px;
- F06: 35 px;
- F07: 42 px;
- F08: 49 px;
- next F01: 56 px.

Gameplay movement remains authoritative. The visual cycle follows movement distance.

A fixed FPS may not be the sole timing mechanism.

---

## 6. Global geometry contract

Runtime normalization remains compatible with `HUMANOID_STANDARD_V1`:

- cell: 128×128;
- baseline: Y=116;
- logical pivot: (64,116);
- facing: RIGHT;
- neutral body height target: 96 px ±3;
- nearest-neighbor;
- transparent background;
- no anti-aliasing;
- no baked ground shadow;
- no VFX.

### Single-scale rule

All eight drawings use **one scale derived from the approved Master**.

Forbidden:

`detect bbox → fit F01`
`detect bbox → fit F02`
`detect bbox → fit F03`
etc.

There is one normalization transform for the whole sequence.

Frame differences are expressed as pose/offset data, never independent rescaling.

---

## 7. Root and pelvis

A common logical root is used for all frames.

The pose guide must define:

- root/pelvis anchor;
- head;
- shoulders;
- near/far hips;
- near/far knees;
- near/far ankles;
- near/far heel;
- near/far toe;
- sword grip;
- sword tip.

Pelvis motion must form a controlled arc.

Target vertical bob for V3: **maximum 2 px peak-to-peak** during the cycle unless Runtime QA proves a slightly larger value is required.

The body must never read as entering a crouch when Walk starts.

---

## 8. Foot planting

Support phases:

- F01–F04: NEAR foot carries the body;
- F05–F08: FAR foot carries the body.

At authored pose sample points, the support contact must remain effectively stationary in world-space while the root advances.

Target measurement:

- preferred support-foot drift between authored support samples: **≤1 px**;
- runtime visible drift beyond **2 px** during a support phase is a blocker.

If baked-sprite playback cannot meet the runtime tolerance, solve it in locomotion presentation/metadata or the pose pipeline. Do not distort the Master and do not hide the problem with VFX.

---

## 9. Pose requirements

### F01 — CONTACT_NEAR — key pose

- NEAR heel makes clear forward contact;
- FAR leg trails;
- knees athletic, not crouched;
- pelvis neutral;
- torso stable;
- gait silhouette open;
- sword tip clearly above baseline.

### F02 — DOWN_NEAR

- NEAR foot planted;
- weight compresses subtly;
- FAR heel recovers;
- lowest pelvis point, but no squat read.

### F03 — PASSING_FAR — key pose

- NEAR foot supports;
- FAR knee passes beneath/forward of pelvis;
- FAR foot clears ground;
- both legs remain anatomically separable;
- sword cannot hide the passing ankle/knee relationship.

### F04 — UP_NEAR

- NEAR support transitions toward forefoot;
- FAR leg prepares next contact;
- highest pelvis point;
- must flow naturally into F05.

### F05 — CONTACT_FAR — key pose

- FAR heel establishes forward contact;
- NEAR leg trails;
- not a literal horizontal flip of F01;
- weapon stays in the same hands and character side.

### F06 — DOWN_FAR

- FAR foot planted;
- subtle compression;
- NEAR rear foot begins recovery.

### F07 — PASSING_NEAR — key pose

- FAR foot supports;
- NEAR knee passes beneath/forward of pelvis;
- anatomy must be unequivocal;
- no disconnected foot;
- no extra-limb read.

### F08 — UP_FAR

- FAR support transitions toward forefoot;
- NEAR leg advances into the next F01;
- F08→F01 must close without pop.

---

## 10. Leg readability gate

For F03 and F07 in particular:

- near/far leg must be identifiable without relying on color alone;
- no merged ankle shapes;
- no foot may look detached;
- no silhouette may imply a third leg;
- the sword may not cover both lower legs simultaneously;
- the passing leg must retain a continuous hip→knee→ankle→foot read.

Failure = NO-GO before image-generation polish.

---

## 11. Sword contract

`DUROTAR_SWORD_V1` remains mandatory.

During Walk:

- same apparent weapon identity and proportions;
- no runtime/art scaling to make it fit;
- tip must remain visibly clear of the baseline;
- minimum target visual clearance at lowest point: **2 px**;
- blade must not continuously mask the gait;
- hand/grip connection cannot teleport;
- torso leads and weapon may lag subtly to communicate mass;
- inertia must be subtle enough that the sword never appears disconnected.

VFX is forbidden in Walk.

---

## 12. Pose-guide gate

The first visual production artifact for V3 is **not a finished sprite sheet**.

It is `WALK_V3_POSE_GUIDE`.

The guide must show all eight poses with joint/contact markers.

First review focuses on four key events:

- F01 CONTACT_NEAR;
- F03 PASSING_FAR;
- F05 CONTACT_FAR;
- F07 PASSING_NEAR.

Review criteria:

- gait biomechanics;
- support-foot logic;
- pelvis arc;
- leg readability;
- silhouette;
- sword line/clearance;
- F07 anatomy;
- F08→F01 closure.

Only after the guide passes may final Durotar art be generated.

---

## 13. Image-generation rule

After pose-guide approval, generate the **full eight-frame sequence as one controlled strip/edit whenever possible** using:

- `DUROTAR_MASTER_V1`;
- `DUROTAR_SWORD_V1`;
- approved `WALK_V3_POSE_GUIDE`;
- the same palette/style contract.

Do not independently ask for eight unrelated finished frames.

If one region fails, repair that region/frame using adjacent approved frames and the Master as context instead of regenerating the complete cycle blindly.

---

## 14. Preview gate before Godot

Before runtime integration, automatically produce:

- 1× loop;
- 0.5× loop;
- contact-debug loop;
- baseline/root overlay;
- support-foot marker;
- sword-tip marker.

QA must inspect:

- anatomy;
- foot drift;
- pelvis arc;
- scale consistency;
- sword clearance;
- F08→F01;
- Idle reference → Walk entry;
- Walk exit → Idle reference.

If the preview already fails, do not import it into Godot.

---

## 15. Runtime QA

Minimum runtime review:

- 30 seconds moving RIGHT;
- 30 seconds moving LEFT;
- 1×;
- 0.5×;
- start/stop repeatedly;
- Idle→Walk;
- Walk→Idle;
- camera moving and camera static;
- baseline/contact visible in debug.

WALK_V3 becomes `LOCKED` only if:

- no anatomy blocker;
- no scale/root jitter;
- no obvious support-foot slide;
- no sword-ground read;
- no gait occlusion blocker;
- no F08→F01 pop;
- no Idle↔Walk crouch/pop.

---

## 16. State machine

`SPEC_DRAFT → MOTION_APPROVED → POSE_GUIDE_REVIEW → POSE_GUIDE_APPROVED → FULL_STRIP_GENERATION → NORMALIZED → PREVIEW_QA → RUNTIME_QA → LOCKED`

Any failed gate returns to the previous production stage.

Never silently replace WALK_V3 after LOCKED; create a new version.
