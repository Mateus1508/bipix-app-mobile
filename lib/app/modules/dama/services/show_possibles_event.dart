import 'dama_entity.dart';
import 'damas_logic.dart';
import 'move_event.dart';

class ShowPossiblesEvent {
  static call(DamasLogic damasLogic, int startX, int startY, int player) {
    int newerMoviment = 0;
    List<int> pointCapture = [];
    damasLogic.value = DamasLoading(damasEntity: damasLogic.value.damasEntity);
    final board = damasLogic.value.damasEntity.board;
    final dama = DamaEntity(startX, startY, player);
    final endsX =
        player >= 3 ? [startX + 1, startX - 1] : [startX + 1, startX - 1];
    final endY = player == 1 ? startY + 1 : startY - 1;
    final captureEndY = player == 1 ? startY - 1 : startY + 1;
    final finalY = player == 1 ? startY + 2 : startY - 2;
    final captureFinalY = player == 1 ? startY - 2 : startY + 2;
    for (final possible in endsX) {
      if (damasLogic.isWithinBoard(possible, endY)) {
        final local = board[endY][possible];
        final isPlayer = damasLogic.checkPlayer(player, local);
        if (local == 0) {
          board[endY][possible] = 5;
        } else if (local != 0 && !isPlayer) {
          final isRight = possible > startX;
          final finalX = isRight ? possible + 1 : possible - 1;
          if (damasLogic.isWithinBoard(finalX, finalY)) {
            final emptyBoard = board[finalY][finalX] == 0;
            if (emptyBoard) {
              // board[finalY][finalX] = 5;
              pointCapture.add(finalX);
              pointCapture.add(finalY);
            } else {
              newerMoviment = newerMoviment + 1;
            }
          } else {
            newerMoviment = newerMoviment + 1;
          }
        } else {
          newerMoviment = newerMoviment + 1;
        }
      } else {
        damasLogic.emitError('Nenhum movimento possível');
      }
    }

    for (final possible in endsX) {
      if (damasLogic.isWithinBoard(possible, captureEndY)) {
        final local = board[captureEndY][possible];
        final isRight = possible > startX;
        final finalX = isRight ? possible + 1 : possible - 1;
        if (damasLogic.isWithinBoard(finalX, captureFinalY)) {
          final localFinal = board[captureFinalY][finalX];
          final isPlayer = damasLogic.checkPlayer(player, local);
          if (!isPlayer && localFinal == 0 && local != 0) {
            pointCapture.add(finalX);
            pointCapture.add(captureFinalY);
          }
        }
      }
    }

    if (pointCapture.isNotEmpty) {
      MoveEvent.call(damasLogic, pointCapture[0], pointCapture[1],
          damaEntity: dama);
    } else {
      if (newerMoviment > 1) {
        damasLogic.emitError('Nenhum movimento possível');
      } else {
        damasLogic.emitSuccess(board, dama);
      }
    }
  }
}
