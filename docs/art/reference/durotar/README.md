# Durotar — Referência Visual Canônica

**Status:** APPROVED REFERENCE  
**Character Master:** `DUROTAR_MASTER_V1`  
**Weapon Master:** `DUROTAR_SWORD_V1`  
**Art Style:** `PIXEL_STYLE_V1`

Esta pasta contém a referência visual canônica aprovada do Durotar.

## Fonte de verdade visual

Arquivo de referência:

`DUROTAR_MASTER_V1_REFERENCE.webp`

A imagem fixa a aparência oficial do personagem e deve ser utilizada como referência obrigatória em qualquer nova geração de sprites do Durotar.

Contratos complementares obrigatórios:

- `DUROTAR_SWORD_V1_SPEC.md` — contrato travado da arma;
- `../../animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md` — padrão de produção de animação;
- `../../animation/durotar/WALK_V2_SPEC.md` — especificação frame a frame da próxima animação em produção.

### Elementos travados

- cabelo preto curto e encaracolado;
- barba preta cheia;
- formato geral do rosto e olhos;
- armadura vinho/marrom;
- acabamento de pelos claros;
- luvas e botas marrons;
- cintos e tiras existentes;
- proporção corporal robusta;
- nenhuma capa adicional;
- silhueta e proporções de `DUROTAR_SWORD_V1`.

Nenhum asset derivado pode adicionar, remover ou redesenhar estes elementos sem nova versão explícita do Master.

## Animações representadas na referência

A prancha aprovada original contém protótipos visuais:

- `IDLE`: 4 frames;
- `WALK`: 4 frames;
- `COMBO_FRACO`: 3 frames;
- `COMBO_FORTE`: 4 frames;
- `DEFESA`: 3 frames.

Esses blocos preservam a intenção visual aprovada da primeira demo, mas **não definem mais a quantidade final de frames de produção**.

A vertical slice passa a seguir `DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1`, incluindo:

- Idle: 6 desenhos;
- Walk: 8 desenhos;
- Light 1: 6 desenhos;
- Light 2: 6 desenhos;
- Light 3/Finisher: 8 desenhos;
- Heavy: 10 desenhos;
- defesa separada em Enter / Hold / Hit.

Mudanças adicionais exigem uma especificação versionada.

## Importante — referência visual x asset de runtime

`DUROTAR_MASTER_V1_REFERENCE.webp` é uma **prancha de referência visual**, não um spritesheet final pronto para importação direta no Godot.

Os assets de runtime devem ser derivados dela e obedecer ao contrato `docs/ART_PRODUCTION_MEGA_SPEC.md`, incluindo:

- canvas individual de `128x128 px` para `HUMANOID_STANDARD_V1` quando a animação não declarar camada/canvas maior;
- altura corporal alvo de `96 px`, tolerância `93–99 px`;
- baseline `Y = 116`;
- pivot lógico `64,116`;
- PNG RGBA transparente;
- outline principal de `1 px`;
- máximo de 32 cores principais;
- nearest-neighbor;
- sem anti-aliasing;
- sem sombra de chão embutida;
- BODY / WEAPON / VFX separados quando aplicável.

## Política FAIL-CLOSED

Se uma nova geração divergir desta referência em identidade, arma, roupa, proporção ou estilo, ela deve ser rejeitada.

A ausência de uma especificação não autoriza invenção criativa. Mudanças exigem uma nova versão explicitamente aprovada do Master.

**Nenhuma nova animação do Durotar pode ser produzida sem `ANIMATION_SPEC` versionada.**
