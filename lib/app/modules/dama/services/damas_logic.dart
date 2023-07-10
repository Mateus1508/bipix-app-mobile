import 'package:flutter/foundation.dart';

import 'dama_entity.dart';
import 'damas_entity.dart';
import 'get_default_entity.dart';

// import '../../_exports.dart';

part 'damas_state.dart';

class DamasLogic extends ValueNotifier<DamasState> {
  // final String section;
  final Map<String, dynamic> section;
  final List<List<int>> board;
  final String playerId;
  final int player;
  final String oponentId;
  DamasLogic(
    this.section,
    this.board,
    this.playerId,
    this.player,
    this.oponentId,
  ) : super(DamasInit(
            damasEntity: DamasEntity(
          board: board,
          section: section,
          player: player,
        )));
  // : super(DamasInit(damasEntity: GetDefaultEntity.call(section)));

  void switchPlayer() {
    value = DamasLoading(damasEntity: value.damasEntity);
    value = DamasSuccess(damasEntity: value.damasEntity.copyWith());
  }

  bool shouldBePromoted(int y, int player) {
    return (player == 1 && y == 7) || (player == 2 && y == 0);
  }

  bool isPromoted(int y, int x) {
    final player = value.damasEntity.board[y][x];
    return player >= 3;
  }

  bool isWithinBoard(int x, int y) {
    return x >= 0 && x <= 7 && y >= 0 && y <= 7;
  }

  bool checkPlayer(int player, int board) {
    if ((player == 1 || player == 3) &&
        (board == 2 || board == 4 || board == 0)) {
      return false;
    } else if ((player == 2 || player == 4) &&
        (board == 1 || board == 3 || board == 0)) {
      return false;
    } else {
      return true;
    }
  }

  bool hasOtherPlayerPieces(List<List<int>> board, int player) {
    final otherPlayer = (player == 1 || player == 3) ? [2, 4] : [1, 3];
    for (var row in board) {
      for (var value in row) {
        if (value == otherPlayer[0] || value == otherPlayer[1]) {
          return true;
        }
      }
    }
    return false;
  }

  void emitSuccess(List<List<int>> board, DamaEntity dama) {
    // final playerOne = value.damasEntity.playerOne;
    final newEntity =
        value.damasEntity.copyWith(board: board, damaEntity: dama);
    value = DamasSuccess(damasEntity: newEntity);
  }

  void emitError(String error) {
    value = DamasError(damasEntity: value.damasEntity, error: error);
  }

  void restart() async => value =
      DamasInit(damasEntity: await GetDefaultEntity.call(section, player));
}
