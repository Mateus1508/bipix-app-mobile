import 'package:bipixapp/models/cell.dart';

class Board {
  List<List<Cell>> cells;
  int size;

  Board({required this.size}) : cells = List<List<Cell>>.generate(
      size,
      (_) => List<Cell>.generate(
        size,
        (_) => Cell(value: ''),
      ),
    );

  String checkWinner() {
    // Verifica linhas
    for (int i = 0; i < size; i++) {
      if (cells[i][0].value != '' &&
          cells[i][0].value == cells[i][1].value &&
          cells[i][0].value == cells[i][2].value) {
        return cells[i][0].value;
      }
    }

    // Verifica colunas
    for (int i = 0; i < size; i++) {
      if (cells[0][i].value != '' &&
          cells[0][i].value == cells[1][i].value &&
          cells[0][i].value == cells[2][i].value) {
        return cells[0][i].value;
      }
    }

    // Verifica diagonal principal
    if (cells[0][0].value != '' &&
        cells[0][0].value == cells[1][1].value &&
        cells[0][0].value == cells[2][2].value) {
      return cells[0][0].value;
    }

    // Verifica diagonal secundária
    if (cells[0][2].value != '' &&
        cells[0][2].value == cells[1][1].value &&
        cells[0][2].value == cells[2][0].value) {
      return cells[0][2].value;
    }

    // Verifica empate
    bool isDraw = true;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (cells[i][j].value == '') {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      return 'draw';
    }

    // Não há vencedor
    return '';
  }
}
