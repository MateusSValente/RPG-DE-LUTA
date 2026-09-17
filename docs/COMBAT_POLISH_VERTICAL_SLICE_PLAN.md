# RPG-DE-LUTA — Combat Polish / Vertical Slice Plan

Status: **PLANNED**  
Owner: projeto RPG-DE-LUTA  
Escopo atual: **Durotar + arena de teste + boneco/alvo de treino**  
Objetivo: transformar a demo atual em uma **vertical slice de combate com padrão comercial**, antes de ampliar conteúdo, inimigos, hub ou segundo personagem.

---

## 1. Por que este plano existe

O teste jogável validou que a identidade visual do Durotar funciona em runtime, mas expôs os pontos que hoje mais afastam o resultado de um beat'em up comercial:

- caminhada com sensação de deslizamento;
- Idle pouco vivo;
- ataque fraco ainda lido como golpe isolado, não combo;
- ataque forte com VFX misturado ao sprite e dominando a leitura;
- proporção/identidade da espada variando entre frames;
- defesa pouco inequívoca;
- transições secas entre estados;
- pouco peso físico no impacto;
- personagem muito plantado durante ataques;
- contato com o chão e leitura de profundidade ainda fracos;
- HUD de debug muito dominante;
- alvo de treino pouco adequado para sessões de QA.

A estratégia é corrigir isso **antes** de produzir grande volume de conteúdo. O mercado normalmente estabiliza primeiro o núcleo de movimento, leitura, timing, impacto e pipeline; depois escala personagens, inimigos e fases.

---

## 2. Referências de mercado usadas

Este plano não tenta copiar um jogo específico. Ele usa práticas recorrentes de produção de jogos de ação 2D/beat'em up:

### GDC — Treachery in Beatdown City
A apresentação "Animating a Complex 2D Fighting Game 3 Frames at a Time" mostra que baixo número de frames pode funcionar muito bem quando as poses são fortes e o objetivo é preservar **unicidade, clareza e impacto**. Isso reforça que nosso problema não é simplesmente "ter poucos frames", mas a função e a leitura de cada frame.

Referência: https://www.gdcvault.com/play/1027125/Animation-Summit-Animating-a-Complex

### TMNT: Shredder's Revenge
A equipe descreveu a decisão de tornar golpes mais generosos em alinhamento para diminuir frustração, além de tratar combo e pacing como partes centrais do beat'em up moderno. Isso sustenta hitboxes/lane forgiveness maiores que a silhueta puramente visual, desde que continuem previsíveis.

Referência: https://www.gamedeveloper.com/design/deep-dive-how-tmnt-s-shredder-s-revenge-was-built-from-nostalgia-and-new-ideas

### Combat impact / hit pause
Artigos e talks de action games usam repetidamente hit pause/hit stop, reação do alvo, VFX e câmera como camadas adicionais ao movimento base. O princípio importante é: **animação precisa funcionar primeiro; efeitos reforçam, não consertam uma animação fraca**.

Referências:
- https://www.gamedeveloper.com/audio/improving-the-combat-impact-of-action-games
- https://www.gamedeveloper.com/programming/the-role-of-animations-in-hit-effects

### Fases de ataque
Jogos de luta e action games normalmente tratam golpes por fases distintas: **startup → active → recovery**. A lógica do gameplay não deve depender diretamente do número da imagem do sprite; o timing deve ser declarado em dados e a animação deve representar esse contrato.

Referência histórica/técnica: https://media.gdcvault.com/GD_Mag_Archives/GDM_September_2012.pdf

### Readability e limited animation
Lethal League Blaze adotou poses escolhidas manualmente em vez de animação totalmente fluida para melhorar leitura e estilo. Para nosso pixel art isso favorece key poses fortes, sem interpolação que "derreta" o sprite.

Referência: https://www.gamedeveloper.com/design/developing-the-stylish-indie-hit-fighting-game-i-lethal-league-blaze-i-

---

## 3. Princípios obrigatórios de implementação

1. **Não monolítico.** Movimento, combate, apresentação visual, VFX, hit reactions e debug permanecem componentes separados.
2. **Data-driven.** Startup, active, recovery, dano, alcance, avanço, hitstop, knockback e cancel windows pertencem a um `AttackProfile`/Resource ou estrutura de dados equivalente. Não espalhar números mágicos por scripts.
3. **Sprite não é regra de gameplay.** O frame visual acompanha o estado de combate; hitbox não nasce de "frame 2 = dano" hardcoded.
4. **BODY / WEAPON / VFX separados quando necessário.** O arco do ataque forte não pode ser incorporado permanentemente à arte base do personagem.
5. **Master de arma travado.** `DUROTAR_SWORD_V1` preserva comprimento, largura, guarda e identidade. Pose/rotação/foreshortening podem mudar; redesign silencioso não.
6. **Nearest-neighbor / pixel fidelity.** Nada de suavização ou interpolação visual destrutiva.
7. **Fail-closed no pipeline.** Asset corrompido ou ausente falha CI; a build não deve ser considerada verde apenas porque a cena abriu.
8. **Testar em runtime.** Aprovação de animação só ocorre dentro do jogo em 640×360, não apenas olhando sprite sheet.

