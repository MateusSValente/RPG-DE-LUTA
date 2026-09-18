# RPG-DE-LUTA

Demo jogável / vertical slice para validar Durotar e o núcleo de combate antes de ampliar conteúdo.

## Para qualquer IA / agente

**Leia `AGENTS.md` antes de modificar o projeto.**

Modelo operacional obrigatório:

- `docs/AI_PRODUCTION_OPERATING_MODEL.md`

Regra resumida:

`recuperar fonte → validar → extrair/observar sem mutação → medir → diagnosticar → GO/NO-GO → parar no gate`

Não recriar um asset aprovado para resolver um problema técnico antes de medir a fonte real.

## Abrir

O launcher versionado atualmente presente no repositório é:

`ATUALIZAR_E_JOGAR_RPG_DE_LUTA_V3.bat`

Sempre valide o launcher existente no branch/ref atual antes de instruir o usuário a executar um nome de arquivo.

## Controles atuais

- `A / D`: mover
- `J`: ataque fraco protótipo
- `K`: ataque forte protótipo
- `L`: defesa
- `R`: restaurar alvo de treino

## Fontes normativas

- `AGENTS.md`
- `docs/AI_PRODUCTION_OPERATING_MODEL.md`
- `docs/ART_PRODUCTION_MEGA_SPEC.md`
- `docs/COMBAT_POLISH_VERTICAL_SLICE_PLAN.md`
- `docs/art/reference/durotar/DUROTAR_SWORD_V1_SPEC.md`
- `docs/art/animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`

## Durotar

`DUROTAR_MASTER_V1` continua sendo a autoridade de identidade.

A quantidade de frames de uma prancha/reference **não é automaticamente uma meta de produção**.

Para animação existente, o raw asset aprovado é fonte operacional antes de qualquer regeneração.

### WALK atual em investigação

O WALK_V2 foi rejeitado em Runtime QA.

WALK_V3 segue pipeline source-first:

- `docs/art/animation/durotar/WALK_V3_SPEC.md`
- `docs/art/animation/durotar/WALK_V3_PIPELINE_CORRECTION_2026-09-18.md`
- `docs/art/animation/durotar/WALK_V3_RAW_4_FRAME_AUDIT.md`

Fonte canônica do ciclo existente:

`assets/characters/durotar/walk.png`

O ciclo atual possui quatro frames raw. Frames adicionais só podem ser produzidos quando QA/medição provar uma transição específica insuficiente.

## Runtime

Assets do Durotar:

`assets/characters/durotar/`

Cenário de teste:

- `assets/stages/forest_test/backwall.webp`
- `assets/stages/forest_test/ground.webp`

Godot executa os assets. Não reconstruir personagem/cenário artisticamente com `draw_rect`, `draw_polygon` ou equivalentes.

## QA

CI/import verde prova carregamento técnico, não qualidade visual.

Sprites/animações exigem preview e Runtime QA.

Para movimento, separar:

- **in-place preview**: jitter, scale, baseline, pose, loop;
- **world-space/runtime**: foot sliding, stride, deslocamento, start/stop.

## Gate macro

Não avançar para segundo personagem, inimigos finais, hub, loot ou geração de fase antes do GO da vertical slice de combate.
