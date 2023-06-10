import 'package:flutter/material.dart';
import 'package:bipixapp/models/board.dart';
import 'package:bipixapp/pages/player_lose.dart';

class BoardWidget extends StatefulWidget {
  final Board board;

  const BoardWidget({super.key, required this.board});

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  bool gameOver = false;
  String switchPlayer = 'X';

  void updateCellValue(int row, int col) {
    if (!gameOver && widget.board.cells[row][col].value.isEmpty) {
      setState(() {
        widget.board.cells[row][col].value = switchPlayer;
        widget.board.cells[row][col].isFilled = true;
        String winner = widget.board.checkWinner();
        gameOver = winner.isNotEmpty;

        if (gameOver) {
          // Verifica se há um vencedor e navega para a tela playerlose
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlayerLose()),
          );
        } else {
          switchPlayer = (switchPlayer == 'X') ? 'O' : 'X';
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
              border: Border.all(color: const Color(0XFF0472E8), width: 15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: cell.value != ""
                    ? Image.asset("assets/images/tic_tac_toe/${cell.value}.png")
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
