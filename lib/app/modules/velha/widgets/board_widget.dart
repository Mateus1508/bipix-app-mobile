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
// ltrb
  final borders = [
    [false, false, true, true],
    [true, false, true, true],
    [true, false, false, true],
    [false, true, true, true],
    [true, true, true, true],
    [true, true, false, true],
    [false, true, true, false],
    [true, true, true, false],
    [true, true, false, false],
  ];

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
                    border: Border(
                      left: borders[index][0]
                          ? const BorderSide(color: Colors.white, width: 5)
                          : BorderSide.none,
                      top: borders[index][1]
                          ? const BorderSide(color: Colors.white, width: 5)
                          : BorderSide.none,
                      right: borders[index][2]
                          ? const BorderSide(color: Colors.white, width: 5)
                          : BorderSide.none,
                      bottom: borders[index][3]
                          ? const BorderSide(color: Colors.white, width: 5)
                          : BorderSide.none,
                    ),
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
