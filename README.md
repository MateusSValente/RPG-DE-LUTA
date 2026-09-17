# RPG-DE-LUTA

Demo jogável / vertical slice em desenvolvimento para validar Durotar e o núcleo de combate antes de ampliar conteúdo.

## Abrir

Execute `ATUALIZAR_E_JOGAR_RPG_DE_LUTA_V4.bat`.

O launcher atualiza a `main`, importa assets com Godot 4.7.2 e abre a cena principal.

## Controles atuais

- `A / D`: mover
- `J`: ataque fraco protótipo
- `K`: ataque forte protótipo
- `L`: defesa
- `R`: restaurar alvo de treino

## Estado da arte

A prancha `DUROTAR_MASTER_V1_REFERENCE.webp` continua sendo a fonte de verdade visual do personagem.

A quantidade de frames da prancha original é considerada **protótipo**, não meta final de produção.

Contratos atuais:

- `docs/ART_PRODUCTION_MEGA_SPEC.md`
- `docs/COMBAT_POLISH_VERTICAL_SLICE_PLAN.md`
- `docs/art/reference/durotar/DUROTAR_SWORD_V1_SPEC.md`
- `docs/art/animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`
- `docs/art/animation/durotar/WALK_V2_SPEC.md`

## Regra de produção

Nenhuma nova animação do Durotar pode entrar em produção sem `ANIMATION_SPEC` versionada.

Fluxo:

`Master travado → Spec → Key poses → Review → In-betweens → Normalização → Runtime QA → LOCKED`

Próxima arte autorizada: somente as quatro key poses de `WALK_V2` (`F01/F03/F05/F07`).

## Runtime desta build

A demo usa assets de imagem reais para Durotar e para as camadas visuais do cenário. Não reconstruir personagem/cenário artisticamente com `draw_rect`, `draw_polygon` ou equivalentes.

### Durotar runtime atual

Assets em `assets/characters/durotar/`.

### Cenário

Assets em `assets/stages/forest_test/`:

- `backwall.webp`
- `ground.webp`

## Validação automática

O workflow `Godot 4.7.2 Validate` falha se qualquer sprite ou camada de cenário obrigatória não carregar ou tiver dimensão incorreta.

## Gate

Não avançar para segundo personagem, inimigos finais, hub, loot ou geração de fase antes do GO da vertical slice de combate.
