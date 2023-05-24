import 'package:flutter/material.dart';
import 'package:bipixapp/models/board.dart';
import 'package:bipixapp/pages/rematch.dart';

class BoardWidget extends StatefulWidget {
  final Board board;

  BoardWidget({required this.board});

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  bool gameOver = false;
  String currentPlayer = 'X'; // Variável currentPlayer declarada aqui

  void updateCellValue(int row, int col) {
    if (!gameOver && widget.board.cells[row][col].value.isEmpty) {
      setState(() {
        widget.board.cells[row][col].value = currentPlayer;
        widget.board.cells[row][col].isFilled = true;
        String winner = widget.board.checkWinner();
        gameOver = winner.isNotEmpty;

        if (gameOver) {
          // Verifica se há um vencedor e navega para a tela Rematch
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Rematch()),
          );
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.board.size,
      ),
      itemCount: widget.board.size * widget.board.size,
      itemBuilder: (context, index) {
        final row = index ~/ widget.board.size;
        final col = index % widget.board.size;
        final cell = widget.board.cells[row][col];

        return GestureDetector(
          onTap: () => updateCellValue(row, col),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500, width: 2),
            ),
            child: Center(
              child: Text(
                cell.value,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: (cell.value == 'O') ? Colors.blue : Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
