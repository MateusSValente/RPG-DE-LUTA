# DUROTAR_SWORD_V1 — Weapon Master Contract

**Status:** LOCKED SPEC V1  
**Owner:** Durotar art pipeline  
**Source:** `DUROTAR_MASTER_V1_REFERENCE.webp`  
**Applies to:** Idle, Walk, Light, Heavy, Block, Hurt, Knockdown, Victory and all future Durotar animations.

---

## 1. Purpose

This document removes creative ambiguity around Durotar's sword. The weapon is part of the character identity and must not be redesigned between frames.

The weapon can change **position, angle and apparent length only through plausible foreshortening**. Its design cannot change.

If a generated frame does not comply, the frame is rejected. Godot must not be used to hide or compensate for an art error.

---

## 2. Canonical source

The canonical side-profile weapon is the panel labelled:

`ARMA - DUROTAR_SWORD_V1`

inside:

`docs/art/reference/durotar/DUROTAR_MASTER_V1_REFERENCE.webp`

Measured from the current 1536×1024 canonical reference, the side-profile sword occupies approximately:

- total reference bounding box: **268 × 60 px**;
- hilt/pommel to guard: approximately **20%** of total length;
- guard to tip: approximately **80%** of total length;
- broad blade body: approximately **31–34 px** high in the source panel;
- blade is straight and tapers only near the tip.

These measurements are validation ratios from the master panel, not runtime texture dimensions.

---

## 3. Locked visual identity

### Blade

- broad, straight, double-edged greatsword profile;
- silver/steel body;
- darker internal steel shading / central value break;
- no curve;
- no serration;
- no exaggerated fantasy spikes;
- no changing blade width between animations;
- symmetrical pointed tip;
- outline consistent with `PIXEL_STYLE_V1`.

### Guard

- gold/brass identity;
- same silhouette in every readable side/three-quarter pose;
- cannot disappear because of convenience;
- cannot become a different crossguard shape.

### Grip

- dark brown grip;
- same grip length and thickness;
- hand placement must respect the grip instead of resizing the sword to fit the pose.

### Pommel

- gold/brass pommel;
- same silhouette and relative size;
- must remain identifiable whenever visible.

---

## 4. Allowed variation

Allowed:

- translation;
- pose-specific angle;
- hand-relative positioning;
- plausible perspective compression;
- partial occlusion by hand/body;
- frame-specific pixel cleanup required by the angle.

Not allowed:

- sword becoming longer to fill an attack arc;
- sword becoming shorter to fit inside a cell;
- VFX replacing the physical blade;
- white slash arc being treated as the sword;
- guard redesign;
- pommel redesign;
- blade changing from broad to thin;
- blade changing from straight to curved;
- glow permanently baked into BODY or WEAPON art;
- arbitrary real-time rotation used as a substitute for a properly authored pixel-art angle when it degrades pixel fidelity.

---

## 5. Tolerance rules

For poses where the blade is approximately side-on and perspective compression is minimal:

- total apparent length target: master ratio ± **3%**;
- blade thickness target: master ratio ± **5%**;
- hilt-to-blade ratio target: master ratio ± **5%**.

For perspective/foreshortened poses:

- apparent length may reduce when perspective justifies it;
- apparent length may **not exceed 103%** of the canonical side profile;
- guard, grip and pommel must remain proportionally coherent;
- foreshortening must be intentional and documented in the animation frame spec.

If there is doubt, FAIL-CLOSED: reject and regenerate the frame.

---

## 6. Layer contract

Production source should keep the following independently recoverable:

- `BODY` — Durotar without slash effects;
- `WEAPON` — `DUROTAR_SWORD_V1`;
- `VFX` — slash/impact/energy effects.

For the current vertical slice, BODY+WEAPON may be exported as a validated baked runtime composite if pixel-identical to the approved layered source. VFX remains separate.

Weapon pivot/reference point:

- canonical local reference = **center of the grip where the primary hand controls the weapon**;
- frame metadata may define hand/pivot offset;
- do not solve misalignment by scaling the weapon.

---

## 7. Validation checklist

A frame is rejected if any answer below is `NO`:

- Does the sword still read as `DUROTAR_SWORD_V1`?
- Is the blade broad and straight?
- Is the guard the same design?
- Is the grip/pommel consistent?
- Is any length change explainable by perspective?
- Is the sword physical blade still readable when VFX is removed?
- Has the weapon avoided clipping caused by a bad crop?
- Is the weapon scale consistent with Durotar's body?

---

## 8. BDD acceptance

### Scenario: Side-profile weapon consistency

**Given** a Durotar frame with minimal foreshortening  
**When** its weapon is compared with `DUROTAR_SWORD_V1`  
**Then** total length, blade thickness and hilt proportions remain inside the declared tolerance.

### Scenario: VFX independence

**Given** an attack frame with slash VFX  
**When** VFX is disabled  
**Then** the physical sword remains fully understandable and visually coherent.

### Scenario: Invalid generated weapon

**Given** a generated frame with a curved, resized or redesigned sword  
**When** asset validation occurs  
**Then** the frame is rejected and must not enter runtime.

---

## 9. Versioning

Any intentional weapon redesign requires a new explicit master, for example:

`DUROTAR_SWORD_V2`

`DUROTAR_SWORD_V1` must never be silently overwritten.
