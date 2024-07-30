import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/services/firebase_service.dart';
import 'package:fluter_crud/data/dummy_user.dart';
import 'package:fluter_crud/views/battle_result_screen.dart';

class Users with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<User> _items = DUMMY_USERS.values.toList();

  List<User> get items {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items[i];
  }

  Future<void> loadUsers() async {
    _items = await _firebaseService.fetchUsers();
    notifyListeners();
  }

  Future<void> put(User user, bool isNewUser) async {
    if (isNewUser) {
      await _firebaseService.saveUser(user);
    } else {
      await _firebaseService.updateUser(user);
    }
    await loadUsers();
  }

  Future<void> remove(User user) async {
    await _firebaseService.deleteUser(user.id);
    _items.remove(user);
    notifyListeners();
  }

  void startBattle(BuildContext context, User firstUser) {
    if (_items.length < 2) {
      return; // Não há usuários suficientes para iniciar uma batalha
    }

    Random random = Random();
    User opponent;
    do {
      int randomIndex = random.nextInt(_items.length);
      opponent = _items[randomIndex];
    } while (opponent == firstUser);

    // Lógica de combate
    bool firstUserWins = false;
    int damageMultiplier = 1;
    String battleReason = '';

    if ((firstUser.classType == ClassType.Warrior && opponent.classType == ClassType.Archer) ||
        (firstUser.classType == ClassType.Archer && opponent.classType == ClassType.Mage) ||
        (firstUser.classType == ClassType.Mage && opponent.classType == ClassType.Warrior)) {
      firstUserWins = true;
      damageMultiplier = 2; // Dano dobrado
      battleReason = 'Classe contra (Dano dobrado)';
    } else if ((opponent.classType == ClassType.Warrior && firstUser.classType == ClassType.Archer) ||
               (opponent.classType == ClassType.Archer && firstUser.classType == ClassType.Mage) ||
               (opponent.classType == ClassType.Mage && firstUser.classType == ClassType.Warrior)) {
      firstUserWins = false;
      damageMultiplier = 2; // Dano dobrado
      battleReason = 'Classe contra (Dano dobrado)';
    } else {
      if (firstUser.health + firstUser.power > opponent.health + opponent.power) {
        firstUserWins = true;
        battleReason = 'Vida e força superiores';
      } else {
        firstUserWins = false;
        battleReason = 'Vida e força inferiores';
      }
    }

    if (firstUserWins) {
      firstUser.health += 20 * damageMultiplier;
      firstUser.power += 20 * damageMultiplier;
      _showBattleResult(context, firstUser, opponent, true, battleReason);
      remove(opponent); // Remove o oponente derrotado
    } else {
      opponent.health += 20 * damageMultiplier;
      opponent.power += 20 * damageMultiplier;
      _showBattleResult(context, firstUser, opponent, false, battleReason);
      remove(firstUser); // Remove o usuário que perdeu
    }

    notifyListeners();
  }

  void _showBattleResult(BuildContext context, User winner, User loser, bool userWon, String battleReason) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => BattleResultScreen(
          firstUser: winner,
          opponent: loser,
          userWon: userWon,
          battleReason: battleReason, // Pass battle reason
        ),
      ),
    );
  }
}
