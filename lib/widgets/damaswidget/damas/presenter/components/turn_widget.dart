import 'package:flutter/material.dart';

import '../../_exports.dart';

class TurnWidget extends StatelessWidget {
  final DamasLogic damasLogic;
  const TurnWidget({super.key, required this.damasLogic});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DamasState>(
        valueListenable: damasLogic,
        builder: (context, value, child) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: value.damasEntity.playerOne ? Colors.brown : Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              value.damasEntity.playerOne
                  ? 'Sua vez'
                  : 'Vez do (username do oponente)',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }
}
