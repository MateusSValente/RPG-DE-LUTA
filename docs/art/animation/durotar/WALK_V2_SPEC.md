# WALK_V2_SPEC — Durotar

**Status:** SPEC APPROVED FOR KEYPOSE PRODUCTION  
**Animation ID:** `DUROTAR_WALK_V2`  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Facing Master:** RIGHT  
**Authored drawings:** 8  
**Gameplay simulation:** 60 Hz

---

## 1. Intent

Create a grounded combat-walk cycle for Durotar that feels heavy but responsive.

The current prototype reads as sliding because foot contact, animation cadence and logical movement are not sufficiently synchronized. `WALK_V2` fixes this before any additional character content is produced.

The walk must communicate:

- Durotar is heavy/robust, not agile/light;
- he is ready to fight while moving;
- the greatsword has mass and follows the body with slight inertia;
- his feet visibly carry his body across the floor;
- there is no exaggerated vertical bounce.

---

## 2. Production target

Cycle structure:

`CONTACT_L → DOWN_L → PASSING_L → UP_L → CONTACT_R → DOWN_R → PASSING_R → UP_R`

Frame order:

| Frame | Pose | Initial hold @60 Hz | Function |
|---|---|---:|---|
| F01 | CONTACT_L | 4 ticks | left foot establishes forward contact |
| F02 | DOWN_L | 3 ticks | weight settles on left leg |
| F03 | PASSING_L | 4 ticks | right leg passes under body |
| F04 | UP_L | 3 ticks | body reaches highest point before next contact |
| F05 | CONTACT_R | 4 ticks | right foot establishes forward contact |
| F06 | DOWN_R | 3 ticks | weight settles on right leg |
| F07 | PASSING_R | 4 ticks | left leg passes under body |
| F08 | UP_R | 3 ticks | body reaches highest point before loop |

Initial cycle duration: **28 simulation ticks = 466.7 ms**.

Initial movement tuning target:

- logical movement speed: **120 px/s**;
- travel per complete cycle: approximately **56 px**;
- this is a playtest baseline, not a permanent balance value.

Movement tuning may change after runtime review, but art timing relationships must remain data-driven.

---

## 3. Global pose rules

Applies to all eight frames:

- canvas/runtime normalization follows `HUMANOID_STANDARD_V1`;
- neutral locomotion body height target: `96 px ±3`;
- baseline: `Y = 116`;
- logical pivot: `(64,116)`;
- facing RIGHT;
- head size, beard, hair, armor and body proportions cannot change;
- Durotar must remain robust and compact;
- no cape;
- no new straps, armor plates or accessories;
- no VFX;
- no motion blur;
- no anti-aliasing;
- `DUROTAR_SWORD_V1` identity is mandatory;
- body vertical bob budget: **maximum 3 px peak-to-peak**;
- pelvis horizontal jitter relative to movement direction is not allowed;
- shoulders may counter-rotate subtly, never enough to change silhouette identity.

---

## 4. Sword carry during Walk

Base carry:

- primary hand controls grip near hip;
- blade points diagonally down-forward (toward screen right);
- tip remains above or near ground line without scraping;
- weapon does not resize between frames;
- weapon angle may lag the torso by a very small amount to suggest mass;
- blade must never oscillate wildly like a light one-handed sword.

Allowed angle variation over the entire cycle: **subtle only**.

The weapon's visual center of mass should feel delayed by one pose relative to torso acceleration, but the hand/grip connection must remain anatomically coherent.

---

# 5. Frame-by-frame specification

## F01 — CONTACT_L — KEY POSE

**Role:** establish the left stride.

- left leg forward;
- left heel/foot makes first clear ground contact at baseline;
- right leg extended behind;
- knees slightly bent, not crouched deeply;
- torso slightly forward from the hips;
- chest remains open enough to read armor design;
- head stable and looking forward/right;
- left shoulder may lead minimally;
- sword held low diagonal down-right;
- sword tip must not touch the floor;
- no visible foot sliding in the authored pose.

Body vertical phase: **neutral**.

Planted/contact reference: **left foot**.

---

## F02 — DOWN_L — IN-BETWEEN

**Role:** absorb body weight after left contact.

- left foot becomes clearly planted;
- left knee compresses slightly;
- right heel rises as rear leg begins recovery;
- pelvis reaches the lowest point of the half-cycle;
- torso remains controlled; no squat-like collapse;
- sword follows downward body motion with minimal inertia.

Body vertical phase: **lowest**, maximum about `+1 to +2 px` relative to F01.

Planted foot: **left foot must remain visually fixed to ground**.

---

## F03 — PASSING_L — KEY POSE

**Role:** transfer right leg past the planted left leg.

- left foot remains support foot;
- right leg passes under/near center of mass;
- right knee bends enough to clear ground;
- pelvis begins rising;
- torso is closest to vertical in this half-cycle;
- arms/shoulders counterbalance subtly;
- sword angle trails slightly behind the torso transition but keeps identical proportions.

Body vertical phase: **rising**.

Planted foot: **left**.

---

## F04 — UP_L — IN-BETWEEN

**Role:** highest point before right contact.

