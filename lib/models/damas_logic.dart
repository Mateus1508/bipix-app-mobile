import 'package:flutter/material.dart';

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

  bool isValidMove(int startX, int startY, int endX, int endY, int player) {
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

  void makeMove(int startX, int startY, int endX, int endY, int player) {
    board[endY][endX] = player;
    board[startY][startX] = 0;

    if (player == 1 && endY - startY == 2) {
      board[startY + (endY - startY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    } else if (player == 2 && startY - endY == 2) {
      board[startY - (startY - endY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    }
  }
}
