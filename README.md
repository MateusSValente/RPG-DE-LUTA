# RPG-DE-LUTA — Demo jogável de validação do Durotar

Esta build existe para testar o `DUROTAR_MASTER_V1` em gameplay antes de avançar a produção do jogo.

## Abrir

1. Clone/atualize o repositório.
2. Abra `project.godot` no Godot 4.
3. Pressione **Play/F6/F5**.

## Controles

- `A` / `D`: mover
- `J`: combo fraco
- `K`: combo forte
- `L`: defesa (segurar)
- `R`: restaurar o boneco de treino

## O que validar

- escala do Durotar no cenário;
- leitura de Idle e Walk;
- estabilidade da baseline durante Walk;
- diferenciação visual entre ataque fraco e forte;
- leitura/tamanho da espada;
- silhueta em movimento;
- Defesa;
- aparência do Master na resolução lógica `640×360`.

## Arquitetura da cena

O cenário segue a separação obrigatória definida na Art Spec:

- `ForestBackwall`: somente plano traseiro;
- `ForestGround`: somente terreno/plano jogável.

Nesta build ambos são assets de teste determinísticos, implementados separadamente. Eles não contêm HUD, personagem ou lógica de combate.

O Durotar é renderizado diretamente a partir de:

`docs/art/reference/durotar/DUROTAR_MASTER_V1_REFERENCE.webp`

As regiões da prancha são recortadas em runtime e alinhadas por anchor fixo. O fundo quase-preto da prancha é removido por shader apenas durante o teste. Se o personagem for aprovado jogando, o próximo passo é exportar os frames definitivos RGBA/128×128 derivados do Master.

## Escopo deliberadamente fora desta demo

- Hub;
- roguelite/progressão;
- loja;
- loot;
- inimigos reais;
- geração de fases;
- segundo personagem.

Esses sistemas só entram depois da aprovação do núcleo visual e do feel básico do Durotar.
