# RPG-DE-LUTA — MEGA SPEC DE PRODUÇÃO DE ARTE

**Documento:** `ART_PRODUCTION_MEGA_SPEC`  
**Versão:** `1.0.0`  
**Status:** NORMATIVO / OBRIGATÓRIO  
**Escopo:** sprites de personagens, monstros, armas, animações e cenários  
**Motor:** Godot 4  
**Fonte de geração IA:** geração de imagens utilizada durante o desenvolvimento, sempre subordinada a este contrato  

---

# 0. FINALIDADE DESTE DOCUMENTO

Este documento não é apenas uma referência estética. Ele é um **contrato técnico de fabricação de assets**.

Toda arte criada para o projeto deve obedecer às regras deste arquivo. O objetivo é impedir:

- deriva visual entre gerações;
- mudança involuntária de personagem;
- variação de escala;
- variação de densidade de pixel;
- alteração silenciosa de armas, roupas ou anatomia;
- cenários com perspectiva incompatível;
- assets que parecem pertencer a jogos diferentes;
- decisões inventadas pela IA quando uma informação não foi especificada;
- integração direta de imagens não validadas no jogo.

A regra principal do projeto é:

> **A ausência de uma especificação não concede liberdade criativa ao gerador. Ela bloqueia a produção do asset.**

---

# 1. PRINCÍPIOS INEGOCIÁVEIS

## 1.1. FAIL-CLOSED

Quando qualquer dado obrigatório estiver ausente, ambíguo ou conflitante, a produção deve parar.

É proibido preencher lacunas por interpretação, improvisação ou “bom senso artístico”.

Exemplo correto:

```text
Pedido: criar novo ataque pesado do Durotar

Verificação:
✓ CHARACTER_MASTER
✓ ART_STYLE
✓ ARCHETYPE
✓ WEAPON_MASTER
✓ CANVAS_SPEC
✗ ANIMATION_SPEC

RESULTADO: BLOQUEADO
ERRO: MISSING_ANIMATION_SPEC
```

Exemplo proibido:

```text
"Vou imaginar uma pose adequada."
```

---

## 1.2. SEM MONÓLITO

Nenhum sistema artístico deve depender de um arquivo gigantesco, de regras implícitas ou de um único sprite que contenha toda a lógica visual.

A especificação deve ser modular:

```text
ART_STYLE
   ↓
ARCHETYPE
   ↓
MASTER
   ↓
ANIMATION_SPEC / SCENE_SPEC
   ↓
FRAME / MODULE
```

Cada camada pode restringir a anterior, mas nunca contradizê-la silenciosamente.

---

## 1.3. MASTER É CANÔNICO

Todo personagem, monstro ou arma aprovado recebe um `MASTER_ID` versionado.

Exemplos:

```text
DUROTAR_MASTER_V1
FEMALE_KNIGHT_MASTER_V1
WOLF_MASTER_V1
SKELETON_SWORDSMAN_MASTER_V1
DUROTAR_SWORD_V1
```

Uma animação nova não redesenha um personagem. Ela somente altera aquilo que o `ANIMATION_SPEC` permite.

---

## 1.4. NUNCA SOBRESCREVER MASTER APROVADO

Se um Master aprovado precisar mudar:

```text
DUROTAR_MASTER_V1
        ↓
mudança explicitamente aprovada
        ↓
DUROTAR_MASTER_V2
```

O `V1` permanece preservado.

Nenhum asset antigo passa automaticamente para `V2`.

---

# 2. ESTILO GLOBAL TRAVADO — PIXEL_STYLE_V1

## 2.1. Linguagem visual

O projeto utiliza:

- pixel art dark fantasy;
- leitura lateral de beat 'em up;
- silhuetas fortes;
- personagens legíveis em movimento;
- cenário atmosférico sem competir com o combate;
- iluminação dramática controlada;
- detalhamento concentrado em rosto, arma e silhueta;
- textura suficiente para identidade, sem aparência de pintura reduzida.

---

## 2.2. Resolução lógica do jogo

**LOCKED V1**

```text
VIRTUAL_WIDTH  = 640
VIRTUAL_HEIGHT = 360
```

Todo teste visual de gameplay deve ser realizado nesta resolução lógica.

Escala de exibição pode ser maior, porém somente usando escala inteira quando possível.

---

## 2.3. Filtragem

**LOCKED V1**

