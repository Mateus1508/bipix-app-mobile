import 'package:bipixapp/services/utilities.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/load_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
  GoogleSignIn googleSignIn = GoogleSignIn();

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUser = user;
    });
  }

  Future handleLoginUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    return response.body;
  }

  Future<UserCredential> _handleGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (kDebugMode) {
      print(credential);
    }

    if (currentUser != null) {
      Navigator.pushNamed(context, '/home');
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /* Future<void> _handleGoogleSignIn() async {
    try {

      final FirebaseUser user = authResult.user;

      Navigator.pushNamed(context, '/home');
    } catch (error) {
      print(error);
    }
  } */

  Future<String> autenticarUsuario(String email, String password) async {
    final entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);

    final http.Response response;

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        entry.remove();
        return "Usuário não encontrado.";
      }

      if (!credential.user!.emailVerified) {
        entry.remove();
        return "E-mail não verificado. Verifique o e-mail para continuar";
      }

      response = await Webservice.post(function: "sign-in", body: {
        'email': email,
        'userId': credential.user!.uid,
      });

      if (response.statusCode == 200) {
        // Salva o id do usuário localmente
        Navigator.pushReplacementNamed(context, '/home');
        entry.remove();
        return 'Usuário autenticado com sucesso.';
      } else if (response.statusCode == 401) {
        entry.remove();
        return 'Email ou senha incorretos!';
      } else {
        throw Exception('Erro ao autenticar usuário.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        entry.remove();
        return "Usuário não encontrado.";
      }
      if (e.code == "wrong-password") {
        entry.remove();
        return "Senha incorreta.";
      }
    } catch (e) {
      print("Erro: $e");
      entry.remove();
      return e.toString();
    }

    entry.remove();
    return "Erro";
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
                              if (_formfield.currentState!.validate()) {
                                showCustomSnackBar(
                                  context,
                                  await autenticarUsuario(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
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
