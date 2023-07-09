import 'possible_entity.dart';
import 'damas_logic.dart';

class ShowPossibles {
  static Future<PossibleEntity> call(
      DamasLogic damasLogic,
      List<List<int>> prossibles,
      List<List<int>> board,
      int startX,
      int startY,
      int player) async {
    int sequenceOtherPlayer = 0;
    int newerMoviment = 0;
    int capturePossibles = 0;
    bool hasPlayer = false;
    int? endX;
    int? endY;
    for (final possible in prossibles) {
      final possibleX = possible[0];
      final possibleY = possible[1];
      if (damasLogic.isWithinBoard(possibleX, possibleY)) {
        final local = board[possibleY][possibleX];
        final isPlayer = damasLogic.checkPlayer(player, local);
        if (local == 0) {
          if (!hasPlayer) {
            if (sequenceOtherPlayer < 2) {
              if (sequenceOtherPlayer == 1 && capturePossibles > 0) {
                endX = possibleX;
                endY = possibleY;
              }
              board[possibleY][possibleX] = 5;
            } else {
              capturePossibles = 0;
              newerMoviment = newerMoviment + 1;
            }
          } else {
            newerMoviment + 1;
          }
          sequenceOtherPlayer = 0;
        } else if (isPlayer) {
          hasPlayer = true;
          sequenceOtherPlayer = 0;
        } else {
          if (sequenceOtherPlayer < 2) {
            capturePossibles = capturePossibles + 1;
          }
          sequenceOtherPlayer = sequenceOtherPlayer + 1;
        }
      } else {
        damasLogic.emitError('Nenhum movimento possível');
      }
    }
    final hasMoviment = newerMoviment >= prossibles.length ? false : true;
    return PossibleEntity(capturePossibles, hasMoviment,
        endX: endX, endY: endY);
  }
}