```text
Texture Filter = Nearest Neighbor
Anti-aliasing artístico = PROIBIDO
Interpolação bilinear = PROIBIDA para sprite pixel art
```

---

## 2.4. Contorno

**LOCKED V1**

```text
OUTLINE_PRIMARY = 1 px
```

Regras:

- contorno precisa ser coerente entre assets da mesma categoria;
- não engrossar automaticamente para 2–3 px em personagens do mesmo archetype;
- outlines internos somente quando melhorarem leitura;
- não utilizar blur para simular contorno.

---

## 2.5. Shading

Padrão:

```text
2 a 4 níveis de luminosidade por material
```

Evitar:

- gradientes suaves;
- pintura digital com dezenas de tons intermediários;
- ruído de textura que destrua a leitura do pixel;
- reflexos fotográficos.

---

## 2.6. Paleta

Limites máximos iniciais:

| Categoria | Máximo de cores principais |
|---|---:|
| Personagem jogável | 32 |
| Inimigo comum | 28 |
| Elite / miniboss | 36 |
| Boss | 48 |

Transparência não conta como cor.

O limite não obriga o asset a utilizar todas as cores.

---

# 3. CONTRATO DE SPRITES DE PERSONAGENS E MONSTROS

# 3.1. Archetypes oficiais V1

```text
HUMANOID_STANDARD_V1
HUMANOID_HEAVY_V1
MONSTER_SMALL_V1
MONSTER_MEDIUM_V1
MONSTER_LARGE_V1
BOSS_CUSTOM_V1
```

Nenhum sprite entra em produção sem archetype definido.

---

# 3.2. HUMANOID_STANDARD_V1

**LOCKED V1**

```text
Canvas: 128 x 128 px
Target body height: 96 px
Minimum body height: 93 px
Maximum body height: 99 px
Facing master: RIGHT
Background: transparent
Primary outline: 1 px
```

Aplicações:

- Durotar;
- segunda personagem jogável;
- humanos comuns;
- esqueletos humanoides de porte normal;
- cultistas de porte normal.

---

# 3.3. HUMANOID_HEAVY_V1

```text
Canvas: 160 x 160 px
Target body height: 120 px
Tolerance: ±6 px
Facing master: RIGHT
Background: transparent
Primary outline: 1 px
```

Aplicações:

- brutos;
- guerreiros gigantes;
- elites grandes.

---

# 3.4. MONSTER_SMALL_V1

```text
Canvas: 128 x 128 px
Body visual range: 64–88 px
Baseline: obrigatório
Background: transparent
```

---

# 3.5. MONSTER_MEDIUM_V1

```text
Canvas: 160 x 160 px
Body visual range: 90–110 px
Baseline: obrigatório
Background: transparent
```

---

# 3.6. MONSTER_LARGE_V1

```text
Canvas: 192 x 192 px
Body visual range: 110–150 px
Baseline: obrigatório
Background: transparent
```

---

# 3.7. Bosses

Bosses devem possuir um `BOSS_SPEC` próprio.

É proibido assumir automaticamente tamanho, canvas ou proporção de boss.

Sem `BOSS_SPEC`, a geração é bloqueada.

---

# 4. BASELINE, PIVOT E ESCALA

## 4.1. Baseline

Todos os frames da mesma entidade devem manter referência de chão estável.

É proibido:

- personagem flutuar entre frames;
- pés mudarem de nível sem ação que justifique salto/queda;
- alterar escala para “caber” a espada.

---

## 4.2. Pivot lógico

Padrão conceitual:

```text
pivot = centro do contato dos pés com o chão
```

A implementação Godot pode converter esse ponto para offset de Sprite2D/AnimatedSprite2D, mas a arte deve continuar obedecendo ao mesmo ponto lógico.

---

## 4.3. Espelhamento

Regra padrão:

```text
RIGHT = master original
LEFT  = mirror horizontal do RIGHT
```

Não gerar novamente o lado esquerdo apenas para mudar direção.

Exceção: assimetria funcional aprovada e registrada no Master.

---

# 5. IDENTIDADE DO PERSONAGEM — PROIBIÇÃO DE INVENÇÃO

Um asset derivado de um Master não pode adicionar, remover ou transformar silenciosamente:

