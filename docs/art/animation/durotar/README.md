# Durotar — Animation Production Index

Fonte visual: `DUROTAR_MASTER_V1`  
Arma: `DUROTAR_SWORD_V1`

## Contratos ativos

- `DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`
- `WALK_V2_SPEC.md`

## Estado atual

`WALK_V2`: **NORMALIZED / RUNTIME_QA**

Arte aprovada:
- ciclo completo com 8 frames;
- runtime strip normalizada em `assets/characters/durotar/walk.png`;
- células `128×128`;
- strip final `1024×128`;
- baseline `Y=116`;
- pivot lógico `(64,116)`;
- timing por frame @60 Hz: `4,3,4,3,4,3,4,3`;
- velocidade inicial de playtest: `120 px/s`.

Próximo gate:

`RUNTIME_QA → LOCKED`

Validar no jogo:
- foot slide;
- jitter vertical;
- F08→F01;
- esquerda/direita;
- consistência da espada;
- transição Idle↔Walk.

## Pipeline

`SPEC_DRAFT → KEYPOSE_REVIEW → KEYPOSE_APPROVED → INBETWEEN_PRODUCTION → NORMALIZED → RUNTIME_QA → LOCKED`

Nenhuma etapa pode ser pulada.
