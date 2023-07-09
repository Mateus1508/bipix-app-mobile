import 'dama_entity.dart';
import 'damas_logic.dart';
import 'get_possible_moves.dart';
import 'move_event.dart';
import 'show_possibles.dart';

class ShowPromotedPossiblesEvent {
  static call(DamasLogic damasLogic, int startX, int startY, int player) async {
    int anyMoviment = 0;
    List<int> betterRoute = [];
    int capturePossibles = 0;
    damasLogic.value = DamasLoading(damasEntity: damasLogic.value.damasEntity);
    final board = damasLogic.value.damasEntity.board;
    // print(board);
    final dama = DamaEntity(startX, startY, player);

    final possibles = GetPossibleMoves.call(startX, startY);

    for (final possible in possibles) {
      final possibleEntity = await ShowPossibles.call(
          damasLogic, possible, board, startX, startY, player);
      if (!possibleEntity.hasMoviment) {
        anyMoviment = anyMoviment + 1;
      } else {
        if (possibleEntity.capturePossibles > 0 &&
            possibleEntity.capturePossibles > capturePossibles) {
          if (possibleEntity.endX != null && possibleEntity.endY != null) {
            betterRoute = [possibleEntity.endX ?? 0, possibleEntity.endY ?? 0];
          }
        }
      }
    }
    if (anyMoviment == 4) {
      damasLogic.emitError('Nenhum movimento possível');
    } else {
      if (betterRoute.isNotEmpty) {
        final dama = DamaEntity(startX, startY, player);
        MoveEvent.call(damasLogic, betterRoute[0], betterRoute[1],
            damaEntity: dama);
      } else {
        damasLogic.emitSuccess(board, dama);
      }
    }
  }
}
