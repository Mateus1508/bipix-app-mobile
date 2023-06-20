import 'package:bipixapp/services/utilities.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import '../widgets/load_overlay.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool passToggle = false;

  Future<void> handleSignUp(
    String username,
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    final entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);

    late final UserCredential credential;

    late final Response response;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      response = await Webservice.post(function: "sign-up", body: {
        "userId": credential.user?.uid,
        'username': username,
        'email': emailAddress,
        "phrase": "",
      });
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      repeatPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomSnackBar(context, "A senha fornecida é muito fraca.");
        entry.remove();
        return;
      } else if (e.code == 'email-already-in-use') {
        showCustomSnackBar(context, "Já existe uma conta para este email.");
        entry.remove();
        return;
      }
    } catch (e) {
      print(e);
    }

    if (response.statusCode != 201) {
      showCustomSnackBar(context,
          'Erro ao criar usuário: ${response.body}, status: ${response.statusCode}');
      entry.remove();
      return;
    }
    entry.remove();
    Navigator.pop(context);
  }

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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                              borderSide: BorderSide(
                                  color: Color(0XFF0472E8), width: 2),
                            ),
                            labelText: 'Seu nome',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0XFF0472E8)),
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
                              borderSide: BorderSide(
                                  color: Color(0XFF0472E8), width: 2),
                            ),
                            labelText: 'Nome de usuário',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0XFF0472E8)),
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
                              borderSide: BorderSide(
                                  color: Color(0XFF0472E8), width: 2),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0XFF0472E8)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
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
                              borderSide: BorderSide(
                                  color: Color(0XFF0472E8), width: 2),
                            ),
                            labelText: 'Senha',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0XFF0472E8)),
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
                            return null;
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
                              borderSide: BorderSide(
                                  color: Color(0XFF0472E8), width: 2),
                            ),
                            labelText: 'Repetir senha',
                            labelStyle: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0XFF0472E8)),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'As senhas não correspondem')),
                                      );
                                      return;
                                    }

                                    final response = await handleSignUp(
                                      username,
                                      email,
                                      senha,
                                      context,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0XFF0472E8),
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
      ),
    );
  }
}
