import 'package:flutter/material.dart';

import '../../_exports.dart';

class DamasPage extends StatefulWidget {
  const DamasPage({super.key});

  @override
  State<DamasPage> createState() => _DamasPageState();
}

class _DamasPageState extends State<DamasPage> {
  DamasLogic damasLogic = DamasLogic();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF0472E8),
        title: const Text('Jogo de Damas'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TurnWidget(damasLogic: damasLogic),
              const SizedBox(height: 30),
              BoardWidget(damasLogic: damasLogic),
              const SizedBox(height: 30),
              RestartButton(damasLogic: damasLogic),
            ],
          ),
        ),
      ),
    );
  }
}
