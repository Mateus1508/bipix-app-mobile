import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _formfield = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController repeatPasswordController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
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
                    child: const TextField(
                      maxLines: null,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      maxLength: 200,
                      decoration: InputDecoration(
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
