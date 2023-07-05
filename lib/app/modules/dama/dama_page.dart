import 'package:bipixapp/app/modules/dama/dama_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DamaPage extends StatefulWidget {
  const DamaPage({super.key});

  @override
  _DamaPageState createState() => _DamaPageState();
}

class _DamaPageState extends State<DamaPage> {
  final DamaStore store = Modular.get();

  @override
  void initState() {
    store.loadGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width * 0.9;
    // final squareSize = boardSize / 8;

    return WillPopScope(
      onWillPop: () async => store.exitGame(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF0472E8),
          title: const Text('Jogo de Damas'),
        ),
        backgroundColor: Colors.white,
        body: Observer(
          builder: (context) {
            print("############# Observer: 0");
            return Center(
              child: !store.gameLoaded
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Observer(builder: (context) {
                          print("############# Observer: 1");
                          if (store.section["status"] == "FINISHED") {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.pushReplacementNamed(context, '/home');
                            });
                          }
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 40),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  store.section["player_turn"] == store.userId
                                      ? const Color(0XFF0472E8)
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              store.myTurn
                                  ? 'Sua vez'
                                  : 'Vez do ${store.isAdmin ? store.section["invited_username"] : store.section["admin_username"]}',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
                        Container(
                          width: boardSize,
                          height: boardSize,
                          color: Colors.brown, // Cor de fundo do tabuleiro
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Observer(builder: (context) {
                                if (store.board.last.isEmpty) {
                                  return CircularProgressIndicator();
                                }
                                print("############# Observer: 2");
                                // GameLogic gameLogic = store.gameLogic!;
                                store.gameLogic!
                                    .mountBoard(store.board.toList());

                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 64,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    final row = index ~/ 8;
                                    final col = index % 8;
                                    final isDarkSquare = (row + col) % 2 == 0;
                                    final color = isDarkSquare
                                        ? Colors.black
                                        : Colors.brown[300];

                                    if (store.gameLogic!.board[row][col] == 1) {
                                      return GestureDetector(
                                        onTap: store.myTurn
                                            ? () {
                                                if (row < 7) {
                                                  if (store.gameLogic!
                                                      .canCapture(
                                                          col, row, 1)) {
                                                    // setState(() {
                                                    store.gameLogic!
                                                        .captureSequence(
                                                      col,
                                                      row,
                                                      1,
                                                      context,
                                                    );
                                                    // switchPlayer(); // Adicionado
                                                    // });
                                                  } else {
                                                    if (col < 7 &&
                                                        store.gameLogic!
                                                            .isValidMove(
                                                                col,
                                                                row,
                                                                col + 1,
                                                                row + 1,
                                                                1)) {
                                                      // setState(() {
                                                      store.gameLogic!.makeMove(
                                                        col,
                                                        row,
                                                        col + 1,
                                                        row + 1,
                                                        1,
                                                        context,
                                                      );
                                                      // switchPlayer(); // Adicionado
                                                      // });
                                                    }
                                                    if (col > 0 &&
                                                        store.gameLogic!
                                                            .isValidMove(
                                                                col,
                                                                row,
                                                                col - 1,
                                                                row + 1,
                                                                1)) {
                                                      // setState(() {
                                                      store.gameLogic!.makeMove(
                                                        col,
                                                        row,
                                                        col - 1,
                                                        row + 1,
                                                        1,
                                                        context,
                                                      );
                                                      // switchPlayer(); // Adicionado
                                                      // });
                                                    }
                                                  }
                                                }
                                              }
                                            : null,
                                        child: Container(
                                          color: color,
                                          width: constraints.maxWidth / 8,
                                          height: constraints.maxWidth / 8,
                                          child: Image.asset(
                                              'assets/images/checkers/icon_brown.png'),
                                        ),
                                      );
                                    }

                                    if (store.gameLogic!.board[row][col] == 2) {
                                      return GestureDetector(
                                        onTap: store.myTurn
                                            ? () {
                                                print('Peça azul pressionada');
                                                if (row < 7) {
                                                  if (store.gameLogic!
                                                      .canCapture(
                                                          col, row, 2)) {
                                                    // setState(() {
                                                    store.gameLogic!
                                                        .captureSequence(
                                                      col,
                                                      row,
                                                      2,
                                                      context,
                                                    );
                                                    // switchPlayer(); // Adicionado
                                                    // });
                                                  } else {
                                                    if (col < 7 &&
                                                        store.gameLogic!
                                                            .isValidMove(
                                                                col,
                                                                row,
                                                                col + 1,
                                                                row - 1,
                                                                2)) {
                                                      // setState(() {
                                                      store.gameLogic!.makeMove(
                                                        col,
                                                        row,
                                                        col + 1,
                                                        row - 1,
                                                        2,
                                                        context,
                                                      );
                                                      // switchPlayer(); // Adicionado
                                                      // });
                                                    }
                                                    if (col > 0 &&
                                                        store.gameLogic!
                                                            .isValidMove(
                                                                col,
                                                                row,
                                                                col - 1,
                                                                row - 1,
                                                                2)) {
                                                      // setState(() {
                                                      store.gameLogic!.makeMove(
                                                        col,
                                                        row,
                                                        col - 1,
                                                        row - 1,
                                                        2,
                                                        context,
                                                      );
                                                      // switchPlayer(); // Adicionado
                                                      // });
                                                    }
                                                  }
                                                }
                                              }
                                            : null,
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
                              });
                            },
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
