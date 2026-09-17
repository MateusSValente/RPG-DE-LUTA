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

## O que está sendo validado

- escala do Durotar no cenário;
- leitura de Idle e Walk;
- estabilidade da baseline durante Walk;
- diferenciação visual entre ataque fraco e forte;
- leitura/tamanho da espada;
- silhueta em movimento;
- Defesa;
- aparência do Master em `640×360`.

## Regra de runtime desta demo

A demo usa **assets de imagem reais**. Não há reconstrução artística do personagem ou do cenário por `draw_rect`, `draw_polygon` ou equivalentes.

### Durotar

Os frames de runtime foram derivados da prancha aprovada e normalizados para células `128×128`:

`assets/characters/durotar/`

- `idle.png` — 4 frames;
- `walk.png` — 4 frames;
- `light.png` — 3 frames;
- `heavy_00.png` ... `heavy_03.png`;
- `block_00.png` ... `block_02.png`.

### Cenário

O cenário segue a separação obrigatória da Art Spec e usa duas imagens independentes:

- `assets/stages/forest_test/backwall.webp` — parede/fundo visual;
- `assets/stages/forest_test/ground.webp` — terreno jogável.

Os scripts procedurais antigos de cenário não participam da composição visual desta build.

## Critério para avançar

Se o Durotar passar no teste jogável de escala, leitura, animação e identidade visual, estes assets passam a ser a base da primeira vertical slice. Ajustes posteriores devem preservar `DUROTAR_MASTER_V1` e `DUROTAR_SWORD_V1`.
