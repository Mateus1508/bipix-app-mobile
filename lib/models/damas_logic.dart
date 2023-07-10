import 'package:bipixapp/widgets/load_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class GameLogic {
  GameLogic({required this.section, required this.userId});

  final Map<String, dynamic> section;

  final String userId;

  List<List> board = [[], [], [], [], [], [], [], []];

  // List<List<int>> board = [
  //   [0, 1, 0, 1, 0, 1, 0, 1],
  //   [1, 0, 1, 0, 1, 0, 1, 0],
  //   [0, 1, 0, 1, 0, 1, 0, 1],
  //   [0, 0, 0, 0, 0, 0, 0, 0],
  //   [0, 0, 0, 0, 0, 0, 0, 0],
  //   [2, 0, 2, 0, 2, 0, 2, 0],
  //   [0, 2, 0, 2, 0, 2, 0, 2],
  //   [2, 0, 2, 0, 2, 0, 2, 0],
  // ];

  void mountBoard(List<List> thisBoard) {
    for (int i = 0; i < thisBoard.length; i++) {
      board[i] = thisBoard[i];
    }
  }

  void updateBoard(int x, int y, int val, WriteBatch batch) {
    List line = board[y];
    line[x] = val;
    batch.update(
      FirebaseFirestore.instance
          .collection("sections")
          .doc(section["id"])
          .collection("board")
          .doc(y.toString()),
      {"value": line},
    );
  }

  bool isWithinBoard(int x, int y) {
    return x >= 0 && x < 8 && y >= 0 && y < 8;
  }

  // final String playerTurn; // true = player 1, false = player 2

  bool isValidMove(int startX, int startY, int endX, int endY, int player) {
    // print('isValidMove foi chamada');

    // Se não é a vez do jogador, retornar false
    if (player == 1 && section["player_turn"] != userId ||
        player == 2 && section["player_turn"] == userId) {
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
  void captureSequence(
    int startX,
    int startY,
    int player,
    BuildContext context,
  ) {
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
        makeMove(startX, startY, endX, endY, player, context);
        hasCaptured = true;
        break;
      }
    }

    // Se a peça fez uma captura, então verifique novamente para outra possível captura
    if (hasCaptured) {
      captureSequence(endX, endY, player, context);
    }
  }

  Future makeMove(
    int startX,
    int startY,
    int endX,
    int endY,
    int player,
    BuildContext context,
  ) async {
    final entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);
    if (kDebugMode) {
      print('makeMove foi chamada');
    }
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    final secRef = instance.collection("sections").doc(section["id"]);
    batch.update(secRef, {
      "player_turn": section["player_turn"] == section["admin_id"]
          ? section["invited_id"]
          : section["admin_id"]
    });

    // board[endY][endX] = player;
    updateBoard(endX, endY, player, batch);
    // board[startY][startX] = 0;
    updateBoard(startX, startY, 0, batch);
    if (player == 1 && endY - startY == 2) {
      // board[startY + (endY - startY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
      updateBoard(
        startX + (endX - startX) ~/ 2,
        startY + (endY - startY) ~/ 2,
        0,
        batch,
      );
    } else if (player == 2 && startY - endY == 2) {
      // board[startY - (startY - endY) ~/ 2][startX + (endX - startX) ~/ 2] = 0;
      updateBoard(
        startX + (endX - startX) ~/ 2,
        startY - (startY - endY) ~/ 2,
        0,
        batch,
      );
    }
    await batch.commit();
    entry.remove();
  }
}
