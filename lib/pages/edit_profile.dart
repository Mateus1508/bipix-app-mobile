import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:http/http.dart' as http;
import '../services/api.dart';
import '../services/webservice.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _formfield = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController phraseController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController repeatPasswordController = TextEditingController();
late String userId;

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      userId = value;
      getById(value);
    }).catchError((error) {
      if (kDebugMode) {
        print('Error in initState: $error');
      }
    });
  }

  Future<String> getUserId() async {
    return Webservice.getUserId();
  }

  Future<void> getById(userId) async {
    var response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      phraseController.text = responseData['favorite_phrase'];
      usernameController.text = responseData['username'];
      emailController.text = responseData['email'];
    } else {
      print(
          'Erro ao obter o usuário. Código de status: ${response.statusCode}');
    }
  }

  void sendData() async {
    Map<String, String> requestBody = {
      'favorite_phrase': phraseController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'password': repeatPasswordController.text,
    };
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/users/$userId'),
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Dados enviados com sucesso!');
      } else {
        print(
            'Erro ao enviar os dados. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exceção ao enviar a requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF0472E8),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formfield,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Text(
                    "Editar Perfil",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: TextField(
                      maxLines: null,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      controller: phraseController,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        labelText: 'A sua frase preferida',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: Validatorless.required('O nome é obrigatório!'),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Seu nome',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    controller: usernameController,
                    validator: Validatorless.required(
                        'O nome de usuário é obrigatório!'),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Nome de usuário',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: Validatorless.multiple([
                      Validatorless.required('O email é obrigatório!'),
                      Validatorless.email('Formato de email incorreto!'),
                    ]),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: Validatorless.multiple([
                      Validatorless.regex(
                        RegExp(r'^(?=.*[a-z])'),
                        'Deve conter ao menos uma letra minúscula',
                      ),
                      Validatorless.regex(
                        RegExp(r'^(?=.*[A-Z])'),
                        'Deve conter ao menos uma letra maiúscula',
                      ),
                      Validatorless.regex(
                        RegExp(r'^(?=.*[$*&@#])'),
                        'Deve conter ao menos um caractere especial',
                      ),
                      Validatorless.regex(
                        RegExp(r'^[0-9a-zA-Z$*&@#]{8,}'),
                        'deve conter ao menos 8 dos caracteres mencionados',
                      ),
                      Validatorless.regex(
                        RegExp(r'^(?=.*\d)'),
                        'deve conter ao menos 1 dígito',
                      ),
                    ]),
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: repeatPasswordController,
                    validator: (value) {
                      if (passwordController.text != value) {
                        return 'As senhas devem ser iguais!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Repetir senha',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF0472E8),
                          padding: const EdgeInsets.all(14),
                        ),
                        child: const Text(
                          'Salvar perfil',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
