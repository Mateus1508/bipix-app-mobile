import 'dart:async';

import 'package:bipixapp/models/board.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../services/utilities.dart';
import '../../../services/webservice.dart';
import '../../../widgets/load_overlay.dart';

part 'velha_store.g.dart';

class VelhaStore = _VelhaStoreBase with _$VelhaStore;

abstract class _VelhaStoreBase with Store {
  @observable
  String sectionId = "";
  @observable
  String userId = "";
  @observable
  bool gameLoaded = false;
  @observable
  bool gameOver = false;
  @observable
  ObservableMap<String, dynamic> section = <String, dynamic>{}.asObservable();
  @observable
  ObservableList<Map<String, dynamic>> moves =
      <Map<String, dynamic>>[].asObservable();
  @observable
  Board board = Board(size: 3);
  @observable
  StreamSubscription? sectionSubscription;
  @observable
  StreamSubscription? movesSubscription;

  bool get myTurn => section["player_turn"] == userId;

  bool get isAdmin => section["admin_id"] == userId;

  @action
  Future<void> getSectionId() async {
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    sectionId = userDoc.get("current_section_id");
  }

  @action
  void setSectionSubscription() {
    sectionSubscription = FirebaseFirestore.instance
        .collection("sections")
        .doc(sectionId)
        .snapshots()
        .listen((sectionListen) {
      print("@@@@@@@@@ sectionSubscripation");

      // Map<String, dynamic> sectionData = ;

      section = sectionListen.data()!.asObservable();
    });
  }

  @action
  setMovesSubscription() {
    movesSubscription = FirebaseFirestore.instance
        .collection("sections")
        .doc(sectionId)
        .collection("moves")
        .snapshots()
        .listen((movesListen) {
      print("@@@@@@@@@ movesSubscripation");

      moves = movesListen.docs.map((doc) => doc.data()).toList().asObservable();

      if (!gameLoaded) gameLoaded = true;
    });
  }

  Map<String, dynamic> setBoard(List<Map<String, dynamic>> moves) {
    for (Map<String, dynamic> move in moves) {
      board.cells[move["row"]][move["col"]].value = move["player"];
      board.cells[move["row"]][move["col"]].isFilled = true;
      String winner = board.checkWinner();
      gameOver = winner.isNotEmpty;

      if (gameOver) {
        String winnerId = "";

        String looserId = "";

        if (winner != "draw") {
          winnerId = section["admin_player"] == winner
              ? section["admin_id"]
              : section["invited_id"];
          looserId = section["admin_player"] == winner
              ? section["invited_id"]
              : section["admin_id"];
        } else {
          winnerId = "";
          looserId = "";
        }

        gameOver = false;
        return {
          "gameOver": true,
          "winnerId": winnerId,
          "looserId": looserId,
        };
      }
    }

    return {
      "gameOver": false,
    };
  }

  @action
  Future<void> updateCellValue(int row, int col, context) async {
    OverlayEntry entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);
    if (!gameOver && board.cells[row][col].value.isEmpty) {
      final instance = FirebaseFirestore.instance;
      final batch = instance.batch();
      DocumentReference sectionRef = instance.collection("sections").doc(
            section["id"],
          );
      batch.update(sectionRef, {
        "player_turn": isAdmin ? section["invited_id"] : section["admin_id"],
      });
      DocumentReference moveRef = sectionRef.collection("moves").doc();
      String player =
          isAdmin ? section["admin_player"] : section["invited_player"];
      Map<String, dynamic> moveData = {
        "id": moveRef.id,
        "created_at": FieldValue.serverTimestamp(),
        "user_id": userId,
        "row": row,
        "col": col,
        "player": player,
      };
      final newMoves = moves;
      newMoves.add(moveData);
      Map<String, dynamic> boardResult = setBoard(newMoves);
      if (boardResult["gameOver"]) {
        Webservice.post(function: "endGame", body: {
          "sectionId": section["id"],
          "winnerId": boardResult["winnerId"],
          "looserId": boardResult["looserId"],
        });
      }
      batch.set(moveRef, moveData);
      await batch.commit();
    }
    entry.remove();
  }

  @action
  bool exitGame(context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          title: Text("Sair do jogo?"),
          content: Text(
            "Você deseja sair do jogo?",
            style: getStyles(context).displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                endSection(context);
              },
              child: Text("Sim"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não"),
            ),
          ],
        );
      },
    );
    return false;
  }

  @action
  Future<void> endSection(BuildContext context) async {
    OverlayEntry entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);
    try {
      await Webservice.post(function: "endSection", body: {
        "sectionId": sectionId,
      });
      // disposeGame();
    } catch (e) {
      if (kDebugMode) {
        print("E: $e");
      }
    }
    Navigator.pushReplacementNamed(context, "/home");
    entry.remove();
  }

  @action
  Future loadGame() async {
    userId = await Webservice.getUserId();
    await getSectionId();
    setSectionSubscription();
    setMovesSubscription();
  }

  @action
  void disposeGame() {
    sectionSubscription?.cancel();
    movesSubscription?.cancel();
    board = Board(size: 3);
    gameLoaded = false;
    moves.clear();
  }
}
