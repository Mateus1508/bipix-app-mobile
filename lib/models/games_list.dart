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
  GameItem(7, 'Stop!', 'assets/images/games_logos/stop.png'),
  GameItem(8, 'Banco Imobiliário', 'assets/images/games_logos/monopoly.png'),
  GameItem(9, 'Quem matou Mario?', 'assets/images/games_logos/mario.png'),
  GameItem(10, 'Mundo Bipix', 'assets/images/games_logos/bipix_world.png'),
];
