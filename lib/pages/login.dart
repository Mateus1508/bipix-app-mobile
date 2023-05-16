import 'package:bipixapp/dataSources/webServices/api.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:validatorless/validatorless.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late GoogleSignIn _googleSignIn;

  Future handleLoginUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    return response.body;
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser =
          _googleSignIn.signIn() as GoogleSignInAccount?;
      if (googleUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUp()),
        );
      }
    } catch (error) {
      // An error occurred during authentication
    }
  }

  Future<Object> autenticarUsuario(String email, String senha) async {
    final response = await http.post(
      Uri.parse('https://bipixapi.cyclic.app/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      return 'Usuário autenticado com sucesso.';
    } else if (response.statusCode == 401) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos!')),
      );
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

  AuthButtonStyle? authButtonStyle;

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
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      validator: Validatorless.regex(
                        RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                        'A senha deve possuir 8 caracteres, 1 letra maiuscula, 1 minuscula e um caractere especial!',
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.black54,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                              final String email = emailController.text;
                              final String senha = passwordController.text;
                              try {
                                final Object mensagem =
                                    await autenticarUsuario(email, senha);
                                if (kDebugMode) {
                                  print(mensagem);
                                }
                                Navigator.pushNamed(context, '/home');
                              } catch (error) {
                                if (kDebugMode) {
                                  print(error.toString());
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
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
                    const SizedBox(height: 20),
                    const Text(
                      "Ou entrar com",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GoogleAuthButton(
                          onPressed: handleGoogleSignIn,
                          style: const AuthButtonStyle(
                            buttonType: AuthButtonType.icon,
                          ),
                        ),
                        const SizedBox(width: 30),
                        FacebookAuthButton(
                          onPressed: _handleFacebookSignIn,
                          style: const AuthButtonStyle(
                            buttonType: AuthButtonType.icon,
                          ),
                        ),
                        const SizedBox(width: 30),
                        AppleAuthButton(
                          onPressed: () {},
                          style: const AuthButtonStyle(
                            buttonType: AuthButtonType.icon,
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
    );
  }
}
