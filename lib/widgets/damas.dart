import 'package:flutter/material.dart';
import 'package:bipixapp/models/damas_logic.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Damas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameRenderer(),
    );
  }
}

class GameRenderer extends StatefulWidget {
  @override
  _GameRendererState createState() => _GameRendererState();
}

class _GameRendererState extends State<GameRenderer> {
  GameLogic gameLogic = GameLogic();

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width * 0.9;
    final squareSize = boardSize / 8;

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Damas'),
      ),
      body: Center(
        child: Container(
          width: boardSize,
          height: boardSize,
          color: Colors.brown, // Cor de fundo do tabuleiro
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 64,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ 8;
                  final col = index % 8;
                  final isDarkSquare = (row + col) % 2 == 0;
                  final color = isDarkSquare ? Colors.black : Colors.brown[300];

                  if (gameLogic.board[row][col] == 1) {
                    return GestureDetector(
                      onTap: () {
                        if (row < 7 && col < 7) {
                          if (gameLogic.isValidMove(
                              col, row, col + 1, row + 1, 1)) {
                            setState(() {
                              gameLogic.makeMove(
                                  col, row, col + 1, row + 1, 1);
                            });
                          }
                        }
                      },
                      child: Container(
                        color: color,
                        width: constraints.maxWidth / 8,
                        height: constraints.maxWidth / 8,
                        child: Icon(Icons.circle, color: Colors.white),
                      ),
                    );
                  }

                  if (gameLogic.board[row][col] == 2) {
                    return GestureDetector(
                      onTap: () {
                        if (row > 0 && col < 7) {
                          if (gameLogic.isValidMove(
                              col, row, col + 1, row - 1, 2)) {
                            setState(() {
                              gameLogic.makeMove(
                                  col, row, col + 1, row - 1, 2);
                            });
                          }
                        }
                      },
                      child: Container(
                        color: color,
                        width: constraints.maxWidth / 8,
                        height: constraints.maxWidth / 8,
                        child: Icon(Icons.circle, color: Colors.red),
                      ),
                    );
                  }

                  return Container(
                    color: color,
                    width: constraints.maxWidth / 8,
                    height: constraints.maxWidth / 8,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}