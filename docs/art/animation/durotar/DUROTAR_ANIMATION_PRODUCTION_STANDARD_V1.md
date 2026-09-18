# DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1

**Revision:** 1.1.0 — source-first amendment  
**Status:** ACTIVE PRODUCTION STANDARD  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Runtime:** Godot 4.7.2 / 60 Hz gameplay simulation  
**Art Style:** `PIXEL_STYLE_V1`

---

## 1. Production decision

Quality is not defined by authored-frame count.

Priority:

1. stable character identity;
2. stable weapon identity;
3. readable key poses;
4. responsive gameplay timing;
5. clean transitions;
6. predictable contact/impact;
7. minimum number of drawings necessary to satisfy the above.

`Authored drawings != simulation frames`.

Gameplay remains at 60 Hz. Presentation timing is data-driven.

---

## 2. Source-first rule

Before planning or generating a new animation, determine whether approved source art already exists.

### Existing animation/source

Use:

`RAW SOURCE → LOSSLESS EXTRACTION → AUDIT → PREVIEW → RUNTIME MEASUREMENT → DATA/TIMING TUNING → QA`

Do not regenerate Durotar first.

Do not force a new frame count because an older production plan targeted more drawings.

### Truly new animation

Use:

`MASTER → VERSIONED ANIMATION_SPEC → KEYPOSE PLAN → KEYPOSE REVIEW → NECESSARY IN-BETWEENS → NORMALIZATION → PREVIEW QA → RUNTIME QA`

---

## 3. Frame targets

Targets are planning baselines, not mandatory quality scores.

| Animation | Current planning target | Rule |
|---|---:|---|
| Idle | 6 | may change through versioned spec/evidence |
| Walk | 4 canonical source frames initially | add only evidence-required frames |
| Light 1 | 6 | versioned spec required |
| Light 2 | 6 | versioned spec required |
| Light 3 / Finisher | 8 | versioned spec required |
| Heavy | 10 | versioned spec required |
| Block Enter | 3 | versioned spec required |
| Block Hold | 1–2 | versioned spec required |
| Block Hit | 4 | versioned spec required |
| Hurt Light | 4 | versioned spec required |
| Hurt Heavy | 6 | versioned spec required |
| Knockdown | 8 | versioned spec required |
| Get Up | 8 | versioned spec required |

For Walk specifically, the four raw source frames are audited before any new drawing is authorized.

---

## 4. Timing model

A single fixed FPS cannot be the only timing model.

Depending on the animation, data may include:

- per-frame hold;
- phase threshold;
- travelled-distance threshold;
- visual offset;
- root/forward motion;
- startup/active/recovery mapping.

Historic tuning values are hypotheses unless the current spec explicitly locks them.

---

## 5. Mandatory spec

No **new art production** starts without a versioned `ANIMATION_SPEC`.

For an existing source under audit, the spec must first describe:

- canonical source path/ref;
- extraction method;
- current gate;
- measurements required;
- mutation policy;
- next authorized gate.

For new art it must additionally define:

- intent;
- facing;
- pose requirements;
- baseline/pivot;
- weapon relationship;
- allowed/forbidden changes;
- acceptance tests.

Missing required information = blocked.

---

## 6. Existing-source gate

For an approved existing animation:

1. retrieve canonical source;
2. validate dimensions/type/import;
3. extract losslessly;
4. prove extraction equality when feasible;
5. inspect real frames before assigning phase labels;
6. create in-place preview;
7. measure world-space/runtime behavior;
8. tune data/runtime;
9. identify exact failing transition;
10. only then decide whether new art is required.

A pose guide is diagnostic unless the current spec explicitly makes it authoritative for a truly new animation.

---

## 7. New-art gate

A new frame for an existing animation is allowed only if:

1. source audit completed;
2. runtime/data tuning attempted;
3. a specific transition remains deficient;
4. neighboring canonical frames are identified;
5. the missing function of the new frame is documented.

Prefer targeted/local change over full-strip regeneration.

Generated output is a candidate, never automatic authority.

---

## 8. Runtime/export contract

Character runtime assets:

- nearest-neighbor;
- no incompatible anti-aliasing;
- no baked ground shadow;
- standard cell/baseline/pivot according to current spec;
- no runtime scaling to hide bad art;
- no independent bbox-fit normalization for frames in one animation unless explicitly justified by a versioned contract.

For source-derived assets, preserve original source scale until measurement proves a normalization change is required.

---

## 9. BODY / WEAPON / VFX

### BODY
Identity and body animation.

### WEAPON
Must follow `DUROTAR_SWORD_V1_SPEC.md`.

### VFX
Separate reinforcement. Never required to make the physical weapon understandable.

VFX cannot repair weak pose, bad anatomy or wrong timing.

---

## 10. Approval states

### Existing-source animation

`SOURCE_LOCKED → RAW_AUDIT → IN_PLACE_PREVIEW → WORLD_SPACE_MEASUREMENT → RUNTIME_TUNING → QA → LOCKED`

If a specific art gap is proven:

`... → TARGETED_ART_REQUIRED → ART_REVIEW → PREVIEW_QA → RUNTIME_QA → LOCKED`

### New animation

`SPEC_DRAFT → KEYPOSE_REVIEW → KEYPOSE_APPROVED → NECESSARY_INBETWEENS → NORMALIZED → PREVIEW_QA → RUNTIME_QA → LOCKED`

Failure returns to the previous appropriate gate.

Never silently edit a LOCKED animation. Create a new version.

---

## 11. Runtime QA

Every animation must be reviewed at the game viewport/profile required by the active spec.

Minimum:

- normal speed;
- 0.5×;
- RIGHT;
- mirrored LEFT where applicable;
- transitions;
- baseline;
- weapon identity;
- silhouette;
- crop/clipping;
- scale consistency.

Walk additionally requires:

- in-place loop review;
- world-space foot-slide review;
- start/stop;
- stride versus logical movement.

Attacks additionally require hit/whiff plus startup/active/recovery synchronization.

---

## 12. Anti-loop rule

After two failures caused by the same method, stop.

Do not produce a third near-identical generation attempt.

Re-evaluate:

- source;
- authority;
- gate;
- layer responsible for the defect;
- measurements missing.

The WALK_V3 identity-drift loop is the project reference example.

See:

- `AGENTS.md`
- `docs/AI_PRODUCTION_OPERATING_MODEL.md`
- `docs/art/animation/durotar/WALK_V3_PIPELINE_CORRECTION_2026-09-18.md`

---

## 13. Current WALK_V3 rule

Canonical source:

`assets/characters/durotar/walk.png`

Initial source frame count:

**4**

Do not generate additional Walk art until WORLD_SPACE_MEASUREMENT / runtime tuning demonstrates a specific missing transition.