- cabelo;
- barba;
- rosto;
- olhos;
- cicatrizes;
- tatuagens;
- armadura;
- tecido;
- capa;
- bolsas;
- cintos;
- símbolos;
- joias;
- arma;
- proporções anatômicas;
- paleta principal.

Se um detalhe não existe no Master, ele não existe no asset derivado.

Mudança exige nova versão do Master.

---

# 6. MASTER DE ARMA

Armas recorrentes devem possuir Master próprio.

Exemplo:

```text
DUROTAR_SWORD_V1
```

O Master da arma define:

- comprimento visual;
- proporção lâmina/cabo;
- largura da lâmina;
- guarda;
- pomo;
- paleta;
- silhueta.

Durante animação, a arma pode:

- rotacionar;
- mudar posição;
- sofrer foreshortening previsto pela pose.

Ela não pode:

- trocar de design;
- encurtar arbitrariamente;
- ganhar ornamentos;
- mudar de guarda;
- virar outra arma.

---

# 7. SEPARAÇÃO BODY / WEAPON / VFX

Sempre que tecnicamente útil, o asset deve ser pensado em três responsabilidades:

```text
BODY
WEAPON
VFX
```

Regras:

- `BODY` define identidade e animação corporal;
- `WEAPON` segue seu Weapon Master;
- `VFX` não redefine anatomia nem arma;
- efeitos de slash não devem ser pintados como parte permanente da espada.

---

# 8. CONTRATO DE ANIMAÇÃO

Toda animação deve possuir `ANIMATION_SPEC` antes da produção final.

Estrutura mínima:

```text
animation_id
character_master
weapon_master
phase list
frame count target
allowed body changes
forbidden body changes
combat intent
```

---

# 8.1. Idle

Mínimo:

```text
1 frame
```

Recomendado para produção:

```text
2–4 frames
```

Não pode alterar identidade ou baseline.

---

# 8.2. Walk

Mínimo da demo:

```text
4 frames
```

Todos os frames devem manter:

- escala;
- anatomia;
- equipamento;
- baseline coerente.

---

# 8.3. Combo fraco

Cada golpe possui no mínimo:

```text
STARTUP
IMPACT
RECOVERY
```

Na demo:

```text
mínimo = 3 keyframes por golpe
```

Animações intermediárias podem ser adicionadas posteriormente.

---

# 8.4. Combo forte

Cada golpe possui no mínimo:

```text
WINDUP
POWER_IMPACT
RECOVERY
```

Na demo:

```text
mínimo = 3 keyframes
```

O golpe forte precisa ser visualmente distinguível do golpe fraco por pose, amplitude e timing; não por deformação do personagem.

---

# 8.5. Hurt

Mínimo:

```text
1 frame claramente legível
```

Não alterar rosto, cabelo ou anatomia além da pose de reação.

---

# 8.6. Block

A pose deve comunicar defesa imediatamente.

É proibido reutilizar Idle sem alteração significativa e chamá-lo de Block.

---

# 9. FRAME_SPEC

Frames críticos devem possuir intenção definida.

Exemplo:

```text
ATTACK_HEAVY_01_FRAME_000
phase: WINDUP
feet: PLANTED
sword: OVERHEAD
hitbox_active: false

ATTACK_HEAVY_01_FRAME_001
phase: STARTUP
body_motion: FORWARD
sword: DIAGONAL_FORWARD
hitbox_active: false

ATTACK_HEAVY_01_FRAME_002
phase: POWER_IMPACT
sword: FORWARD_DOWN
hitbox_active: true

ATTACK_HEAVY_01_FRAME_003
phase: RECOVERY
hitbox_active: false
```

Se uma pose crítica não estiver definida, a geração é bloqueada.

---

# 10. ANATOMIA E TOLERÂNCIA

Para `HUMANOID_STANDARD_V1`, além da altura total, usar como referência inicial:

```text
Head visual height: 18 px ±2
Shoulder visual width: 30 px ±3
```

Esses valores funcionam como guardrails, não como rig rígido de anatomia realista.

Falhas proibidas:

- braço cresce significativamente entre frames;
- cabeça muda de tamanho;
- largura do torso muda sem perspectiva/pose justificável;
- espada muda de escala sem foreshortening previsto;
- personagem muda de altura quando apenas ataca.

---

# 11. ASSET MANIFEST OBRIGATÓRIO

Todo asset aprovado deve ser rastreável.

Modelo:

