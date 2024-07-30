// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fluter_crud/models/user.dart';

class BattleResultScreen extends StatelessWidget {
  final User firstUser;
  final User opponent;
  final bool userWon;
  final String battleReason;

  const BattleResultScreen({
    required this.firstUser,
    required this.opponent,
    required this.userWon,
    required this.battleReason,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Batalha'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.black87, // Fundo mais escuro para contraste
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userWon ? 'Vitória' : 'Derrota',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: userWon ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPlayerInfo(firstUser, userWon),
                  const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  _buildPlayerInfo(opponent, !userWon),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Motivo: $battleReason',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(User user, bool isWinner) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.avatarUrl),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: isWinner ? Colors.green : Colors.red,
              width: 4,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Vida: ${user.health}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Força: ${user.power}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Classe: ${user.classType.toString().split('.').last}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
