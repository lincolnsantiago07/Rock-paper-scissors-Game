# 🧙‍♂️ Dungeon Fighter 🏹

## 📜 Descrição

Este projeto é um jogo baseado no clássico "Pedra, Papel, Tesoura", mas com uma temática medieval, onde os jogadores escolhem entre Mago, Arqueiro e Guerreiro. Cada personagem tem suas próprias características e habilidades:

- **Mago** derrota **Guerreiro**
- **Guerreiro** derrota **Arqueiro**
- **Arqueiro** derrota **Mago**

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

1. **Escolha de Personagem**: Os jogadores escolhem um dos três personagens: Mago, Arqueiro ou Guerreiro.
2. **Sistema de Batalha**: Com base nas regras definidas, o sistema determina o vencedor da rodada. Cada personagem tem um atributo de "vida" e "dano".
3. **Persistência de Dados**: As informações dos jogadores e seus status são armazenados no Firebase, permitindo que o progresso seja salvo e recuperado.

## 🗃️ Estrutura do Banco de Dados Firebase

O banco de dados é estruturado da seguinte forma:

- **personagens**: 
  - **id**: Identificador único do personagem.
  - **e-mail**: E-mail do personagem. 
  - **nome**: Nome do personagem (Mago, Arqueiro, Guerreiro).
  - **vida**: Pontos de vida do personagem.
  - **dano**: Dano que o personagem pode causar.