```json
{
  "asset_id": "durotar_attack_light_01_frame_002",
  "asset_version": 1,
  "character_master": "DUROTAR_MASTER_V1",
  "art_style": "PIXEL_STYLE_V1",
  "archetype": "HUMANOID_STANDARD_V1",
  "animation": "ATTACK_LIGHT_01",
  "frame": 2,
  "canvas": [128, 128],
  "target_body_height_px": 96,
  "facing": "RIGHT",
  "weapon_master": "DUROTAR_SWORD_V1",
  "status": "APPROVED"
}
```

Asset sem manifest correspondente não é considerado asset oficial.

---

# 12. ESTADOS FORMAIS DE ASSET

Estados permitidos:

```text
DRAFT
NORMALIZED
VALIDATED
APPROVED
IN_GAME
REJECTED
```

Fluxo normal:

```text
DRAFT
  ↓
NORMALIZED
  ↓
VALIDATED
  ↓
APPROVED
  ↓
IN_GAME
```

Fluxo de falha:

```text
qualquer estado anterior a APPROVED
  ↓
REJECTED
```

É proibido:

```text
GENERATED → IN_GAME
```

---

# 13. NOMENCLATURA DE SPRITES

Estrutura de pastas:

```text
assets/
  characters/
    durotar/
      master/
      idle/
      walk/
      attack_light_01/
      attack_heavy_01/
      block/
      hurt/

  enemies/
    skeleton_swordsman/
    wolf/
```

Arquivos:

```text
durotar_idle_000.png
durotar_walk_000.png
durotar_attack_light_01_000.png
durotar_attack_light_01_001.png
```

Não usar nomes como:

```text
final.png
final2.png
novo_final.png
sprite_certo_agora.png
```

---

# 14. VALIDAÇÃO OBRIGATÓRIA DE SPRITE

Checklist objetivo:

```text
[ ] Canvas correto
[ ] Altura dentro do archetype
[ ] Baseline correto
[ ] Fundo transparente
[ ] Sem halo de recorte
[ ] Sem anti-aliasing visual incompatível
[ ] Outline coerente
[ ] Paleta dentro do limite
[ ] Pixel density consistente
[ ] Rosto corresponde ao Master
[ ] Cabelo corresponde ao Master
[ ] Barba corresponde ao Master, quando aplicável
[ ] Roupa corresponde ao Master
[ ] Arma corresponde ao Weapon Master
[ ] Proporção corresponde ao archetype
[ ] Silhueta é legível em 640x360
[ ] Nome de arquivo correto
[ ] Manifest válido
```

Qualquer item obrigatório falhando reprova o asset.

---

# 15. CONTRATO DE CENÁRIOS

Todo cenário jogável possui obrigatoriamente duas responsabilidades visuais separadas:

```text
STAGE_GROUND
STAGE_BACKWALL
```

Essas duas camadas são obrigatórias.

Camadas opcionais:

```text
STAGE_MIDGROUND
STAGE_FOREGROUND
STAGE_FAR_BACKGROUND
```

Nenhuma camada opcional pode substituir `GROUND` ou `BACKWALL`.

---

# 16. STAGE_GROUND

`STAGE_GROUND` é a superfície visualmente jogável.

Pode conter:

- terra;
- pedras;
- raízes;
- lama;
- folhas;
- piso de caverna;
- tijolos;
- mármore;
- rachaduras;
- sangue/poças decorativas que não confundam navegação.

Não deve conter como elemento estrutural principal:

- céu;
- castelo distante;
- paredão vertical;
- árvore inteira ocupando o fundo;
- montanha vertical;
- muralha de fundo.

O Ground deve responder visualmente à pergunta:

> **Onde os personagens estão pisando e lutando?**

---

# 17. STAGE_BACKWALL

`STAGE_BACKWALL` é a parede visual / composição atrás da arena.

Pode representar:

### Floresta
- árvores;
- ruínas;
- estacas;
- construções distantes;
- paredões naturais.

### Caverna
- rocha;
- estalactites;
- fendas;
- cristais;
- paredes naturais.

### Dungeon
- colunas;
- grades;
- criptas;
- altares;
- arcos;
- estátuas.

### Castelo
- muralhas;
- janelas;
- vitrais;
- bandeiras;
- corredores;
- grandes arcos.

O Backwall não deve criar uma segunda superfície que pareça uma área jogável adicional quando ela não é jogável.

---

