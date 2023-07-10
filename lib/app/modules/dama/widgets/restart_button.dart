import 'package:flutter/material.dart';

import '../services/damas_logic.dart';

class RestartButton extends StatelessWidget {
  final DamasLogic damasLogic;
  const RestartButton({super.key, required this.damasLogic});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => damasLogic.restart(),
        child: const Icon(Icons.restart_alt_outlined));
  }
}