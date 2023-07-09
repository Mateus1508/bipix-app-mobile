import 'package:bipixapp/app/modules/dama/services/damas_entity.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dama_entity.dart';
import 'damas_logic.dart';

class MoveEvent {
  static void call(
    DamasLogic damasLogic,
    int endX,
    int endY, {
    DamaEntity? damaEntity,
  }) async {
    Future<void> updateBoard(
      List<List<int>> board,
    ) async {
      final instance = FirebaseFirestore.instance;
      final batch = instance.batch();
      final sectionRef =
          instance.collection("sections").doc(damasLogic.section["id"]);
      batch.update(sectionRef, {
        "player_turn": damasLogic.oponentId,
      });
      for (int i = 0; i < board.length; i++) {
        batch.update(sectionRef.collection("board").doc(i.toString()),
            {"value": board[i]});
      }
      await batch.commit();
    }

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

      updateBoard(board);

      if (damasLogic.hasOtherPlayerPieces(board, player)) {
        damasLogic.value = DamasSuccess(
            damasEntity: damasLogic.value.damasEntity.copyWith(
          board: newBoard,
        ));
      } else {
        damasLogic.value = DamasFinish(
            damasEntity: damasLogic.value.damasEntity,
            message: 'O player $player ganho');

        Webservice.post(function: "endGame", body: {
          "sectionId": damasLogic.section["id"],
          "winnerId":
              damasLogic.section[player == 1 ? "admin_id" : "invited_id"],
          "looserId":
              damasLogic.section[player != 1 ? "admin_id" : "invited_id"],
        });
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