# 18. PERFIL DE CÂMERA DO CENÁRIO

Toda composição Ground + Backwall deve compartilhar o mesmo `STAGE_CAMERA_PROFILE`.

Primeiro profile oficial:

```text
BEATEMUP_CAMERA_V1
virtual_resolution: 640x360
view: lateral
combat_lane: com profundidade vertical limitada
```

Antes da produção definitiva da primeira fase, os seguintes valores deverão ser explicitamente travados no profile:

```text
horizon_y
combat_lane_top
combat_lane_bottom
baseline reference
```

Até esses valores serem definidos, nenhum kit de cenário final deve ser marcado `APPROVED`.

Isso é propositalmente FAIL-CLOSED.

---

# 19. MODULARIDADE DO TERRENO

Unidade base recomendada V1:

```text
32 x 32 px
```

Módulos compostos preferenciais:

```text
64 x 64 px
```

Kit mínimo de terreno por bioma:

```text
GROUND_CENTER_A
GROUND_CENTER_B
GROUND_EDGE_LEFT
GROUND_EDGE_RIGHT
GROUND_TRANSITION_A
GROUND_DETAIL_A
GROUND_DETAIL_B
```

O objetivo é evitar uma fase inteira desenhada como uma imagem impossível de reutilizar.

---

# 20. MODULARIDADE DO BACKWALL

Tamanhos recomendados:

```text
64 x 64
128 x 128
256 x 256 para módulos grandes
```

Panoramas de `640x360` podem existir para composições específicas, porém não substituem o kit modular quando o conteúdo precisa ser reaproveitado.

---

# 21. PIXEL DENSITY DO CENÁRIO

O cenário pode possuir mais detalhes do que um personagem, mas deve parecer renderizado sob a mesma lógica visual.

Reprovar quando:

- pedras usam pixels aparentemente quatro vezes menores que os sprites;
- background parece pintura HD reduzida;
- folhas viram ruído fotográfico;
- outline e shading não pertencem ao mesmo universo visual.

---

# 22. PALETAS DE BIOMA

Perfis iniciais:

```text
FOREST_PALETTE_V1
CAVE_PALETTE_V1
UNDERGROUND_PALETTE_V1
CASTLE_PALETTE_V1
```

Direções iniciais:

### FOREST_PALETTE_V1
- verdes escuros;
- marrons;
- cinzas musgo;
- vermelho sombrio;
- laranja de fogo/tocha.

### CAVE_PALETTE_V1
- cinzas;
- azul escuro;
- roxo profundo;
- marrom de pedra.

### UNDERGROUND_PALETTE_V1
- verde doente;
- cinza morto;
- vermelho escuro;
- preto úmido.

### CASTLE_PALETTE_V1
- cinza frio;
- vermelho escuro;
- dourado envelhecido;
- preto;
- laranja de fogo.

As paletas definitivas deverão ser derivadas dos Masters visuais aprovados de cada bioma.

---

# 23. STAGE MANIFEST

Modelo obrigatório:

```json
{
  "stage_id": "FOREST_01",
  "stage_version": 1,
  "biome": "FOREST_V1",
  "camera_profile": "BEATEMUP_CAMERA_V1",
  "ground_profile": "FOREST_GROUND_V1",
  "backwall_profile": "FOREST_BACKWALL_V1",
  "art_style": "PIXEL_STYLE_V1",
  "virtual_resolution": [640, 360],
  "status": "APPROVED"
}
```

---

# 24. SEAM TEST OBRIGATÓRIO

Todo módulo repetível deve passar pelo teste:

```text
A + A + A
```

Não pode produzir:

- linha vertical/horizontal evidente;
- quebra de iluminação;
- degrau de escala;
- borda indevida;
- sombra que reinicia de forma impossível.

Também testar:

```text
A + B
B + C
C + A
```

Quando os módulos foram definidos para serem compatíveis entre si.

---

# 25. LEGIBILIDADE DE COMBATE

O cenário será reprovado mesmo sendo artisticamente bonito se:

- personagem se confundir com o fundo;
- hit/reação ficar difícil de enxergar;
- terreno esconder os pés;
- efeitos de ataque desaparecerem no cenário;
- fundo possuir contraste maior que os combatentes sem intenção validada;
- elementos decorativos parecerem inimigos/interativos sem serem.

Prioridades oficiais:

