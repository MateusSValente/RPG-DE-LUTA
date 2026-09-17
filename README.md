# RPG-DE-LUTA

Demo jogável para validação do `DUROTAR_MASTER_V1`.

## Abrir

Execute `ATUALIZAR_E_JOGAR_RPG_DE_LUTA_V3.bat`.

O launcher agora:

1. atualiza a `main`;
2. localiza o Godot 4.7.2;
3. executa uma importação headless para garantir que sprites e cenário sejam convertidos para o cache do Godot;
4. só depois abre o jogo.

## Controles

- `A` / `D`: mover
- `J`: combo fraco
- `K`: combo forte
- `L`: defesa
- `R`: restaurar boneco

## Runtime desta build

A demo usa somente assets reais de imagem para Durotar e para as duas camadas do cenário.

### Durotar

`assets/characters/durotar/`

### Cenário

`assets/stages/forest_test/`

## Validação automática

O workflow `Godot 4.7.2 Validate` falha se qualquer sprite ou camada de cenário obrigatória não carregar ou tiver dimensão incorreta.
