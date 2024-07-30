import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fluter_crud/provider/users.dart'; // Verifique se o caminho está correto
import 'package:fluter_crud/routes/app_routes.dart';
import 'package:fluter_crud/views/user_form.dart';
import 'package:fluter_crud/views/user_list.dart';
import 'package:fluter_crud/views/home_screen.dart'; // Importe a tela inicial

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
      ],
      child: MaterialApp(
        title: 'Controle Supremo Tribunal Federal haha',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.HOME, // Defina a rota inicial
        routes: {
          AppRoutes.HOME: (context) => HomeScreen(), // Altere para HomeScreen
          AppRoutes.USER_FORM: (context) => UserForm(),
          AppRoutes.USER_LIST: (context) => UserList(), // Adicione a rota para a lista de usuários
        },
      ),
    );
  }
}
