import 'package:bipixapp/dataSources/webServices/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:validatorless/validatorless.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _formfield = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController repeatPasswordController = TextEditingController();
bool passToggle = false;

Future<http.Response> handleSignUp(
  String username,
  String email,
  String password,
) async {
  final hashedPassword = sha256.convert(utf8.encode(password)).toString();

  final response = await http.post(
    Uri.parse('$baseUrl/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'email': email,
      'password': hashedPassword,
    }),
  );

  if (response.statusCode == 201) {
  } else {
    if (kDebugMode) {
      print(
          'Erro ao criar usuário: ${response.body}, status: ${response.statusCode}');
    }
  }
  return response;
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundLogin.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formfield,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/bipixLogo.png'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: nameController,
                        validator:
                            Validatorless.required('O nome é obrigatório!'),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          fillColor: Colors.black54,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          labelText: 'Seu nome',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: usernameController,
                        validator: Validatorless.required(
                            'O nome de usuário é obrigatório!'),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          fillColor: Colors.black54,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          labelText: 'Nome de usuário',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        validator: Validatorless.multiple([
                          Validatorless.required('O email é obrigatório!'),
                          Validatorless.email('Formato de email incorreto!'),
                        ]),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          fillColor: Colors.black54,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        validator: Validatorless.regex(
                          RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                          'A senha deve ter 8 caracteres, composto de letras maiúsculas, minúsculas e números',
                        ),
                        style: const TextStyle(color: Colors.white),
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          fillColor: Colors.black54,
                          filled: true,
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: repeatPasswordController,
                        validator: (value) {
                          if (passwordController.text != value) {
                            return 'As senhas devem ser iguais!';
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          fillColor: Colors.black54,
                          filled: true,
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          labelText: 'Repetir senha',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade800,
                                padding: const EdgeInsets.all(14),
                              ),
                              child: const Text(
                                'Voltar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () async {
                                var formValid =
                                    _formfield.currentState?.validate() ??
                                        false;
                                if (formValid) {
                                  final String username =
                                      usernameController.text;
                                  final String email = emailController.text;
                                  final String senha =
                                      repeatPasswordController.text;

                                  // Verificar se as senhas correspondem
                                  if (passwordController.text !=
                                      repeatPasswordController.text) {
                                    // As senhas não correspondem
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'As senhas não correspondem')),
                                    );
                                    return;
                                  }
                                  final response = await handleSignUp(
                                      username, email, senha);
                                  // Limpar os campos se a resposta for bem-sucedida
                                  if (response.statusCode == 201) {
                                    if (kDebugMode) {
                                      print('usuário adicionado');
                                    }
                                    usernameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                    nameController.clear();
                                    repeatPasswordController.clear();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(14),
                              ),
                              child: const Text(
                                'Criar conta',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