---

## 4. Definição da Vertical Slice de Combate

A vertical slice será considerada pronta quando uma pessoa puder abrir a arena de teste e concluir, sem contexto técnico, que:

- Durotar está vivo em Idle;
- caminhar parece deslocamento intencional, não slide;
- ataque fraco é rápido, responsivo e pode formar um combo curto;
- ataque forte é mais comprometido e claramente mais pesado;
- defesa é imediatamente reconhecível;
- acertar o alvo produz impacto físico e audiovisual;
- errar um golpe tem leitura diferente de acertá-lo;
- a espada mantém a mesma identidade em todos os estados;
- o personagem permanece legível sobre o cenário;
- a lógica de combate continua modular e reutilizável para o segundo personagem.

---

# 5. Roadmap de implementação

## Fase 0 — Estabilizar pipeline e QA técnico — P0

Objetivo: nunca mais perder tempo testando uma build onde a arte não carregou corretamente.

### Entregas
- CI deve importar projeto com Godot 4.7.2.
- CI deve chamar `ResourceLoader.load()` em todo asset runtime obrigatório.
- Validar dimensões esperadas dos sprites.
- Falhar em PNG/WebP corrompido.
- Launcher local deve importar assets antes de abrir o jogo.
- Adicionar `.gitignore` para `.godot/`, `*.uid` gerados e executáveis locais do Godot.
- Não commitar cache de importação.

### BDD
**Given** um sprite obrigatório corrompido  
**When** CI processar a build  
**Then** pipeline deve falhar antes de marcar a build como testável.

**Given** um clone limpo  
**When** o launcher for executado  
**Then** assets devem ser importados antes da cena principal abrir.

### DoD
- clone limpo + launcher = personagem e cenário visíveis;
- CI vermelho para asset inválido;
- CI verde apenas com todos os assets carregáveis.

---

## Fase 1 — Contrato visual do Durotar e espada — P0

Objetivo: impedir variação de identidade durante animações.

### Entregas
- criar `DUROTAR_SWORD_V1` como referência visual explícita;
- medir comprimento e largura aparentes da espada em Idle;
- revisar Light/Heavy/Block contra o master;
- remover qualquer frame onde a espada pareça outra arma;
- documentar exceções permitidas por foreshortening;
- BODY, WEAPON e VFX devem poder ser tratados separadamente em ataques futuros.

### Critérios de aceite
- nenhuma animação muda a guarda/design da arma;
- comprimento aparente só varia por perspectiva plausível;
- arco/energia nunca substitui visualmente a espada;
- silhueta do Durotar continua reconhecível em cada key pose.

### BDD
**Given** qualquer frame de ataque  
**When** comparado ao `DUROTAR_SWORD_V1`  
**Then** arma deve preservar identidade, proporção-base e design.

---

## Fase 2 — Locomoção: Idle + Walk + baseline — P0

Objetivo: eliminar sensação de sprite deslizando.

### Idle
- respirar com amplitude mínima;
- micro movimento de ombro/tronco/espada;
- pés não deslizam;
- evitar "bobbing" excessivo.

### Walk
- 4 frames podem permanecer se as poses forem fortes;
- explicitar `contact → passing → contact → passing` ou equivalente estilizado;
- pé plantado não pode deslizar para trás na tela;
- calibrar `movement_speed` com FPS da animação;
- reduzir sobe/desce exagerado do tronco.

### Engenharia
- baseline/pivot único por archetype;
- se um frame exigir correção, offset deve vir de metadata, não `if frame == X` espalhado em código;
- sombra de contato é runtime separada do sprite.

### Critérios de aceite
- vídeo em câmera lenta não mostra pé plantado escorregando;
- troca Idle ↔ Walk não desloca o personagem verticalmente;
- direção esquerda é mirror correto da direita;
- velocidade visual e velocidade lógica parecem compatíveis.

---

## Fase 3 — Arquitetura de ataque data-driven — P0

Objetivo: sair de `duration + hit_at` simplificado para um contrato reutilizável de action game.

### Criar `AttackProfile`
Campos mínimos:

- `id`
- `startup_ms`
- `active_ms`
- `recovery_ms`
- `damage`
- `hitbox`
- `lane_tolerance`
- `forward_motion_px`
- `knockback_px`
- `hitstop_attacker_ms`
- `hitstop_target_ms`
- `cancel_from_ms`
- `cancel_to[]`
- `vfx_id`
- `sfx_id`
- `camera_impulse_id`

