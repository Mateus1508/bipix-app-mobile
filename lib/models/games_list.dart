class GameItem {
  final int id;
  final String title;
  final String path;

  GameItem(this.id, this.title, this.path);
}

List<GameItem> gameImages = [
  GameItem(1, 'Truco', 'assets/images/games_logos/truco.png'),
  GameItem(2, 'Dama', 'assets/images/games_logos/checkers.png'),
  GameItem(4, 'Velha', 'assets/images/games_logos/tic_tac_toe.png'),
  GameItem(5, 'Ludo', 'assets/images/games_logos/ludo.png'),
  GameItem(6, 'Xadrez', 'assets/images/games_logos/chess.png'),
];
