# 🧙‍♂️ Dungeon Fighter 🏹

## 🎮 Como jogar?

- Você pode acessar meu projeto através desse link: https://66a9546610de999bdf664b95--stalwart-pie-1c3756.netlify.app

## 📜 Descrição

Este projeto é um jogo **single player** baseado no clássico "Pedra, Papel e Tesoura", mas com uma temática medieval, onde os jogadores escolhem entre Mago, Arqueiro e Guerreiro através de um formulário.

**Disclaimer:** Este projeto não tem como finalidade ter uma HUD ou UI/UX, muito menos um sistema de filtragem ou autenticação. O intuito é apenas para demonstração de funcionalidades e tecnologias atreladas ao flutter/dart.

O banco de dados está disponível e compartilhado para todos, sem nenhuma autenticação prévia, todos os jogadores irão compartilhar e administrar o sistema CRUD do jogo.
Cada personagem tem suas próprias características e habilidades:

- 🧙‍♂️ **Mago** ⚔️ **Guerreiro** 🪖
- 🪖 **Guerreiro** ⚔️ **Arqueiro** 🏹
- 🏹 **Arqueiro** ⚔️ **Mago** 🧙‍♂️

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento de interfaces de usuário para aplicações móveis, web e desktop.
- **Firebase**: Plataforma de desenvolvimento de aplicativos que inclui banco de dados em tempo real, autenticação e armazenamento em nuvem.

## 🎮 Funcionalidades

### 📝 CRUD de Personagens

- **Create**: Adição de novos personagens ao banco de dados.
- **Read**: Leitura de personagens existentes, incluindo seus status de vida e dano.
- **Update**: Atualização de informações dos personagens, como pontos de vida e dano.
- **Delete**: Remoção de personagens do banco de dados.

### ⚔️ Mecânica de Jogo

1. **Escolha de Personagem**: O jogador escolhe um dos três personagens: Mago, Arqueiro ou Guerreiro.
2. **Sistema de Batalha**: Com base nas regras definidas, o sistema determina o vencedor da rodada. Cada personagem tem um atributo de "vida" e "dano", sendo o combate gerado randomicamente.
3. **Persistência de Dados**: As informações dos jogadores e seus status são armazenados no Firebase, permitindo que o progresso seja salvo e recuperado.

## 🗃️ Estrutura do Banco de Dados Firebase

O banco de dados é estruturado da seguinte forma:

- **personagens**: 
  - **id**: Identificador único do personagem.
  - **e-mail**: E-mail do personagem. (não relevante, apenas para teste).
  - **nome**: Nome do personagem (Mago, Arqueiro, Guerreiro).
  - **vida**: Pontos de vida do personagem.
  - **dano**: Dano que o personagem pode causar.
