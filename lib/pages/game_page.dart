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

  @override
  void initState() {
    super.initState();
    board = Board(size: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: BoardWidget(board: board),
      ),
    );
  }
}
