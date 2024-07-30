import 'package:firebase_database/firebase_database.dart';
import 'package:fluter_crud/models/user.dart';

class FirebaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  List<User>? _cachedUsers;

  Future<User> signup({
    required String name,
    required String email,
    required int health,
    required int power,
    required ClassType classType,
    required String avatarUrl,
  }) async {
    try {
      final ref = _firebaseDatabase.ref().child('users').push();
      await ref.set({
        'name': name,
        'email': email,
        'health': health,
        'power': power,
        'classType': classType.toString(),
        'avatarUrl': avatarUrl.isEmpty ? 'https://via.placeholder.com/150' : avatarUrl,
      });

      return User(
        id: ref.key ?? '',
        name: name,
        email: email,
        health: health,
        power: power,
        classType: classType,
        avatarUrl: avatarUrl.isEmpty ? 'https://via.placeholder.com/150' : avatarUrl,
      );
    } catch (error) {
      throw Exception('Failed to sign up user: $error');
    }
  }

  Future<User> saveUser(User newUser) async {
    final savedUser = await signup(
      name: newUser.name,
      email: newUser.email,
      health: newUser.health,
      power: newUser.power,
      classType: newUser.classType,
      avatarUrl: newUser.avatarUrl,
    );
    _cachedUsers = null;
    return savedUser;
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      await _firebaseDatabase.ref().child('users/${updatedUser.id}').update({
        'name': updatedUser.name,
        'email': updatedUser.email,
        'health': updatedUser.health,
        'power': updatedUser.power,
        'classType': updatedUser.classType.toString(),
        'avatarUrl': updatedUser.avatarUrl.isEmpty ? 'https://via.placeholder.com/150' : updatedUser.avatarUrl,
      });
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firebaseDatabase.ref().child('users/$userId').remove();
    } catch (error) {
      throw Exception('Failed to delete user: $error');
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      final snapshot = await _firebaseDatabase.ref().child('users').get();
      if (snapshot.exists) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        _cachedUsers = data.entries.map((entry) {
          return User(
            id: entry.key,
            name: entry.value['name'],
            email: entry.value['email'],
            health: entry.value['health'],
            power: entry.value['power'],
            classType: ClassType.values.firstWhere((e) => e.toString() == entry.value['classType']),
            avatarUrl: entry.value['avatarUrl'] ?? '',
          );
        }).toList();
        return _cachedUsers!;
      }
      return [];
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }
}
