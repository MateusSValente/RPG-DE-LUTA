# WALK_V3_POSE_GUIDE_V1

**Status:** POSE_GUIDE_REVIEW  
**Source of truth:** `WALK_V3_MOTION.json` schema v2  
**Art generation:** BLOCKED until this gate passes.

## Purpose

This guide removes biomechanical decision-making from image generation. The generated Durotar must conform to these joint targets instead of inventing a walk cycle.

## Technical result

- 8 authored pose samples;
- 7 px distance phase step;
- 56 px full stride cycle;
- NEAR support samples F01–F04 keep planted contact at world X=87;
- FAR support samples F05–F08 keep planted contact at world X=115;
- authored-sample support-foot drift = **0 px**;
- pelvis bob = 2 px peak-to-peak;
- common logical root = (64,116);
- one shared Master-derived scale;
- independent bbox-fit per frame forbidden.

## Critical poses

### F03 — PASSING_FAR
FAR leg passes under/forward of pelvis while NEAR foot remains support. The passing foot is lifted and must retain a continuous hip→knee→ankle→foot read.

### F07 — PASSING_NEAR
NEAR leg passes while FAR foot supports. This pose specifically replaces the ambiguous/malformed anatomy seen in WALK_V2.

## Sword

The guide moves the sword line outward from the gait. Its tip remains above the baseline and the diagonal does not cross both lower legs. Final art must still pass `DUROTAR_SWORD_V1` dimensional checks.

## Loop

F08 is an UP pose with the NEAR leg advancing. It must drop into F01 CONTACT_NEAR without a positional pop. F01 of the next cycle occurs after +56 px root travel.

## Gate

Before final sprite generation verify:

- CONTACT poses clearly differ from PASSING poses;
- F03/F07 anatomy is unequivocal;
- no crouch/shuffle read;
- sword does not mask lower-leg readability;
- planted contact logic survives a moving-world debug preview;
- Idle posture can transition into F01/F05 without a vertical snap.

Binary PNG/GIF previews are intentionally not committed before approval because this repository has already experienced binary asset corruption.