import 'package:flutter/material.dart';
import 'user_list.dart'; // Importe o arquivo da lista de usuários

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dungeon Fighter',
              style: TextStyle(
                //fontFamily: 'MedievalSharp',
                fontSize: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.sports_mma, color: Colors.white),
              label: const Text(
                'Jogar',
                style: TextStyle(
                  //fontFamily: 'MedievalSharp',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}