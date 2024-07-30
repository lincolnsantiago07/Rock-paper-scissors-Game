import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/provider/users.dart';
import 'package:fluter_crud/routes/app_routes.dart';



//HUD - Head Up Display

// ignore: use_key_in_widget_constructors
class UserList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // ignore_for_file: constant_identifier_names
    const Color TextColor = Color.fromARGB(255, 229, 232, 244);
    const Color BackgroundColor = Color.fromARGB(255, 10, 14, 25);
    const Color Secondary = Color.fromARGB(255, 71, 51, 120);
    const Color AddButton = Color.fromARGB(255, 117, 180, 87);
    const Color FightButton = Color.fromARGB(255, 228, 48, 63);

    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        title: const Text('Lista de jogadores'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: TextColor, fontSize: 25),
        backgroundColor: Secondary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            color: TextColor,
            onPressed: () {
              _refreshUserList(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Provider.of<Users>(context, listen: false).loadUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Consumer<Users>(
                    builder: (context, users, child) {
                      return ListView.builder(
                        itemCount: users.count,
                        itemBuilder: (context, index) {
                          final user = users.byIndex(index);
                          if (index == 0) {
                            return _buildFirstUserTile(context, user);
                          } else {
                            return _buildOtherUserTile(context, user);
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AddButton,
                    foregroundColor: TextColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sports_mma),
                  label: const Text('Lutar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FightButton,
                    foregroundColor: TextColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _startBattle(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //HUD - Frist user

  Widget _buildFirstUserTile(BuildContext context, User user) {
    const Color TextColor = Color.fromARGB(255, 229, 232, 244);
    const Color Secondary = Color.fromARGB(255, 71, 51, 120);
    const Color Accent = Color.fromARGB(255, 149, 99, 189);
    const Color EditButtonColor = Color.fromARGB(255, 78, 214, 65);
    const Color DeleteButtonColor = Color.fromARGB(255, 218, 73, 29);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Accent, width: 3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Secondary.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: TextColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.email,
              style: const TextStyle(color: TextColor),
            ),
            const SizedBox(height: 4),
            Text(
              '💖 HP: ${user.health}',
              style: const TextStyle(color: TextColor),
            ),
            Text(
              '🗡️ Dano: ${user.power}',
              style: const TextStyle(color: TextColor),
            ),
            Text(
              // ignore: deprecated_member_use
              '🧍‍♂️Classe: ${describeEnum(user.classType)}',
              style: const TextStyle(color: TextColor),
            ),
          ],
        ),
        leading: CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            user.avatarUrl.isEmpty
                ? 'https://i.kym-cdn.com/photos/images/masonry/001/883/713/8a7.png'
                : user.avatarUrl,
          ),
          onBackgroundImageError: (exception, stackTrace) {
            if (kDebugMode) {
              print('Erro ao carregar imagem: $exception');
            }
          },
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                color: EditButtonColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteDialog(context, user);
                },
                color: DeleteButtonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //HUD - Other users

  Widget _buildOtherUserTile(BuildContext context, User user) {
    const Color TextColor = Color.fromARGB(255, 229, 232, 244);
    const Color BorderColor = Color.fromARGB(255, 170, 65, 97);
    const Color EnemyColor = Color.fromARGB(255, 23, 32, 71);
    const Color EditButtonColor = Color.fromARGB(255, 78, 214, 65);
    const Color DeleteButtonColor = Color.fromARGB(255, 218, 73, 29);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: BorderColor, width: 3),
        borderRadius: BorderRadius.circular(10),
        color: EnemyColor,
        boxShadow: [
          BoxShadow(
            color: BorderColor.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          user.name,
          style: const TextStyle(color: TextColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.email,
              style: const TextStyle(color: TextColor),
            ),
            const SizedBox(height: 4),
            Text(
              '💖 HP: ${user.health}',
              style: const TextStyle(color: TextColor),
            ),
            Text(
              '🗡️ Dano: ${user.power}',
              style: const TextStyle(color: TextColor),
            ),
            Text(
              // ignore: deprecated_member_use
              '🧍‍♂️Classe: ${describeEnum(user.classType)}',
              style: const TextStyle(color: TextColor),
            ),
          ],
        ),
        leading: CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            user.avatarUrl.isEmpty
                ? 'https://i.kym-cdn.com/entries/icons/medium/000/023/543/maxresdefault.jpg'
                : user.avatarUrl,
          ),
          onBackgroundImageError: (exception, stackTrace) {
            if (kDebugMode) {
              print('Erro ao carregar imagem: $exception');
            }
          },
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                color: EditButtonColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteDialog(context, user);
                },
                color: DeleteButtonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Function - Delete dialog

  void _showDeleteDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Usuário'),
        content: const Text('Tem certeza que deseja excluir este usuário?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Não'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Sim'),
            onPressed: () {
              Provider.of<Users>(context, listen: false).remove(user);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  //Function - Refresh user list

  void _refreshUserList(BuildContext context) {
    Provider.of<Users>(context, listen: false).loadUsers();
  }

  //Function - Start battle

  void _startBattle(BuildContext context) {
    final usersProvider = Provider.of<Users>(context, listen: false);
    if (usersProvider.count > 1) {
      User firstUser = usersProvider.byIndex(0);
      usersProvider.startBattle(context, firstUser);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não há usuários suficientes para iniciar uma batalha.'),
      ));
    }
  }
}


