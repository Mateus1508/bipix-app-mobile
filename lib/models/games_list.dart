class GameItem {
  final int id;
  final String title;
  final String path;

  GameItem(this.id, this.title, this.path);
}

List<GameItem> gameImages = [
  GameItem(1, 'truco', 'assets/images/truco.png'),
  GameItem(2, 'Dama', 'assets/images/dama.png'),
  GameItem(4, 'Velha', 'assets/images/tic-tac-toe.png'),
  GameItem(5, 'Ludo', 'assets/images/ludo.png'),
];
