# RPG-DE-LUTA — Demo jogável de validação do Durotar

Esta build existe para testar o `DUROTAR_MASTER_V1` em gameplay antes de avançar a produção do jogo.

## Abrir

1. Execute `ATUALIZAR_E_JOGAR_RPG_DE_LUTA_V3.bat`.
2. O BAT atualiza a branch `main` e abre o projeto diretamente no Godot 4.

## Controles

- `A` / `D`: mover
- `J`: combo fraco
- `K`: combo forte
- `L`: defesa (segurar)
- `R`: restaurar o boneco de treino

## Runtime desta build

A demo usa somente **assets de imagem reais** para Durotar e para as duas camadas visuais do cenário. Não há reconstrução visual procedural do personagem nem do cenário.

### Durotar

Assets em `assets/characters/durotar/`:
- `idle.png` — 4 frames
- `walk.png` — 4 frames
- `light.png` — 3 frames
- `heavy_00.png` a `heavy_03.png`
- `block_00.png` a `block_02.png`

### Cenário

Assets em `assets/stages/forest_test/`:
- `backwall.webp` — camada traseira
- `ground.webp` — terreno jogável

## Critério de validação

Validar escala, identidade visual, leitura do Idle/Walk, estabilidade dos pés, Combo Fraco, Combo Forte, Defesa e a proporção da espada. Se passar, estes assets viram a base da primeira vertical slice.
