import 'package:flutter/material.dart';

class SelectFriend extends StatelessWidget {
  final String? nome; // Alterado para String?

  const SelectFriend({Key? key, this.nome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '@${nome ?? ''}', // Exibe o nome do amigo (se não for nulo)
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