### Estados
`READY → STARTUP → ACTIVE → RECOVERY → READY`

Ataque não pode registrar novo hit fora de ACTIVE.

### Input buffer
Adicionar pequeno buffer de input para não exigir precisão de 1 frame. Valor inicial de tuning: **80–140 ms**.

### Critérios de aceite
- gameplay não depende de `frame_cursor == N` para dano;
- timings podem ser alterados sem editar `player_combat.gd`;
- debug overlay consegue mostrar startup/active/recovery;
- segundo personagem pode reutilizar o sistema trocando dados.

---

## Fase 4 — Light Combo real — P0

Objetivo: transformar o atual golpe fraco em combo comercialmente legível.

### Design inicial
`Light 1 → Light 2 → Light 3 / Finisher`

Cada golpe possui:
- startup curto;
- active curto;
- recovery;
- janela de encadeamento;
- avanço pequeno;
- reação crescente no alvo.

### Tuning inicial para playtest
Não é contrato final; apenas ponto de partida:

| Golpe | Startup | Active | Recovery | Avanço | Hitstop |
|---|---:|---:|---:|---:|---:|
| Light 1 | 80–110 ms | 50–80 ms | 120–170 ms | 6–8 px | 45–60 ms |
| Light 2 | 90–120 ms | 50–80 ms | 130–180 ms | 7–10 px | 50–65 ms |
| Light 3 | 110–150 ms | 60–90 ms | 220–300 ms | 10–14 px | 65–85 ms |

### Critérios de aceite
- input antecipado na janela válida encadeia o próximo golpe;
- mash fora da janela não quebra estado;
- combo inteiro não parece três cópias da mesma pose;
- finisher tem silhueta e impacto claramente maiores;
- errar golpe não produz hitstop nem hit VFX.

---

## Fase 5 — Heavy Attack + VFX separado — P0

Objetivo: ataque pesado com compromisso e impacto, sem destruir a leitura da arma/personagem.

### Entregas
- separar arco branco atual do sprite base;
- VFX como `Sprite2D`/AnimatedSprite/VFX component independente;
- VFX nasce apenas na fase ativa/impacto;
- espada real continua visível;
- ataque ganha pequeno avanço próprio;
- recovery maior que Light;
- hitstop e knockback maiores;
- camera impulse sutil, não shake contínuo.

### Tuning inicial
- startup: 180–260 ms;
- active: 70–110 ms;
- recovery: 300–450 ms;
- forward motion: 10–18 px;
- hitstop: 90–130 ms;
- knockback maior que Light finisher.

### Critérios de aceite
- sem VFX, a animação ainda parece forte;
- VFX não esconde corpo, espada nem alvo por tempo excessivo;
- acertar e errar têm sensação distinta;
- Heavy é mais arriscado/comprometido que Light.

---

## Fase 6 — Hit feedback / game feel — P1

Objetivo: fazer contato parecer contato, não simples redução de HP.

### Camadas, nesta ordem
1. pose do atacante;
2. reação do alvo;
3. hitstop;
4. knockback/deslocamento;
5. flash/material hit;
6. VFX;
7. SFX hook;
8. camera impulse seletivo.

### Reação do alvo
- Light normal: pequeno recoil;
- Light finisher: recoil maior;
- Heavy: reação distinta + knockback;
- KO: estado separado.

### Regras
- camera shake apenas em eventos de maior peso;
- evitar shake em todos os Light hits;
- hitstop não congela HUD;
- futuro multiplayer/local coop deve considerar quais nós pausam.

### Critérios de aceite
- jogador identifica visualmente hit vs whiff sem olhar HP;
- Heavy é percebido como mais pesado mesmo sem número de dano;
- múltiplos efeitos não escondem pose principal.

---

## Fase 7 — Defesa legível — P1

Objetivo: defesa precisa parecer defesa em um frame congelado.

### Entregas
- postura com espada entre Durotar e ameaça;
- pés plantados;
- tronco levemente recuado;
- `block_enter`, `block_hold`, `block_hit` separados;
- terceiro frame atual reservado preferencialmente para impacto, se visualmente adequado;
- reação de bloqueio recebe pequeno hitstop/impulso sem dano cheio.

### Critérios de aceite
- screenshot isolado de `block_hold` é reconhecido como defesa;
- manter L não reinicia animação todo frame;
- receber golpe bloqueando não usa animação de Hurt comum.

---

## Fase 8 — Hitbox, hurtbox e lane forgiveness — P1

Objetivo: combate justo, fácil de ler e menos frustrante, seguindo convenções modernas de brawlers.

### Entregas
- hurtbox não precisa copiar pixel-perfect a silhueta;
- hitbox por golpe independente do sprite;
- tolerância vertical/lane declarada por ataque;
- debug overlay `F2` mostra hitbox, hurtbox, facing e alcance;
- nenhuma hitbox continua ativa durante recovery.

