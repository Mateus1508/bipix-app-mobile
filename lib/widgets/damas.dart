import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Damas extends StatefulWidget {
  @override
  _DamasState createState() => _DamasState();
}

class _DamasState extends State<Damas> {
  List<List<int>> board = [
    [-1, 0, -1, 0, -1, 0, -1, 0],
    [0, -1, 0, -1, 0, -1, 0, -1],
    [-1, 0, -1, 0, -1, 0, -1, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
  ];

  int selectedPieceRow = -1;
  int selectedPieceCol = -1;

  void onTapDown(TapDownDetails details) {
    final cellSize = MediaQuery.of(context).size.width / 8;
    final screenHeight = MediaQuery.of(context).size.height;

    int row = (details.localPosition.dy / cellSize).floor();
    int col = (details.localPosition.dx / cellSize).floor();

    if (selectedPieceRow == -1 && selectedPieceCol == -1) {
      // Se nenhuma peça estiver selecionada, tenta selecionar uma peça
      if (board[row][col] == 1) {
        setState(() {
          selectedPieceRow = row;
          selectedPieceCol = col;
        });
      }
    } else {
      // Se uma peça estiver selecionada, tenta mover a peça para a posição tocada
      if (board[row][col] == 0) {
        if ((row == selectedPieceRow + 1 &&
                (col == selectedPieceCol - 1 || col == selectedPieceCol + 1)) ||
            (row == selectedPieceRow - 1 &&
                (col == selectedPieceCol - 1 || col == selectedPieceCol + 1))) {
          setState(() {
            board[selectedPieceRow][selectedPieceCol] = 0;
            board[row][col] = 1;
            selectedPieceRow = -1;
            selectedPieceCol = -1;
          });
        }
      }

      // Se tocar na mesma posição da peça selecionada, deseleciona a peça
      if (row == selectedPieceRow && col == selectedPieceCol) {
        setState(() {
          selectedPieceRow = -1;
          selectedPieceCol = -1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cellSize = MediaQuery.of(context).size.width / 8;
    final aspectRatio = cellSize / (cellSize + 1);
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: onTapDown,
      child: SizedBox(
        height: screenHeight,
        child: GridView.builder(
          itemCount: 64,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (BuildContext context, int index) {
            int row = index ~/ 8;
            int col = index % 8;
            bool isDarkSquare = (row + col) % 2 == 1;

            Widget piece;

            switch (board[row][col]) {
              case -1:
                piece = Icon(Icons.circle, color: Colors.black);
                break;
              case 1:
                piece = Icon(Icons.circle, color: Colors.green);
                break;
              case -2:
                piece = Icon(Icons.brightness_1, color: Colors.black);
                break;
              case 2:
                piece = Icon(Icons.brightness_1, color: Colors.green);
                break;
              default:
                piece = SizedBox.shrink();
                break;
            }

            return Container(
              decoration: BoxDecoration(
                color: isDarkSquare ? Colors.brown : Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Center(child: piece),
            );
          },
        ),
      ),
    );
  }
}
