// ignore: constant_identifier_names
enum ClassType { Warrior, Archer, Mage }

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  int health;
  int power;
  ClassType classType;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.health,
    required this.power,
    required this.classType,
  });
}
