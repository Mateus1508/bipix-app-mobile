import 'package:flutter/material.dart';

import '../../../_exports.dart';

class IsValidMoveEvent {
  static bool call(DamasLogic damasLogic, int startX, int startY, int endX,
      int endY, int player) {
    debugPrint('isValidMove foi chamada');
    final board = damasLogic.value.damasEntity.board;
    final playerOne = damasLogic.value.damasEntity.playerOne;

    // Se não é a vez do jogador, retornar false
    if (player == 1 && !playerOne || player == 2 && playerOne) {
      return false;
    }

    int dx = endX > startX ? 1 : -1;
    int dy = endY > startY ? 1 : -1;

    if (board[startY][startX] < 3) {
      if (player == 1) {
        if (endY - startY == 1 &&
            (endX - startX == 1 || endX - startX == -1) &&
            damasLogic.isWithinBoard(endX, endY) &&
            board[endY][endX] == 0) {
          return true;
        }
        if (endY - startY == 2 &&
            (endX - startX == 2 || endX - startX == -2) &&
            damasLogic.isWithinBoard(endX, endY) &&
            damasLogic.isWithinBoard(
                startX + (endX - startX) ~/ 2, startY + 1) &&
            board[endY][endX] == 0 &&
            board[startY + 1][startX + (endX - startX) ~/ 2] == 2) {
          return true;
        }
      } else if (player == 2) {
        if (startY - endY == 1 &&
            (endX - startX == 1 || endX - startX == -1) &&
            damasLogic.isWithinBoard(endX, endY) &&
            board[endY][endX] == 0) {
          return true;
        }
        if (startY - endY == 2 &&
            (endX - startX == 2 || endX - startX == -2) &&
            damasLogic.isWithinBoard(endX, endY) &&
            damasLogic.isWithinBoard(
                startX + (endX - startX) ~/ 2, startY - 1) &&
            board[endY][endX] == 0 &&
            board[startY - 1][startX + (endX - startX) ~/ 2] == 1) {
          return true;
        }
      }
    } else {
      if ((endX - startX).abs() == (endY - startY).abs() &&
          damasLogic.isWithinBoard(endX, endY)) {
        int opponentPieceCount = 0;
        bool hasEmptyAfterOpponent = false;
        for (int i = startX + dx, j = startY + dy;
            i != endX && j != endY;
            i += dx, j += dy) {
          if (board[j][i] != 0) {
            if (board[j][i] % 2 == player % 2) {
              return false; // caminho bloqueado por peça do mesmo jogador
            } else {
              opponentPieceCount++;
              if (opponentPieceCount > 1) {
                return false; // mais de uma peça do oponente no caminho
              }
            }
          } else if (opponentPieceCount == 1) {
            hasEmptyAfterOpponent = true;
          }
        }
        if (opponentPieceCount == 1 && !hasEmptyAfterOpponent) {
          return false; // Não houve captura de peça oponente
        }
        return true; // caminho livre ou apenas uma peça do oponente capturada
      }
    }

    return false;
  }
}
