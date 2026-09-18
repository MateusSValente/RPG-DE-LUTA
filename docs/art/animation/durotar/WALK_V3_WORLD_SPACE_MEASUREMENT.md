# WALK_V3 — WORLD_SPACE_MEASUREMENT — ALTERNATING STEP TEST

## Source validation
- Source SHA-256: `53bc34729aee03ca66f54e289f74e787cece67d9c38f3cedc20b9b9e855778dd`
- Expected SHA-256 from RAW audit: same
- Dimensions: 512×128
- Exact W00–W03 source slices revalidated: PASS
- Source pixels modified: NO

## 1. Foot/support table

| Frame | FRONT_FOOT_X | REAR_FOOT_X | FRONT_BOTTOM_Y | REAR_BOTTOM_Y | SUPPORT | SWING | Probable phase |
|---|---:|---:|---:|---:|---|---|---|
| W00 | 74.0 | 48.0 | 117 | 117 | FRONT candidate (medium) | REAR candidate, but grounded | CONTACT candidate |
| W01 | 74.5 | 47.0 | 118 | 118 | FRONT candidate (medium-high) | REAR candidate, but grounded | DOWN candidate |
| W02 | 74.5 | 47.0 | 118 | 117 | AMBIGUOUS | AMBIGUOUS | PASSING candidate, incomplete |
| W03 | 73.5 | 46.5 | 118 | 118 | AMBIGUOUS | AMBIGUOUS | late stance/recovery |

The screen-right/front foot remains in front in **all four frames**.

Measured front↔rear separation:
`26.0, 27.5, 27.5, 27.0 px`

Average: **27.0px**.

## 2. Cycle distances tested

| Cycle distance | Root advance/frame (uniform) | Mean front sample drift | Max front sample drift | Cycle @60px/s | @90px/s | @120px/s |
|---:|---:|---:|---:|---:|---:|---:|
| 8 | 2.00 | 2.00 | 2.50 | 133.3ms | 88.9ms | 66.7ms |
| 18 | 4.50 | 4.50 | 5.00 | 300.0ms | 200.0ms | 150.0ms |
| 24 | 6.00 | 6.00 | 6.50 | 400.0ms | 266.7ms | 200.0ms |
| 27 | 6.75 | 6.75 | 7.25 | 450.0ms | 300.0ms | 225.0ms |
| 36 | 9.00 | 9.00 | 9.50 | 600.0ms | 400.0ms | 300.0ms |
| 54 | 13.50 | 13.50 | 14.00 | 900.0ms | 600.0ms | 450.0ms |

The 27px value is source-derived from the measured average foot span.  
54px is the corresponding 2× same-foot/full-stride hypothesis.  
Neither value is inherited from the former 56px assumption.

## 3. Model A — Uniform

- Cycle test: 27px
- Diagnostic speed: 60px/s
- Holds: `112.5,112.5,112.5,112.5 ms`
- Offsets: none
- Root increments: `6.75,6.75,6.75,6.75 px`
- Front sample drifts: `7.25,6.75,5.75,7.25 px`
- Rear sample drifts: `5.75,6.75,6.25,8.25 px`
- W00/W01 support-hold slide: **6.75px / 6.75px**

## 4. Model B — Adjusted timing

Timing candidates tested:
- `120,120,110,100`
- `120,120,120,90`
- `110,130,110,100`
- `120,130,100,100`
- `130,120,90,110`

Selected:
- Holds: `120,120,110,100 ms`
- Root increments: `7.2,7.2,6.6,6.0 px`
- Front sample drifts: `7.7,7.2,5.6,6.5 px`
- Rear sample drifts: `6.2,7.2,6.1,7.5 px`
- W00/W01 support-hold slide: **7.20px / 7.20px**

Giving CONTACT/DOWN more time does not lock the foot; during continuous movement it gives the static support image more distance over which to slide.

## 5. Model C — Timing + small runtime offsets

- Same timing as B.
- Integer X offsets searched within ±3px.
- Selected minimax X offsets: `0,-1,-1,0 px`
- Y offsets: `1,0,0,0 px`
- Front sample drifts: `6.7,7.2,6.6,6.5 px`
- Rear sample drifts: `5.2,7.2,7.1,7.5 px`
- W00/W01 within-hold slide remains **7.20px / 7.20px**

Model C distributes sample drift most evenly, but does not create planting or leg exchange.

## 6. Hard runtime constraint

For cyclic per-frame offsets, the offsets cancel when returning to W00.

If the same visual foot returns to nearly the same local position, total world advance of that contact over one loop equals cycle distance `D`.

Average per-transition advance is therefore:

`D / 4`

To average at most 2px per transition requires:

`D <= 8px`

But the measured visual foot span is approximately **27px**.

Small cyclic offsets can redistribute drift; they cannot eliminate it while preserving a plausible step distance.

## 7. Alternating-support test

A real forward transfer should read:

`FOOT A support → body passes → FOOT B lands ahead → FOOT A releases`

The source does not contain that event.

Under Model C:
- W01 FRONT world onset ≈ **80.7px**
- W02 REAR world onset ≈ **60.4px**
- proposed support-switch delta = **-20.3px**

The putative new REAR support is about 20px **behind** the previous FRONT contact, not ahead of it.

This is not a timing problem.

## 8. W03→W00

Classification:

**3. NENHUMA TROCA DE APOIO**

There is also a secondary loop discontinuity from the prior in-place audit.

At the wrap, W00 again presents the screen-right foot forward and screen-left foot rear.

Trying to reinterpret the next W00 REAR foot as the new support places it about **19.5px behind** the W03 FRONT contact in Model C.

## 9. Best model

**MODEL C** is the best of the three tested configurations because its small offsets distribute sample drift most evenly without modifying source pixels.

It still fails the alternating-step criterion.

## 10. Decision

# 4 FRAMES INSUFICIENTES — seguir para TARGETED_ART_REQUIREMENT

**MISSING_FUNCTION:** opposite foot contact / visible leg exchange

**BETWEEN:** primarily `W03 → W00`

**PURPOSE:** establish the currently rear leg as the new forward contact and make support transfer unmistakable.

Secondary missing information:
`W01 → W02` lacks a clean passing/swing event.

**WHY_RUNTIME_CANNOT_SOLVE_IT:**

Timing and whole-sprite offsets can change when and where the existing drawings are shown. They cannot change the leg topology contained in those drawings.

Across W00–W03:
- the same screen side remains forward;
- the rear leg never overtakes the front;
- no unambiguous opposite-foot contact exists;
- no clean airborne/passing pose communicates the exchange.

Runtime tuning can reduce or redistribute slide, but cannot manufacture the missing visual event.

No art was generated or modified in this gate.
