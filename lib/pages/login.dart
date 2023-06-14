import 'package:bipixapp/pages/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import '../services/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future handleLoginUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    return response.body;
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.pushNamed(context, '/home');
    } catch (error) {
      print(error);
    }
  }

  Future<Object> autenticarUsuario(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      // Salva o id do usuário localmente
      final instance = await SharedPreferences.getInstance();
      await instance.setString("USER_ID", jsonDecode(response.body)["userId"]);
      // await const FlutterSecureStorage()
      //     .write(key: "USER_ID", value: jsonDecode(response.body)["userId"]);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
      return 'Usuário autenticado com sucesso.';
    } else if (response.statusCode == 401) {
      return 'Email ou senha incorretos!';
    } else {
      throw Exception('Erro ao autenticar usuário.');
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      final LoginResult result = FacebookAuth.instance.login() as LoginResult;
      if (result.status == LoginStatus.success) {
        Navigator.pushNamed(context, '/home');
      } else {
        // An error occurred during authentication
      }
    } catch (error) {
      // An error occurred during authentication
    }
  }

  void handleGoogleSignIn() {
    _handleGoogleSignIn();
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundLogin.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formfield,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/bipixLogo.png'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      validator: Validatorless.multiple([
                        Validatorless.required('O email é obrigatório!'),
                        Validatorless.email('Formato de email incorreto!'),
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        fillColor: Colors.black54,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFF0472E8), width: 2),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0XFF0472E8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatória!'),
                      ]),
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
                              BorderSide(color: Color(0XFF0472E8), width: 2),
                        ),
                        labelText: 'Senha',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0XFF0472E8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade800,
                              padding: const EdgeInsets.all(14),
                            ),
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 20,
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
                                  _formfield.currentState?.validate() ?? false;
                              if (formValid) {
                                final String email = emailController.text;
                                final String senha = passwordController.text;
                                try {
                                  final Object mensagem =
                                      await autenticarUsuario(email, senha);
                                  if (kDebugMode) {
                                    print(mensagem);
                                  }
                                } catch (error) {
                                  if (kDebugMode) {
                                    print(error.toString());
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF0472E8),
                              padding: const EdgeInsets.all(14),
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Ou entrar com",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: _handleGoogleSignIn,
                        icon: Image.asset(
                            "assets/images/social_media_icons/google.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