```text
1. Legibilidade de gameplay
2. Consistência visual
3. Velocidade de produção
4. Detalhe estético
```

---

# 26. PIPELINE DE PRODUÇÃO COM IA

Fluxo obrigatório:

```text
PEDIDO
  ↓
RESOLUÇÃO DOS IDs / SPECS
  ↓
VALIDAÇÃO DE PRÉ-CONDIÇÕES
  ↓
GERAÇÃO
  ↓
NORMALIZAÇÃO
  ↓
VALIDAÇÃO VISUAL + TÉCNICA
  ↓
APROVAÇÃO HUMANA
  ↓
VERSIONAMENTO
  ↓
INTEGRAÇÃO NO GODOT
```

É proibido pular diretamente de geração para integração.

---

# 27. PRÉ-CONDIÇÕES PARA GERAR PERSONAGEM

Antes de gerar qualquer sprite derivado, verificar:

```text
CHARACTER_MASTER presente?
ART_STYLE presente?
ARCHETYPE presente?
ANIMATION_SPEC presente?
WEAPON_MASTER presente quando necessário?
FRAME_SPEC presente quando necessário?
```

Se qualquer obrigatório for `NO`:

```text
BLOCK GENERATION
```

---

# 28. PRÉ-CONDIÇÕES PARA GERAR CENÁRIO

Antes de gerar cenário final, verificar:

```text
BIOME_SPEC presente?
ART_STYLE presente?
STAGE_CAMERA_PROFILE completo?
GROUND_SPEC presente?
BACKWALL_SPEC presente?
PALETTE_PROFILE presente?
```

Se qualquer obrigatório for `NO`:

```text
BLOCK GENERATION
```

---

# 29. BDD — PERSONAGENS E MONSTROS

## Feature: impedir mudança silenciosa de personagem

### Scenario: nova animação preserva o Master

**Dado** que existe `DUROTAR_MASTER_V1` aprovado  
**E** ele define cabelo, barba, rosto, armadura, cores e proporções  
**Quando** um novo frame do Durotar for produzido  
**Então** cabelo, barba, rosto, armadura, cores e proporções devem corresponder ao Master  
**E** qualquer mudança não especificada deve reprovar o frame.

---

## Feature: impedir invenção de acessórios

### Scenario: Durotar sem capa continua sem capa

**Dado** que `DUROTAR_MASTER_V1` não possui capa  
**Quando** qualquer animação derivada for criada  
**Então** nenhuma capa pode ser adicionada  
**E** uma geração contendo capa deve ser marcada `REJECTED`.

---

## Feature: escala humanoide

### Scenario: humano padrão dentro da tolerância

**Dado** um asset `HUMANOID_STANDARD_V1`  
**E** canvas `128x128`  
**Quando** a altura visual medida estiver entre `93` e `99` px  
**Então** a regra de altura deve ser considerada aprovada.

### Scenario: humano padrão fora da tolerância

**Dado** um asset `HUMANOID_STANDARD_V1`  
**Quando** a altura estiver abaixo de `93` px ou acima de `99` px  
**Então** o asset deve ser marcado `REJECTED`  
**E** o erro deve incluir `BODY_HEIGHT_OUT_OF_RANGE`.

---

## Feature: consistência da arma

### Scenario: espada corresponde ao Weapon Master

**Dado** `DUROTAR_SWORD_V1`  
**Quando** um frame de ataque do Durotar for validado  
**Então** a espada deve preservar lâmina, guarda, cabo, pomo e proporções do Master.

### Scenario: arma modificada pela geração

**Dado** `DUROTAR_SWORD_V1`  
**Quando** a geração alterar significativamente design ou proporção sem Frame Spec que justifique perspectiva  
**Então** o frame deve ser marcado `REJECTED`  
**E** o erro deve incluir `WEAPON_MASTER_MISMATCH`.

---

## Feature: animação não especificada

### Scenario: tentativa de criar golpe sem Animation Spec

**Dado** uma solicitação de novo golpe  
**E** não existe `ANIMATION_SPEC` correspondente  
**Quando** o pipeline tentar iniciar a produção  
**Então** nenhuma imagem final deve ser produzida  
**E** deve retornar `MISSING_ANIMATION_SPEC`.

---

## Feature: combo fraco

### Scenario: combo fraco mínimo da demo

