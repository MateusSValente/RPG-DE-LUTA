# WALK_V3 — RAW_4_FRAME_AUDIT

**Gate:** RAW_4_FRAME_AUDIT  
**Source:** `assets/characters/durotar/walk.png`  
**Source dimensions:** 512×128 px  
**Cell size:** 128×128 px  
**Art mutation:** NONE  
**Gameplay/world displacement:** NONE

## Validation

The source was retrieved from GitHub and validated as a 512×128 indexed PNG.

W00/W01/W02/W03 were extracted by exact 128×128 cell slicing.

Pixel-array equality against each corresponding source cell: **PASS for all four frames**.

No resize, filter, anti-aliasing, reconstruction, bbox-fit or image generation was applied.

## Objective measurements

| Frame | Alpha bbox | Visual size | Bottom opaque Y | Alpha centroid |
|---|---|---:|---:|---:|
| W00 | (32,19,100,118) | 68×99 | 117 | (66.62, 74.00) |
| W01 | (33,20,103,119) | 70×99 | 118 | (67.85, 75.44) |
| W02 | (29,19,101,119) | 72×100 | 118 | (66.21, 74.49) |
| W03 | (29,19,97,119) | 68×100 | 118 | (63.54, 74.42) |

The project target baseline is Y=116, but raw opaque foot/outline pixels reach Y=117–118. No correction is applied at this gate.

The bitmap does not encode a root/pivot. (64,116) remains the project logical-pivot target, not a measured bitmap fact.

## Lower-body/contact observations

Approximate contact centers measured from brown/dark boot-region pixels near the floor:

| Frame | Rear/screen-left X | Rear bottom Y | Front/screen-right X | Front bottom Y |
|---|---:|---:|---:|---:|
| W00 | 48.0 | 117 | 74.0 | 117 |
| W01 | 47.0 | 118 | 74.5 | 118 |
| W02 | 47.0 | 117 | 74.5 | 118 |
| W03 | 46.5 | 118 | 73.5 | 118 |

Across all four frames:

- screen-right foot remains forward;
- screen-left foot remains rear;
- both boots remain at or very near the ground;
- no frame shows the rear foot clearly passing the forward foot;
- no unambiguous airborne swing-foot pose exists.

This is the strongest finding of this gate.

## Probable phase classification

These labels are derived from the raw frames, not inherited from WALK_V2.

### W00
- forward leg: screen-right;
- rear leg: screen-left;
- support candidate: screen-right/front;
- rear leg remains grounded;
- probable phase: **CONTACT / stance candidate**;
- confidence: medium.

### W01
- same front/rear ordering;
- body is the lowest frame by centroid/top-edge evidence;
- probable phase: **DOWN / compression candidate**;
- confidence: medium-high.

### W02
- same front/rear ordering;
- rear leg changes shape but does not clearly pass under/forward;
- probable phase: **PASSING candidate, visually ambiguous/incomplete**;
- confidence: low.

### W03
- same front/rear ordering;
- both feet remain close to the floor;
- probable phase: **UP / late-stance/recovery candidate, visually ambiguous**;
- confidence: low.

## In-place continuity

Small-translation upper-body comparison found approximate best alignments:

- W00→W01: (+1,+1) px
- W01→W02: (-2,0) px
- W02→W03: (-3,0) px
- W03→W00: (+4,-1) px

These are diagnostic measurements, not proposed runtime corrections.

The same-pivot visual difference is largest at **W03→W00**, making it the primary loop-discontinuity candidate.

## What already works

- identity is stable because the canonical source is preserved;
- armor and weapon remain from the same source;
- visual bbox height varies only 99–100 px;
- top-edge vertical variation is only 1 px;
- the four frames form one coherent combat-advance/shuffle family;
- this gate provides no justification for replacing a canonical frame.

## Problems / uncertainty

1. **No clear leg exchange.** The front/rear ordering does not reverse during W00–W03.
2. **No clean swing-foot event.** Both feet remain near the floor.
3. **W03→W00 is the highest-risk transition.**
4. **Sword tip remains very low**, with ground-scrape risk.
5. **Bottom opaque Y varies 117–118**, while the logical baseline target is 116.

## Can runtime/timing alone solve it?

**Not yet proven.**

Potentially runtime/data-fixable:
- root/body jitter;
- baseline presentation;
- cadence;
- visual stride vs logical speed;
- start/stop frame selection.

Potentially art-limited:
- no opposite contact;
- no clear passing/swing pose;
- same front/rear foot ordering across all four frames.

No new art is authorized by this report.

## Transition risk

1. **W03→W00 — highest**
2. **W01→W02 — medium**
3. **W02→W03 — medium**
4. **W00→W01 — lowest**

No transition is corrected here.

## Gate decision

**GO → WORLD_SPACE_MEASUREMENT**, pending owner approval.

This is not a GO for new art.

The next gate must measure:
- world-space foot drift;
- candidate cycle distance from the real frames;
- whether runtime offsets/cadence can make the four-frame cycle convincing;
- whether a specific missing transition remains after tuning.

Until owner approval:

**stop here; do not generate new sprites or in-betweens.**
