// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:fluter_crud/models/user.dart';

class BattleScreen extends StatelessWidget {
  final User firstUser;
  final User opponent;
  final bool userWon;
  final String battleReason; // Add this field

  // ignore: use_key_in_widget_constructors
  BattleScreen({
    required this.firstUser,
    required this.opponent,
    required this.userWon,
    required this.battleReason, // Add this field
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batalha'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
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
            _buildPlayerInfo(context, firstUser, userWon),
            const SizedBox(height: 20),
            const Text(
              'VS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPlayerInfo(context, opponent, !userWon),
            const SizedBox(height: 20),
            Text(
              'Motivo: $battleReason',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(BuildContext context, User user, bool isWinner) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
              radius: 50,
              backgroundColor: Colors.transparent,
              child: !isWinner
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                      child: Image.network(user.avatarUrl),
                    )
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isWinner ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Vida: ${user.health}',
              style: TextStyle(
                color: isWinner ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Força: ${user.power}',
              style: TextStyle(
                color: isWinner ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Classe: ${user.classType.toString().split('.').last}',
              style: TextStyle(
                color: isWinner ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