**Dado** um golpe de combo fraco  
**Quando** o conjunto possuir `STARTUP`, `IMPACT` e `RECOVERY`  
**E** todos os frames respeitarem Master, baseline e archetype  
**Então** o conjunto pode avançar para `VALIDATED`.

---

## Feature: combo forte

### Scenario: combo forte mínimo da demo

**Dado** um golpe forte  
**Quando** o conjunto possuir `WINDUP`, `POWER_IMPACT` e `RECOVERY`  
**E** o impacto for visualmente distinguível do combo fraco  
**E** nenhuma diferença for obtida alterando identidade ou escala corporal  
**Então** o conjunto pode avançar para `VALIDATED`.

---

## Feature: espelhamento

### Scenario: personagem vira para esquerda

**Dado** um Master cujo facing original é `RIGHT`  
**Quando** o personagem precisar olhar para `LEFT`  
**Então** utilizar mirror horizontal  
**E** não gerar um novo personagem do zero  
**Exceto** se houver assimetria funcional registrada no Master.

---

## Feature: monstro consistente com o projeto

### Scenario: monstro visualmente incompatível

**Dado** um monstro novo  
**Quando** pixel density, outline, shading ou paleta quebrarem `PIXEL_STYLE_V1`  
**Então** o monstro deve ser `REJECTED`  
**Mesmo que** isoladamente sua ilustração seja considerada bonita.

---

# 30. BDD — CENÁRIOS

## Feature: composição obrigatória em Ground + Backwall

### Scenario: cenário válido

**Dado** um estágio de floresta  
**Quando** existir um `STAGE_GROUND` jogável  
**E** existir um `STAGE_BACKWALL` visualmente separado  
**Então** o estágio atende à estrutura mínima de composição.

### Scenario: cenário monolítico

**Dado** uma única imagem onde chão e fundo não podem ser tratados separadamente  
**Quando** essa imagem impedir a arquitetura Ground + Backwall  
**Então** o cenário final deve ser `REJECTED`  
**Exceto** se estiver explicitamente classificado como mockup/concept não integrável.

---

## Feature: Ground comunica superfície jogável

### Scenario: chão legível

**Dado** `STAGE_GROUND`  
**Quando** o jogador consegue identificar claramente a superfície onde os combatentes pisam  
**E** os pés permanecem legíveis  
**Então** a regra de legibilidade de Ground passa.

### Scenario: chão parece parede

**Dado** `STAGE_GROUND`  
**Quando** elementos verticais dominarem a camada a ponto de confundir superfície e parede  
**Então** o Ground deve ser `REJECTED`  
**E** o erro deve incluir `GROUND_ROLE_AMBIGUOUS`.

---

## Feature: Backwall não simula área jogável falsa

### Scenario: fundo cria segunda pista falsa

**Dado** um `STAGE_BACKWALL`  
**Quando** sua perspectiva criar uma área que parece acessível mas não é  
**Então** o Backwall deve ser `REJECTED` ou corrigido.

---

## Feature: perspectiva compartilhada

### Scenario: Ground e Backwall incompatíveis

**Dado** Ground e Backwall do mesmo estágio  
**Quando** possuírem perspectivas ou horizontes incompatíveis  
**Então** o estágio deve ser `REJECTED`  
**E** o erro deve incluir `CAMERA_PROFILE_MISMATCH`.

---

## Feature: legibilidade de combate

### Scenario: cenário bonito mas prejudica o gameplay

**Dado** um cenário artisticamente aprovado isoladamente  
**Quando** testado com personagens em `640x360`  
**E** personagens, ataques ou pés perderem leitura  
**Então** o cenário deve ser `REJECTED` para gameplay.

---

## Feature: modularidade

### Scenario: módulo repete sem costura

**Dado** um módulo `A` definido como repetível  
**Quando** renderizado como `A + A + A`  
**Então** não deve existir seam visual evidente.

### Scenario: módulo não reutilizável

**Dado** um kit declarado modular  
**Quando** cada peça depender exclusivamente de uma composição única  
**Então** o kit não atende ao requisito de modularidade  
**E** deve ser `REJECTED` como kit modular.

---

# 31. CÓDIGOS DE ERRO PADRÃO

Utilizar códigos objetivos nos processos de revisão:

