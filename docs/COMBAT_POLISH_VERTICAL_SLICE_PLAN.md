# RPG-DE-LUTA — Combat Polish / Vertical Slice Plan

Status: **PLANNED / EXECUTION STARTED**  
Owner: projeto RPG-DE-LUTA  
Escopo atual: **Durotar + arena de teste + boneco/alvo de treino**  
Objetivo: transformar a demo atual em uma **vertical slice de combate com padrão comercial**, antes de ampliar conteúdo, inimigos, hub ou segundo personagem.

---

## 1. Decisão de produção

O teste jogável validou a identidade do Durotar, mas mostrou que a prancha protótipo não deve ser tratada como spritesheet final. A partir daqui, a produção segue contratos versionados por animação.

### Contagem alvo de desenhos autorais

| Animação | Meta |
|---|---:|
| Idle | 6 |
| Walk | 8 |
| Light 1 | 6 |
| Light 2 | 6 |
| Light 3 / Finisher | 8 |
| Heavy | 10 |
| Block Enter | 3 |
| Block Hold | 1–2 |
| Block Hit | 4 |
| Hurt Light | 4 |
| Hurt Heavy | 6 |
| Knockdown | 8 |
| Get Up | 8 |

Gameplay permanece em **60 Hz**, mas cada desenho pode ter hold próprio. A animação não será controlada somente por um `FPS` fixo.

Contratos ativos:

- `docs/art/reference/durotar/DUROTAR_SWORD_V1_SPEC.md`
- `docs/art/animation/durotar/DUROTAR_ANIMATION_PRODUCTION_STANDARD_V1.md`
- `docs/art/animation/durotar/WALK_V2_SPEC.md`

**Regra de gate:** nenhuma nova animação do Durotar entra em produção sem `ANIMATION_SPEC` versionada.

---

## 2. Princípios obrigatórios

1. arquitetura modular, não monolítica;
2. combate data-driven;
3. startup / active / recovery separados;
4. sprite visual não define sozinho a regra de dano;
5. BODY / WEAPON / VFX separáveis quando necessário;
6. `DUROTAR_SWORD_V1` travado;
7. nearest-neighbor / pixel fidelity;
8. pipeline fail-closed;
9. aprovação obrigatória em runtime 640×360;
10. key poses primeiro, in-betweens depois;
11. animação `LOCKED` não é alterada silenciosamente — cria-se nova versão.

---

# 3. Roadmap operacional

## Fase 0 — Pipeline / QA técnico — P0

- CI importa no Godot 4.7.2;
- CI carrega assets obrigatórios;
- dimensões esperadas validadas;
- PNG/WebP corrompido falha build;
- launcher importa assets antes de abrir;
- cache `.godot/` não faz parte da fonte de verdade.

**Gate:** clone limpo + launcher precisa exibir personagem e cenário sem ação manual.

---

## Fase 1 — Contrato visual Durotar + espada — P0

Status: **CONTRATO CRIADO**.

`DUROTAR_SWORD_V1_SPEC.md` fixa:

- espada broad/straight;
- guarda, grip e pommel invariantes;
- side-profile de referência medido em aproximadamente 268×60 px dentro da prancha master;
- proporção hilt→guard ≈20% e guard→tip ≈80% do comprimento total;
- side-on com tolerância de comprimento ±3%, espessura ±5% e hilt/blade ratio ±5%;
- foreshortening permitido somente quando plausível;
- VFX nunca substitui a espada física.

**DoD:** todos os novos frames passam pelo checklist do Weapon Master.

---

## Fase 2 — WALK_V2 — P0

Status: **SPEC APROVADA PARA KEYPOSE PRODUCTION**.

### Estrutura

`CONTACT_L → DOWN_L → PASSING_L → UP_L → CONTACT_R → DOWN_R → PASSING_R → UP_R`

### Timing inicial @60 Hz

`4,3,4,3,4,3,4,3` ticks.

- ciclo: 28 ticks = 466.7 ms;
- velocidade inicial de playtest: 120 px/s;
- deslocamento aproximado por ciclo: 56 px;
- bob vertical máximo: 3 px peak-to-peak;
- baseline: Y=116;
- pivot lógico: 64,116.

### Gate de arte

Primeiro produzir somente:

- F01 CONTACT_L;
- F03 PASSING_L;
- F05 CONTACT_R;
- F07 PASSING_R.

F02/F04/F06/F08 ficam bloqueados até as quatro key poses passarem por revisão de identidade, pés, baseline e espada.

Especificação completa: `docs/art/animation/durotar/WALK_V2_SPEC.md`.

