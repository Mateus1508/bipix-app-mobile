import 'package:bipixapp/pages/sign_up.dart';
import 'package:bipixapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType, AuthIconType;

const storage = FlutterSecureStorage();

Future<void> login(BuildContext context, String email, String password) async {
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email e senha são obrigatórios')),
    );
    return;
  }

  if (!_isValidEmail(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email inválido')),
    );
    return;
  }

  final url = Uri.parse('https://bipixapi.cyclic.app/auth');
  final response = await http.post(url, body: {
    'email': email,
    'password': _encryptPassword(password),
  });

  if (response.statusCode == 200) {
    final token = response.headers['authorization'];
    await storage.write(key: 'token', value: token);
    Navigator.pushNamed(context, '/editprofile');
  } else {
    final message = _getErrorMessage(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

bool _isValidEmail(String email) {
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}

String _encryptPassword(String password) {
  return password;
}

String _getErrorMessage(String body) {
  return 'Falha na autenticação';
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late GoogleSignIn _googleSignIn;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Navigate to the next screen if the user was successfully authenticated
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUp()),
        );
      }
    } catch (error) {
      // An error occurred during authentication
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // The user was successfully authenticated
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
        backgroundColor: const Color(0xFF333333),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/bipixLogo.png'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
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
                          child: const Text('Criar conta'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            login(context, emailController.text,
                                passwordController.text);
                            Navigator.pushNamed(context, '/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(14),
                          ),
                          child: const Text('Entrar'),
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
    );
  }
}
