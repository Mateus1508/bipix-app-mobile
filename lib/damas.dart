import 'package:flutter/material.dart';

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

  bool isValidMove(int fromRow, int fromCol, int toRow, int toCol) {
    // Check if the destination square is already occupied
    if (board[toRow][toCol] != 0) {
      return false;
    }

    // Check if the piece is moving diagonally
    if (fromRow == toRow || fromCol == toCol) {
      return false;
    }

    // Check if the piece is making a jump (capture)
    if (toRow - fromRow == 2 || toRow - fromRow == -2) {
      int captureRow = (fromRow + toRow) ~/ 2;
      int captureCol = (fromCol + toCol) ~/ 2;
      if (board[captureRow][captureCol] == 0 ||
          board[captureRow][captureCol].sign == board[fromRow][fromCol].sign) {
        return false;
      }
      // Remove a peça capturada
      board[captureRow][captureCol] = 0;
      setState(() {});
    }

    // Check if the piece is moving forward (based on its color)
    if (board[fromRow][fromCol] == 1 && toRow >= fromRow) {
      return false;
    }
    if (board[fromRow][fromCol] == -1 && toRow <= fromRow) {
      return false;
    }

    // Check if the piece is moving more than one square
    if (toRow - fromRow.abs() > 2 || toCol - fromCol.abs() > 2) {
      return false;
    }

    // Check if the piece reached the opposite end and promote it to a queen
    if (board[fromRow][fromCol] == 1 && toRow == 0) {
      promoteToQueen(toRow, toCol);
    }
    if (board[fromRow][fromCol] == -1 && toRow == 7) {
      promoteToQueen(toRow, toCol);
    }

    return true;
  }

  void promoteToQueen(int row, int col) {
    board[row][col] = board[row][col].sign * 2; // promote to queen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cellSize = MediaQuery.of(context).size.width / 8;
    final aspectRatio = cellSize / (cellSize + 1);
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
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
    );
  }
}
