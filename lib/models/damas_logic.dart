import 'package:flutter/foundation.dart';

class GameLogic {
  List<List<int>> board = [
    [0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [2, 0, 2, 0, 2, 0, 2, 0],
    [0, 2, 0, 2, 0, 2, 0, 2],
    [2, 0, 2, 0, 2, 0, 2, 0],
  ];

  bool isWithinBoard(int x, int y) {
    return x >= 0 && x < 8 && y >= 0 && y < 8;
  }

  bool playerTurn = true; // true = player 1, false = player 2

  bool isValidMove(int startX, int startY, int endX, int endY, int player) {
    // print('isValidMove foi chamada');

    // Se não é a vez do jogador, retornar false
    if (player == 1 && !playerTurn || player == 2 && playerTurn) {
      return false;
    }

    if (player == 1) {
      if (endY - startY == 1 &&
          (endX - startX == 1 || endX - startX == -1) &&
          board[endY][endX] == 0) {
        return true;
      }
      if (endY - startY == 2 &&
          (endX - startX == 2 || endX - startX == -2) &&
          board[endY][endX] == 0 &&
          board[startY + 1][startX + (endX - startX) ~/ 2] == 2) {
        return true;
      }
    } else if (player == 2) {
      if (startY - endY == 1 &&
          (endX - startX == 1 || endX - startX == -1) &&
          board[endY][endX] == 0) {
        return true;
      }
      if (startY - endY == 2 &&
          (endX - startX == 2 || endX - startX == -2) &&
          board[endY][endX] == 0 &&
          board[startY - 1][startX + (endX - startX) ~/ 2] == 1) {
        return true;
      }
    }

    return false;
  }

  bool isPromoted(int y, int x) {
    return false;
  }

// Verificar se há possibilidade de captura
  bool canCapture(int startX, int startY, int player) {
    if (kDebugMode) {
      print('canCapture foi chamada');
    }
    List<List<int>> directions = [
      [2, 2],
      [2, -2],
      [-2, 2],
      [-2, -2]
    ];

    for (List<int> direction in directions) {
      int endX = startX + direction[0];
      int endY = startY + direction[1];
      if (isWithinBoard(endX, endY) &&
          isValidMove(startX, startY, endX, endY, player)) {
        return true;
      }
    }

    return false;
  }

// Realizando a sequência de capturas
  void captureSequence(int startX, int startY, int player) {
    if (kDebugMode) {
      print('captureSequence foi chamada');
    }
    // Verificar todas as direções possíveis para uma captura
    List<List<int>> directions = [
      [2, 2],
      [2, -2],
      [-2, 2],
      [-2, -2]
    ];

    bool hasCaptured = false;
    int endX = -1, endY = -1;

    for (List<int> direction in directions) {
      endX = startX + direction[0];
      endY = startY + direction[1];

      // Se puder capturar nesta direção, faça a captura e continue a sequência
      if (endX >= 0 &&
          endX < 8 &&
          endY >= 0 &&
          endY < 8 &&
          isValidMove(startX, startY, endX, endY, player)) {
        makeMove(startX, startY, endX, endY, player);
        hasCaptured = true;
        break;
      }
    }

    // Se a peça fez uma captura, então verifique novamente para outra possível captura
    if (hasCaptured) {
      captureSequence(endX, endY, player);
    }
  }

  void makeMove(int startX, int startY, int endX, int endY, int player) {
    if (kDebugMode) {
      print('makeMove foi chamada');
    }

    playerTurn = !playerTurn;
    board[endY][endX] = player;
    board[startY][startX] = 0;
    if (player == 1 && endY - startY == 2) {
      board[startY + (endY - startY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    } else if (player == 2 && startY - endY == 2) {
      board[startY - (startY - endY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    }
  }
}
