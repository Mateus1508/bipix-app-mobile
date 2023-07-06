import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../_exports.dart';

class BoardWidget extends StatelessWidget {
  final DamasLogic damasLogic;
  const BoardWidget({super.key, required this.damasLogic});

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width * 0.9;
    return Container(
      width: boardSize,
      height: boardSize,
      color: Colors.brown, // Cor de fundo do tabuleiro
      child: ValueListenableBuilder<DamasState>(
          valueListenable: damasLogic,
          builder: (context, value, child) {
            if (value is DamasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.error),
                ));
              });
            }
            if (value is DamasFinish) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.message),
                ));
                damasLogic.restart();
              });
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final row = index ~/ 8;
                    final col = index % 8;
                    final isDarkSquare = (row + col) % 2 == 0;
                    final color =
                        isDarkSquare ? Colors.black : Colors.brown[300];
                    final player = value.damasEntity.board[row][col];

                    switch (player) {
                      case 1:
                        return PieceWidget(
                            color: color,
                            onTap: () => OnMovePlayer.call(
                                damasLogic: damasLogic,
                                col: col,
                                row: row,
                                player: 1),
                            icon: ConstantsImages.brownAsset,
                            constraints: constraints);
                      case 2:
                        return PieceWidget(
                            color: color,
                            onTap: () => OnMovePlayer.call(
                                damasLogic: damasLogic,
                                col: col,
                                row: row,
                                player: 2),
                            icon: ConstantsImages.blueAsset,
                            constraints: constraints);
                      case 3:
                        return PieceWidget(
                            color: color,
                            onTap: () => OnMovePlayer.call(
                                damasLogic: damasLogic,
                                col: col,
                                row: row,
                                player: 3),
                            icon: ConstantsImages.brownDamaAsset,
                            constraints: constraints);
                      case 4:
                        return PieceWidget(
                            color: color,
                            onTap: () => OnMovePlayer.call(
                                damasLogic: damasLogic,
                                col: col,
                                row: row,
                                player: 4),
                            icon: ConstantsImages.blueDamaAsset,
                            constraints: constraints);
                      case 5:
                        return GestureDetector(
                          onTap: () => MoveEvent.call(damasLogic, col, row),
                          child: Container(
                            decoration: BoxDecoration(
                                color: color,
                                border:
                                    Border.all(width: 4, color: Colors.red)),
                            width: constraints.maxWidth / 8,
                            height: constraints.maxWidth / 8,
                            child: kDebugMode
                                ? Text(
                                    '$col,$row',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : const SizedBox(),
                          ),
                        );
                      default:
                        return Container(
                          color: color,
                          width: constraints.maxWidth / 8,
                          height: constraints.maxWidth / 8,
                          child: kDebugMode
                              ? Text(
                                  '$col,$row',
                                  style: const TextStyle(color: Colors.white),
                                )
                              : const SizedBox(),
                        );
                    }
                  },
                );
              },
            );
          }),
    );
  }
}
