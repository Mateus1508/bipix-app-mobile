import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../velha_store.dart';

class BoardWidget extends StatefulWidget {
  final VelhaStore store;

  const BoardWidget({
    super.key,
    required this.store,
  });

  @override
  BoardWidgetState createState() => BoardWidgetState();
}

class BoardWidgetState extends State<BoardWidget> {
  bool gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        print("########## Moves observer");
        if (widget.store.gameLoaded) {
          widget.store.setBoard(widget.store.moves);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.store.board.size,
            ),
            itemCount: widget.store.board.size * widget.store.board.size,
            itemBuilder: (context, index) {
              final row = index ~/ widget.store.board.size;
              final col = index % widget.store.board.size;
              final cell = widget.store.board.cells[row][col];

              return GestureDetector(
                onTap: () => widget.store.myTurn
                    ? widget.store.updateCellValue(row, col, context)
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0XFF0472E8), width: 15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: cell.value != ""
                          ? Image.asset(
                              "assets/images/tic_tac_toe/${cell.value}.png")
                          : null,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