### Direção de design
Para beat'em up, priorizar **intenção do jogador** sobre colisão visual excessivamente rígida. A tolerância pode ser mais generosa do que em um fighting game competitivo, desde que consistente e previsível.

### Critérios de aceite
- golpes visualmente próximos não erram por poucos pixels de lane;
- golpes claramente fora de alcance não acertam;
- debug overlay coincide com comportamento observado.

---

## Fase 9 — Apresentação da arena — P2

Objetivo: cenário sustenta o combate e não compete com o personagem.

### Entregas
- reduzir contraste/saturação do chão se competir com Durotar;
- sombra de contato runtime;
- preservar `BACKWALL` e `GROUND` separados;
- HUD de debug ocultável em `F1`;
- target dummy com 500–1000 HP ou reset automático;
- opcional: parallax/midground somente depois de gameplay aprovado.

### Critérios de aceite
- Durotar é o primeiro foco visual;
- personagem parece apoiado no chão;
- HUD não bloqueia leitura da arena;
- teste de 30–60 s não termina porque o dummy morreu cedo.

---

## Fase 10 — QA de vertical slice e gate para expansão — P0 antes de escalar conteúdo

Objetivo: impedir produção de inimigos/personagens em cima de um core instável.

### Checklist obrigatório
- 60 s de Idle/Walk sem jitter de baseline;
- 20 execuções de Light combo sem estado travado;
- 20 Heavy hits + 20 Heavy whiffs;
- bloquear por 10 s sem restart de animação;
- virar para esquerda/direita em todos os estados permitidos;
- acertar alvo no limite de alcance;
- acertar com diferença de lane próxima ao limite;
- asset pipeline verde;
- gravação de gameplay em resolução final de teste;
- revisão quadro a quadro de arma, pé, silhouette e VFX.

### Gate GO / NO-GO
Só avançar para inimigo real, segunda personagem ou geração de fase quando:

- P0 concluído;
- nenhum bug blocker/critical no core;
- identidade do Durotar aprovada;
- Light e Heavy claramente diferentes;
- hit vs whiff claramente diferentes;
- combate permanece modular e data-driven.

---

# 6. Ordem recomendada de execução

`Pipeline → Sword Contract → Idle/Walk → AttackProfile → Light Combo → Heavy/VFX → Hit Feedback → Defense → Hitboxes/Lane → Arena Polish → QA Gate`

Essa ordem é deliberada: **não polir efeitos antes de corrigir pose/timing**, e não escalar conteúdo antes de estabilizar o sistema reutilizável.

---

# 7. Estrutura técnica alvo

```text
scripts/
  combat/
    attack_profile.gd
    attack_runner.gd
    hitbox_controller.gd
    hitstop_controller.gd
    combat_events.gd
  player/
    player_controller.gd
    player_combat.gd
    player_visual.gd
  presentation/
    combat_vfx.gd
    camera_impulse.gd
    contact_shadow.gd
  debug/
    combat_debug_overlay.gd

resources/
  combat/
    durotar_light_1.tres
    durotar_light_2.tres
    durotar_light_3.tres
    durotar_heavy_1.tres

assets/
  characters/durotar/
    body/
    weapon/
    vfx/
```

Nomes finais podem variar, mas a separação de responsabilidades é obrigatória.

---

# 8. Métricas de playtest

Além de opinião visual, registrar em cada rodada:

| Métrica | Objetivo |
|---|---|
| Input → início visual do Light | parecer imediato |
| Whiff vs Hit | distinguível sem HUD |
| Light vs Heavy | distinguível por timing/peso |
| Erro de baseline | não perceptível em velocidade normal |
| Falha de combo por input válido | 0 |
| Asset obrigatório que falha silenciosamente | 0 |
| Estado de combate travado | 0 |
| Arma muda de identidade | 0 |

Os números exatos de frame/timing são tuning de gameplay e só viram contrato após playtest.

---

# 9. Definition of Done geral

Uma tarefa de combat polish só está Done quando:

- implementação funciona no runtime;
- possui critério de aceite verificável;
- não introduz hardcode específico desnecessário;
- não quebra Master de arte;
- passou no Godot 4.7.2;
- CI verde;
- foi revisada em gameplay, não somente no editor;
- quando visual, foi comparada com captura de antes/depois.

---

# 10. Fora de escopo até o Gate GO

- hub;
- loja;
- loot/progressão roguelite;
- geração de fases;
- segundo personagem jogável;
- inimigos finais;
- boss;
- conteúdo massivo de cenário;
- efeitos cinematográficos pesados.

Esses sistemas não devem competir por prioridade enquanto a vertical slice de combate ainda estiver em P0/P1.
