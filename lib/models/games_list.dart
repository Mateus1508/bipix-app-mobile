class GameItem {
  final int id;
  final String title;
  final String path;

  GameItem(this.id, this.title, this.path);
}

List<GameItem> gameImages = [
  GameItem(1, 'Baralho', 'assets/images/baralho.png'),
  GameItem(1, 'Dama', 'assets/images/dama.png'),
  GameItem(1, 'Truco', 'assets/images/truco.png'),
];
