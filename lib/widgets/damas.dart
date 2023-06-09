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
  bool playerTurn = true; // Adicionado

  void switchPlayer() {
    // Adicionado
    setState(() {
      playerTurn = !playerTurn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width * 0.9;
    final squareSize = boardSize / 8;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF0472E8),
        title: const Text('Jogo de Damas'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    playerTurn == true ? const Color(0XFF0472E8) : Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                playerTurn == true
                    ? 'Sua vez'
                    : 'Vez do (username do oponente)',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
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
                      final color =
                          isDarkSquare ? Colors.black : Colors.brown[300];

                      if (gameLogic.board[row][col] == 1) {
                        return GestureDetector(
                          onTap: () {
                            if (row < 7) {
                              if (gameLogic.canCapture(col, row, 1)) {
                                setState(() {
                                  gameLogic.captureSequence(col, row, 1);
                                  switchPlayer(); // Adicionado
                                });
                              } else {
                                if (col < 7 &&
                                    gameLogic.isValidMove(
                                        col, row, col + 1, row + 1, 1)) {
                                  setState(() {
                                    gameLogic.makeMove(
                                        col, row, col + 1, row + 1, 1);
                                    switchPlayer(); // Adicionado
                                  });
                                }
                                if (col > 0 &&
                                    gameLogic.isValidMove(
                                        col, row, col - 1, row + 1, 1)) {
                                  setState(() {
                                    gameLogic.makeMove(
                                        col, row, col - 1, row + 1, 1);
                                    switchPlayer(); // Adicionado
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
                            color: color,
                            width: constraints.maxWidth / 8,
                            height: constraints.maxWidth / 8,
                            child: Image.asset(
                                'assets/images/checkers/icon_brown.png'),
                          ),
                        );
                      }

                      if (gameLogic.board[row][col] == 2) {
                        return GestureDetector(
                          onTap: () {
                            print('Peça azul pressionada');
                            if (row < 7) {
                              if (gameLogic.canCapture(col, row, 2)) {
                                setState(() {
                                  gameLogic.captureSequence(col, row, 2);
                                  switchPlayer(); // Adicionado
                                });
                              } else {
                                if (col < 7 &&
                                    gameLogic.isValidMove(
                                        col, row, col + 1, row - 1, 2)) {
                                  setState(() {
                                    gameLogic.makeMove(
                                        col, row, col + 1, row - 1, 2);
                                    switchPlayer(); // Adicionado
                                  });
                                }
                                if (col > 0 &&
                                    gameLogic.isValidMove(
                                        col, row, col - 1, row - 1, 2)) {
                                  setState(() {
                                    gameLogic.makeMove(
                                        col, row, col - 1, row - 1, 2);
                                    switchPlayer(); // Adicionado
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
                            color: color,
                            width: constraints.maxWidth / 8,
                            height: constraints.maxWidth / 8,
                            child: Image.asset(
                                'assets/images/checkers/icon_blue.png'),
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
          ],
        ),
      ),
    );
  }
}
