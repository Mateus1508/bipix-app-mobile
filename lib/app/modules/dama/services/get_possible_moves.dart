class GetPossibleMoves {
  static List<List<List<int>>> call(int startX, int startY) {
    List<List<List<int>>> possibleMoves = [];

    // Definir os deslocamentos diagonais possíveis
    List<List<int>> directions = [
      [-1, -1], // cima-esquerda
      [-1, 1], // cima-direita
      [1, -1], // baixo-esquerda
      [1, 1], // baixo-direita
    ];

    // Criar listas separadas para cada direção de diagonal
    List<List<int>> diagonalUpLeft = [];
    List<List<int>> diagonalUpRight = [];
    List<List<int>> diagonalDownLeft = [];
    List<List<int>> diagonalDownRight = [];

    // Verificar cada direção
    for (var direction in directions) {
      int dx = direction[0]; // deslocamento horizontal
      int dy = direction[1]; // deslocamento vertical

      int x = startX + dx;
      int y = startY + dy;

      // Verificar se a nova posição está dentro do tabuleiro
      while (x >= 0 && x < 8 && y >= 0 && y < 8) {
        // Adicionar a posição atual à lista correspondente à direção da diagonal
        if (dx == -1 && dy == -1) {
          diagonalUpLeft.add([x, y]);
        } else if (dx == -1 && dy == 1) {
          diagonalUpRight.add([x, y]);
        } else if (dx == 1 && dy == -1) {
          diagonalDownLeft.add([x, y]);
        } else if (dx == 1 && dy == 1) {
          diagonalDownRight.add([x, y]);
        }

        x += dx;
        y += dy;
      }
    }
    possibleMoves.add(diagonalUpLeft);
    possibleMoves.add(diagonalUpRight);
    possibleMoves.add(diagonalDownLeft);
    possibleMoves.add(diagonalDownRight);

    return possibleMoves;
  }
}
