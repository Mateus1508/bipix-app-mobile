import 'package:flutter/material.dart';

import '../../../_exports.dart';

class MoveEvent {
  static void call(DamasLogic damasLogic, int endX, int endY,
      {DamaEntity? damaEntity}) {
    damasLogic.value = DamasLoading(damasEntity: damasLogic.value.damasEntity);
    debugPrint('move foi chamada');
    final dama = damaEntity ?? damasLogic.value.damasEntity.damaEntity;
    if (dama != null) {
      var board = damasLogic.value.damasEntity.board;

      final player = dama.player;
      final startX = dama.startX;
      final startY = dama.startY;
      board[endY][endX] = player;

      if (damasLogic.shouldBePromoted(endY, player)) {
        board[endY][endX] = player + 2;
      }

      board[startY][startX] = 0;

      final newBoard = removePossibles(board);

      final finalY = endY - startY;
      if ((player == 1 || player == 2) && finalY == 2) {
        newBoard[startY + 1][startX + (endX - startX) ~/ 2] = 0;
      } else if ((player == 1 || player == 2) && finalY == -2) {
        newBoard[startY - 1][startX + (endX - startX) ~/ 2] = 0;
      } else if ((player == 3 || player == 4) && (startY - endY).abs() >= 2) {
        for (int i = 1; i <= (startY - endY).abs() - 1; i++) {
          final finalY = endY > startY ? startY + i : startY - i;
          final finalX = endX > startX ? startX + i : startX - i;
          newBoard[finalY][finalX] = 0;
        }
      }

      if (damasLogic.hasOtherPlayerPieces(board, player)) {
        damasLogic.value = DamasSuccess(
            damasEntity: damasLogic.value.damasEntity.copyWith(
                board: newBoard,
                playerOne: !damasLogic.value.damasEntity.playerOne));
      } else {
        damasLogic.value = DamasFinish(
            damasEntity: damasLogic.value.damasEntity,
            message: 'O player $player ganho');
      }
    }
  }

  static List<List<int>> removePossibles(List<List<int>> board) {
    for (var linha in board) {
      for (var i = 0; i < linha.length; i++) {
        if (linha[i] == 5) {
          linha[i] = 0; // Altera o valor encontrado para o novo valor
        }
      }
    }
    return board;
  }
}