### DoD

- 30 s andando esquerda/direita sem jitter;
- foot slide não perceptível em 0.5×;
- Idle↔Walk sem salto vertical;
- espada mantém identidade;
- F08→F01 sem pop.

---

## Fase 3 — IDLE_V2 — P0

Só começa depois de WALK_V2 LOCKED.

Meta:

- 6 desenhos;
- respiração mínima;
- micro movimento de ombro/tronco/espada;
- pés 100% estáveis;
- sem bobbing exagerado.

Antes de gerar arte será criado `IDLE_V2_SPEC.md`.

---

## Fase 4 — AttackProfile data-driven — P0

Criar contrato reutilizável com:

- `id`;
- `startup_ms`;
- `active_ms`;
- `recovery_ms`;
- `damage`;
- `hitbox`;
- `lane_tolerance`;
- `forward_motion_px`;
- `knockback_px`;
- `hitstop_attacker_ms`;
- `hitstop_target_ms`;
- `cancel_from_ms`;
- `cancel_to[]`;
- `vfx_id`;
- `sfx_id`;
- `camera_impulse_id`.

Estados:

`READY → STARTUP → ACTIVE → RECOVERY → READY`

Input buffer inicial para tuning: **80–140 ms**.

---

## Fase 5 — Light Combo — P0

Design:

`Light 1 (6) → Light 2 (6) → Light 3 / Finisher (8)`

Tuning inicial:

| Golpe | Startup | Active | Recovery | Avanço | Hitstop |
|---|---:|---:|---:|---:|---:|
| Light 1 | 80–110 ms | 50–80 ms | 120–170 ms | 6–8 px | 45–60 ms |
| Light 2 | 90–120 ms | 50–80 ms | 130–180 ms | 7–10 px | 50–65 ms |
| Light 3 | 110–150 ms | 60–90 ms | 220–300 ms | 10–14 px | 65–85 ms |

Cada golpe exige `ANIMATION_SPEC` própria antes de gerar arte.

---

## Fase 6 — Heavy — P0

Meta: **10 desenhos**.

- antecipação clara;
- aceleração legível;
- impacto forte;
- follow-through;
- recovery comprometido;
- VFX separado do BODY/WEAPON;
- espada física sempre visível.

Tuning inicial:

- startup 180–260 ms;
- active 70–110 ms;
- recovery 300–450 ms;
- avanço 10–18 px;
- hitstop 90–130 ms.

---

## Fase 7 — Hit feedback — P1

Ordem de implementação:

1. reação do alvo;
2. hitstop;
3. knockback;
4. flash/material hit;
5. VFX;
6. SFX hook;
7. camera impulse seletivo.

Hit e whiff devem ser distinguíveis sem olhar HP.

---

## Fase 8 — Defesa — P1

Produção alvo:

- Block Enter: 3 desenhos;
- Block Hold: 1–2 desenhos;
- Block Hit: 4 desenhos.

Screenshot isolado de `block_hold` precisa parecer defesa imediatamente.

---

## Fase 9 — Hitbox / hurtbox / lane forgiveness — P1

- hurtbox independente da silhueta exata;
- hitbox própria por golpe;
- `lane_tolerance` em dados;
- debug F2 para hitbox, hurtbox, facing, alcance e fase do golpe;
- nenhuma hitbox ativa em recovery.

---

## Fase 10 — Arena / HUD / dummy — P2

- contraste do chão abaixo do personagem;
- sombra de contato runtime separada;
- HUD debug em F1;
- dummy 500–1000 HP ou reset automático;
- parallax somente depois do core aprovado.

---

## Fase 11 — QA / GO-NO-GO — P0 GATE

Suite mínima:

- 60 s Idle/Walk sem jitter;
- 20 Light combos sem estado travado;
- 20 Heavy hits + 20 Heavy whiffs;
- defesa mantida por 10 s sem restart;
- esquerda/direita em todos os estados;
- teste de alcance e lane tolerance;
- asset CI verde;
- captura 640×360;
- revisão quadro a quadro de arma, pés, silhueta e VFX.

GO somente se:

- todos os P0 concluídos;
- nenhum blocker/critical;
- identidade do Durotar aprovada;
- Light e Heavy claramente diferentes;
- hit e whiff claramente diferentes;
- arquitetura continua modular/data-driven.

---

# 4. Próxima ação autorizada

A próxima produção de arte é **somente WALK_V2 key poses F01/F03/F05/F07**.

Não gerar uma nova folha completa. Não gerar in-betweens antes da revisão das quatro poses principais.
