# WALK_V3 — RAW_4_FRAME_AUDIT

**Gate:** RAW_4_FRAME_AUDIT  
**Source:** `MateusSValente/RPG-DE-LUTA` → branch `design/walk-v3-biomechanics` → `assets/characters/durotar/walk.png`  
**Art mutation:** NONE  
**Gameplay/world displacement:** NONE

## 1. Source validation

- Source dimensions: **512×128 px**
- Source mode: **indexed PNG (P)**
- Cell size: **128×128 px**
- Cells: **4**
- SHA-256 of retrieved source: `53bc34729aee03ca66f54e289f74e787cece67d9c38f3cedc20b9b9e855778dd`
- W00/W01/W02/W03 were extracted by exact cell slicing.
- Pixel-array equality against each corresponding source cell: **PASS for all four frames**.
- No resize, filtering, anti-aliasing, reconstruction, bbox-fit or image generation was applied.

## 2. Objective frame measurements

| Frame | Alpha bbox (x0,y0,x1,y1) | Visual size | Bottom opaque Y | Alpha centroid (x,y) |
|---|---|---:|---:|---:|
| W00 | (32,19,100,118) | 68×99 | 117 | (66.62, 74.00) |
| W01 | (33,20,103,119) | 70×99 | 118 | (67.85, 75.44) |
| W02 | (29,19,101,119) | 72×100 | 118 | (66.21, 74.49) |
| W03 | (29,19,97,119) | 68×100 | 118 | (63.54, 74.42) |

## 3. Lower-body / contact measurements

| Frame | Rear/screen-left contact center X | Rear bottom Y | Front/screen-right contact center X | Front bottom Y |
|---|---:|---:|---:|---:|
| W00 | 48.0 | 117 | 74.0 | 117 |
| W01 | 47.0 | 118 | 74.5 | 118 |
| W02 | 47.0 | 117 | 74.5 | 118 |
| W03 | 46.5 | 118 | 73.5 | 118 |

Across all four frames:
- the screen-right foot remains forward;
- the screen-left foot remains rear;
- both boots remain at or very near the ground;
- there is no frame where the rear foot clearly passes the forward foot;
- there is no unambiguous airborne swing-foot pose.

## 4. Phase interpretation

- W00: CONTACT / stance candidate — medium confidence.
- W01: DOWN / compression candidate — medium-high confidence.
- W02: PASSING candidate, but incomplete/ambiguous — low confidence.
- W03: late stance/recovery candidate — low confidence.

## 5. In-place continuity

Approximate best small upper-body translations:

- W00→W01: **(+1,+1) px**
- W01→W02: **(-2,0) px**
- W02→W03: **(-3,0) px**
- W03→W00: **(+4,-1) px**

Highest-risk in-place transition: **W03→W00**.

## 6. Decision

### GO → WORLD_SPACE_MEASUREMENT

This was not a GO for new art.

The gate required world-space testing to determine whether timing/runtime could make the four source frames convincing or whether a specific missing visual function had to be documented.
