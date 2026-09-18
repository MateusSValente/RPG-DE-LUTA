# DUROTAR_IDLE_V1_REFERENCE

**Status:** USER-APPROVED IDLE REFERENCE / NOT RUNTIME-LOCKED  
**Character:** Durotar  
**Branch:** `design/walk-v3-biomechanics`

## Source

User-authored/selected idle image received on 2026-09-18.

Original uploaded source:
- dimensions: 1254×1254 RGBA;
- SHA-256: `d9bf1b5231f553c5fe951812d7ac84408f7e3d2d914ec80f20e95394097083fd`.

Committed reference:
- `DUROTAR_IDLE_V1_REFERENCE_128.png`;
- 128×128 RGBA;
- nearest-neighbor normalization only;
- transparent background;
- visual bottom aligned near project baseline Y=116;
- SHA-256 of committed normalized PNG: `bc04be8131d6f0ddd545e943393869236ebf4e7d92f407804012801edf0dd32a`.

## Authority

This image is the current approved **Idle visual reference** supplied by the user.

It does NOT silently replace:
- `DUROTAR_MASTER_V1`;
- the existing runtime `assets/characters/durotar/idle.png`;
- any LOCKED animation.

Future Idle production must preserve this pose/identity unless a newer version is explicitly approved.

## Next use

When Idle polish resumes:
1. treat this frame as the first approved Idle reference;
2. audit current runtime Idle separately;
3. derive additional Idle motion only if needed;
4. do not regenerate Durotar from scratch.
