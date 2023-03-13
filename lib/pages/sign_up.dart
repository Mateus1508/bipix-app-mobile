import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF333333),
        body: Center(
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
                const TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: 'Seu nome',
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
                const TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: 'Apelido',
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
                const TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                const TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          padding: const EdgeInsets.all(14),
                        ),
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(14),
                        ),
                        child: const Text('Criar conta'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
