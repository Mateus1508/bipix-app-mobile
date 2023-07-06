import 'package:flutter/material.dart';
import '_exports.dart';

void main() {
  runApp(const Damas());
}

class Damas extends StatelessWidget {
  const Damas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Damas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DamasPage(),
    );
  }
}