- support transfers toward left forefoot;
- right leg travels forward preparing contact;
- left heel may lift;
- pelvis reaches highest point;
- torso remains stable;
- head should not bob independently;
- sword may rise by only a few pixels as a consequence of body motion, not through a new swing.

Body vertical phase: **highest**, maximum about `-1 to -2 px` relative to F01.

---

## F05 — CONTACT_R — KEY POSE

**Role:** mirrored gait event with right foot forward, but not a literal horizontal flip of F01.

- right leg forward;
- right foot establishes clear contact;
- left leg extended behind;
- torso returns to neutral vertical phase;
- silhouette must still read naturally with the sword carried on the same character side;
- weapon must not jump hands or change grip.

Body vertical phase: **neutral**.

Planted/contact reference: **right foot**.

---

## F06 — DOWN_R — IN-BETWEEN

**Role:** absorb weight after right contact.

- right foot clearly planted;
- right knee compresses slightly;
- left rear foot begins recovery;
- pelvis reaches the lowest point of the second half-cycle;
- torso remains controlled;
- sword inertia mirrors the gait rhythm without changing scale.

Body vertical phase: **lowest**, maximum about `+1 to +2 px` relative to F05.

Planted foot: **right foot must remain visually fixed to ground**.

---

## F07 — PASSING_R — KEY POSE

**Role:** transfer left leg past planted right leg.

- right foot remains support foot;
- left leg passes under center of mass;
- left knee bends to clear ground;
- pelvis begins rising;
- torso approaches vertical;
- weapon remains low and heavy.

Body vertical phase: **rising**.

Planted foot: **right**.

---

## F08 — UP_R — IN-BETWEEN

**Role:** highest point preparing loop back to F01.

- support transitions toward right forefoot;
- left leg advances toward next contact;
- right heel may lift;
- pelvis reaches highest point;
- pose must flow directly into F01 with no visible teleport;
- sword position must also loop cleanly.

Body vertical phase: **highest**, maximum about `-1 to -2 px` relative to F05.

---

# 6. Key-pose production gate

**Do not generate all eight frames in the first art pass.**

First pass contains only:

1. `F01 CONTACT_L`;
2. `F03 PASSING_L`;
3. `F05 CONTACT_R`;
4. `F07 PASSING_R`.

These four must pass:

- face/identity review;
- armor consistency;
- body proportion review;
- foot placement review;
- `DUROTAR_SWORD_V1` review;
- baseline compatibility;
- silhouette review.

Only after approval may F02/F04/F06/F08 be produced.

---

# 7. Runtime implementation contract

`player_visual.gd` must not own Walk timing as a single constant `FPS` after V2 integration.

Required model:

- animation data stores ordered frames;
- each frame stores `hold_ticks` or equivalent duration;
- frame-specific offsets are metadata;
- player movement speed is independent gameplay data;
- tuning may compare travel distance per cycle against visible stride;
- no `if frame_cursor == X` scattered through gameplay code.

Suggested data fields:

```text
animation_id
frames[]
  texture
  hold_ticks
  visual_offset
  planted_foot
  phase
loop
```

---

# 8. Acceptance criteria

## Visual

- all eight frames clearly depict the same Durotar;
- weapon is the same `DUROTAR_SWORD_V1` in all frames;
- body never appears to grow/shrink;
- vertical bob <= 3 px peak-to-peak;
- no accidental cape/accessory;
- no sword clipping caused by crop.

## Motion

- planted foot does not visibly slide during its support phase;
- F08 → F01 loop has no teleport/pop;
- Walk starts and stops without vertical snap;
- left-facing mirror maintains the same baseline;
- sword motion feels heavier than arms/legs but not delayed enough to look disconnected.

## Runtime

- validated at normal speed;
- validated at 0.5× debug speed;
- 30 seconds continuous walking left/right without jitter;
- movement speed and visual stride feel coherent;
- frame timing can be tuned without editing combat code.

---

# 9. BDD

### Scenario: No foot slide

**Given** Durotar is walking at the production test speed  
**When** a support foot is planted between CONTACT/DOWN/PASSING phases  
**Then** that foot must not visibly drift backward across the ground beyond the accepted pixel tolerance.

### Scenario: Stable identity

**Given** any frame F01–F08  
**When** compared to `DUROTAR_MASTER_V1` and `DUROTAR_SWORD_V1`  
**Then** character and weapon identity remain unchanged.

### Scenario: Stable baseline

**Given** a transition Idle → Walk → Idle  
**When** viewed at 0.5× speed  
**Then** no vertical teleport or baseline jump is visible.

### Scenario: Loop continuity

**Given** frame F08  
**When** the animation loops to F01  
**Then** leg trajectory, body height and sword position continue naturally without a pop.

---

# 10. Definition of Done

`DUROTAR_WALK_V2` becomes `LOCKED` only after:

- 4 key poses approved;
- 4 in-betweens approved;
- normalized runtime sprites exported;
- Godot asset validation green;
- 30-second left/right runtime capture reviewed;
- no foot-slide blocker;
- no sword identity blocker;
- no baseline blocker.
