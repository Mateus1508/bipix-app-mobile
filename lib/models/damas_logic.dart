import 'package:flutter/material.dart';

class GameLogic {
  // Lógica do jogo de damas

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
    // Verifica se o movimento é válido para o jogador atual
    // Implemente as regras específicas de movimentação aqui

    if (player == 1) {
      // Movimento diagonal permitido para frente e apenas uma casa
      if (endY - startY == 1 &&
          (endX - startX == 1 || endX - startX == -1) &&
          board[endY][endX] == 0) {
        return true;
      }
      // Captura diagonal permitida para frente
      if (endY - startY == 2 &&
          (endX - startX == 2 || endX - startX == -2) &&
          board[endY][endX] == 0 &&
          board[startY + 1][startX + (endX - startX) ~/ 2] == 2) {
        return true;
      }
    } else if (player == 2) {
      // Movimento diagonal permitido para trás e apenas uma casa
      if (startY - endY == 1 &&
          (endX - startX == 1 || endX - startX == -1) &&
          board[endY][endX] == 0) {
        return true;
      }
      // Captura diagonal permitida para trás
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
    // Executa o movimento no tabuleiro
    board[endY][endX] = player;
    board[startY][startX] = 0;

    // Captura de peça
    if (player == 1 && endY - startY == 2) {
      // Peça do jogador 1 capturou uma peça do jogador 2
      board[startY + (endY - startY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    } else if (player == 2 && startY - endY == 2) {
      // Peça do jogador 2 capturou uma peça do jogador 1
      board[startY - (startY - endY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
    }
  }
}