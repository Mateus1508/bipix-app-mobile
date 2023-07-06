import '../../_exports.dart';

class OnMovePlayer {
  static void call(
      {required DamasLogic damasLogic,
      required int col,
      required int row,
      required int player}) {
    final playerOne = (player == 1 || player == 3) ? true : false;
    final isPromoted = damasLogic.isPromoted(row, col);
    if (row < 8) {
      if (damasLogic.value.damasEntity.playerOne == playerOne) {
        if (isPromoted) {
          ShowPromotedPossiblesEvent.call(damasLogic, col, row, player);
        } else {
          ShowPossiblesEvent.call(damasLogic, col, row, player);
        }
      } else {
        damasLogic.value = DamasError(
            damasEntity: damasLogic.value.damasEntity,
            error: 'Não é a sua vez');
      }
    }
  }
}
