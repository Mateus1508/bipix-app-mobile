import 'package:flutter/material.dart';
import '../dama_store.dart';
import '../services/damas_logic.dart';

class TurnWidget extends StatelessWidget {
  final DamasLogic damasLogic;
  final DamaStore store;
  const TurnWidget({super.key, required this.damasLogic, required this.store});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DamasState>(
      valueListenable: damasLogic,
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 40),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: store.myTurn
                ? value.damasEntity.player == 1
                    ? Colors.brown
                    : Colors.blue
                : value.damasEntity.player == 1
                    ? Colors.blue
                    : Colors.brown,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            store.myTurn ? 'Sua vez' : 'Vez do ${store.oponentUsername}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
