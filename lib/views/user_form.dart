// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/provider/users.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _healthController;
  late TextEditingController _powerController;
  late TextEditingController _avatarUrlController;
  String? _selectedClassType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _healthController = TextEditingController();
    _powerController = TextEditingController();
    _avatarUrlController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      _loadFormData(user);
    }
  }

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _healthController.text = user.health.toString();
    _powerController.text = user.power.toString();
    _selectedClassType = user.classType.toString();
    _avatarUrlController.text = user.avatarUrl;
  }

  void _fillTestData() {
    setState(() {
      _nameController.text = 'Teste User';
      _emailController.text = 'teste@example.com';
      _healthController.text = '50';
      _powerController.text = '25';
      _selectedClassType = ClassType.Warrior.toString();
      _avatarUrlController.text = 'https://i.kym-cdn.com/photos/images/masonry/001/883/713/8a7.png';
    });
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    final isNewUser = _formData['id'] == null;
    final user = User(
      id: isNewUser ? UniqueKey().toString() : _formData['id'],
      name: _nameController.text,
      email: _emailController.text,
      health: int.parse(_healthController.text),
      power: int.parse(_powerController.text),
      classType: ClassType.values.firstWhere((e) => e.toString() == _selectedClassType!),
      avatarUrl: _avatarUrlController.text,
    );

    try {
      await Provider.of<Users>(context, listen: false).put(user, isNewUser);
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar usuário: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color textColor = Color.fromARGB(255, 229, 232, 244);
    const Color backgroundColor = Color.fromARGB(255, 10, 14, 25);
    const Color secondaryColor = Color.fromARGB(255, 71, 51, 120);
    const Color accentColor = Color.fromARGB(255, 149, 99, 189);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: textColor, fontSize: 25),
        backgroundColor: secondaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            color: textColor,
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accentColor, width: 2),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome', 
                        labelStyle: TextStyle(
                          color: textColor
                          )
                        ),
                        style: const TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          if (value.trim().length < 3) {
                            return 'Nome precisa no mínimo de 3 letras';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['name'] = value!,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: textColor)),
                        style: const TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email é obrigatório';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Informe um email válido';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['email'] = value!,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _healthController,
                        decoration: const InputDecoration(labelText: 'Vida', labelStyle: TextStyle(color: textColor)),
                        style: const TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vida é obrigatória';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Informe um valor numérico válido';
                          }
                          if (int.parse(value) > 50) {
                            return 'Vida não pode ser maior que 50';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['health'] = value!,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _powerController,
                        decoration: const InputDecoration(labelText: 'Dano', labelStyle: TextStyle(color: textColor)),
                        style: const TextStyle(color: textColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Dano é obrigatório';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Informe um valor numérico válido';
                          }
                          if (int.parse(value) > 25) {
                            return 'Dano não pode ser maior que 25';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['power'] = value!,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: _selectedClassType,
                        decoration: const InputDecoration(labelText: 'Classe', labelStyle: TextStyle(color: textColor)),
                        items: ClassType.values.map((classType) {
                          return DropdownMenuItem<String>(
                            value: classType.toString(),
                            child: Text(classType.toString().split('.').last, 
                            style: const TextStyle(
                              color: textColor
                              )
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedClassType = value!;
                          });
                        },
                        onSaved: (value) => _formData['classType'] = value!,
                        style: const TextStyle(color: textColor),
                        dropdownColor: secondaryColor,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _avatarUrlController,
                        decoration: const InputDecoration(labelText: 'URL do Avatar', labelStyle: TextStyle(color: textColor)),
                        style: const TextStyle(color: textColor),
                        onSaved: (value) => _formData['avatarUrl'] = value!,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fillTestData,
                        child: const Text('Preencher com Dados de Teste'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: textColor, 
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                      ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _healthController.dispose();
    _powerController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }
}