```text
MISSING_MASTER
MISSING_ARCHETYPE
MISSING_ANIMATION_SPEC
MISSING_FRAME_SPEC
MISSING_WEAPON_MASTER
MISSING_STAGE_CAMERA_PROFILE
MISSING_GROUND_SPEC
MISSING_BACKWALL_SPEC
BODY_HEIGHT_OUT_OF_RANGE
BASELINE_MISMATCH
PIXEL_DENSITY_MISMATCH
PALETTE_OUT_OF_SPEC
OUTLINE_MISMATCH
MASTER_IDENTITY_MISMATCH
WEAPON_MASTER_MISMATCH
GROUND_ROLE_AMBIGUOUS
BACKWALL_ROLE_AMBIGUOUS
CAMERA_PROFILE_MISMATCH
COMBAT_READABILITY_FAILURE
SEAM_TEST_FAILURE
MANIFEST_MISSING
```

Evitar motivos vagos como:

```text
"ficou estranho"
"não gostei"
"parece diferente"
```

Quando o problema for técnico, ele deve ser nomeado tecnicamente.

---

# 32. CHANGE CONTROL

Qualquer alteração de regra LOCKED deve:

1. ser explicitamente aprovada;
2. gerar nova versão deste documento ou do spec afetado;
3. indicar se assets existentes precisam migração;
4. nunca modificar silenciosamente um padrão já usado.

Exemplo:

```text
PIXEL_STYLE_V1 → PIXEL_STYLE_V2
```

Não redefinir `PIXEL_STYLE_V1` retroativamente.

---

# 33. O QUE É CONCEPT E O QUE É ASSET FINAL

A geração pode criar mockups/concepts mais livres para decidir direção artística.

Eles devem ser marcados:

```text
CONCEPT_ONLY
```

Um concept:

- não é automaticamente sprite;
- não é automaticamente cenário integrável;
- não ignora o processo de normalização;
- não vira Master sem aprovação explícita.

Somente assets `APPROVED` podem ser tratados como fonte canônica.

---

# 34. DEFINIÇÃO DE PRONTO — SPRITE

Um sprite só está **DONE** quando:

```text
✓ possui Master/Archetype válidos
✓ respeita PIXEL_STYLE_V1
✓ está normalizado
✓ passa escala e baseline
✓ passa identidade
✓ passa Weapon Master, quando aplicável
✓ possui Manifest
✓ foi aprovado visualmente
✓ está versionado
✓ foi testado no gameplay em 640x360
```

---

# 35. DEFINIÇÃO DE PRONTO — CENÁRIO

Um cenário só está **DONE** quando:

```text
✓ possui Ground
✓ possui Backwall
✓ ambos usam o mesmo Camera Profile
✓ bioma e paleta estão definidos
✓ Ground comunica área jogável
✓ Backwall não cria falsa área jogável
✓ personagens permanecem legíveis
✓ módulos aplicáveis passam Seam Test
✓ possui Stage Manifest
✓ foi aprovado em gameplay 640x360
```

---

# 36. REGRA FINAL DE AUTORIDADE

Em caso de conflito, a ordem de autoridade é:

```text
1. Este documento e specs versionados
2. Master aprovado do asset
3. Animation/Frame/Stage Spec aprovado
4. Referências visuais aprovadas
5. Prompt de geração
```

O prompt nunca pode sobrescrever silenciosamente uma regra superior.

Se um pedido humano contradizer uma regra LOCKED, a mudança precisa ser tratada como alteração explícita de especificação antes da produção final.

---

# 37. ESTRUTURA DE DOCUMENTAÇÃO RECOMENDADA

```text
docs/
  ART_PRODUCTION_MEGA_SPEC.md
  art/
    masters/
    archetypes/
    animations/
    biomes/
    stages/

assets/
  characters/
  enemies/
  weapons/
  environments/
```

Este arquivo é a fonte normativa inicial. Documentos especializados futuros podem detalhar regras sem contradizê-lo.

---

# 38. PRIMEIROS MASTERS A SEREM CRIADOS

Antes da primeira demo, deverão ser formalizados:

```text
PIXEL_STYLE_V1
BEATEMUP_CAMERA_V1
DUROTAR_MASTER_V1
DUROTAR_SWORD_V1
FEMALE_KNIGHT_MASTER_V1
FOREST_V1
FOREST_GROUND_V1
FOREST_BACKWALL_V1
FOREST_PALETTE_V1
```

Depois destes Masters serem aprovados, eles passam a ser a base obrigatória para a produção da Demo 0.1.
