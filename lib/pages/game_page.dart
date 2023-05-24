import 'package:flutter/material.dart';
import 'package:bipixapp/widgets/Boardwidget.dart';
import 'package:bipixapp/models/board.dart';

void main() {
  runApp(GamePage());
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Board board = Board(size: 3);
  bool playerTurn = true;

  @override
  void initState() {
    super.initState();
    board = Board(size: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF0472E8),
        title: const Text('Jogo da Velha'),
        centerTitle: true,
        leading: Image.asset('assets/images/bipixLogo.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundWhite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: BoardWidget(board: board)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
