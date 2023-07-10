import 'dart:async';

import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../services/utilities.dart';
import '../../../widgets/load_overlay.dart';
import 'services/damas_logic.dart';

part 'dama_store.g.dart';

class DamaStore = _DamaStoreBase with _$DamaStore;

abstract class _DamaStoreBase with Store {
  @observable
  String sectionId = "";
  @observable
  ObservableMap<String, dynamic> section = <String, dynamic>{}.asObservable();
  @observable
  String gameStatus = "LOADING";
  @observable
  ObservableList<List<int>> board =
      <List<int>>[[], [], [], [], [], [], [], []].asObservable();
  @observable
  String userId = "";
  @observable
  DamasLogic? damasLogic;
  @observable
  StreamSubscription? _sectionSubscription;
  @observable
  StreamSubscription? _boardSubscription;

  bool get myTurn => section["player_turn"] == userId;

  bool get isAdmin => section["admin_id"] == userId;

  String get oponentUsername =>
      section[isAdmin ? "invited_username" : "admin_username"];

  @action
  Future<void> getSectionId() async {
    final userDoc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    sectionId = userDoc.get("current_section_id");
  }

  @action
  void setSectionSubscription() {
    _sectionSubscription = FirebaseFirestore.instance
        .collection("sections")
        .doc(sectionId)
        .snapshots()
        .listen((sectionListen) {
      print("@@@@@@@@@ sectionSubscripation");

      Map<String, dynamic> sectionData = sectionListen.data()!;

      section = sectionData.asObservable();

      if (sectionListen.get("status") == "SEARCHING") {
        gameStatus = "SEARCHING";
      } else {
        gameStatus = "LOADED";
      }

      if (_boardSubscription == null && gameStatus == "LOADING" ||
          gameStatus == "LOADED") {
        setBoardSubscription();
      }
    });
  }

  @action
  setBoardSubscription() {
    _boardSubscription = FirebaseFirestore.instance
        .collection("sections")
        .doc(sectionId)
        .collection("board")
        .snapshots()
        .listen((boardListen) {
      print("@@@@@@@@@ boardSubscripation");
      for (int i = 0; i < boardListen.docs.length; i++) {
        board[i] = boardListen.docs[i].get("value").cast<int>();
      }
      if (section["status"] == "IN_PROGRESS") {
        damasLogic = DamasLogic(
          section,
          board.toList(),
          userId,
          int.parse(section[isAdmin ? "admin_player" : "invited_player"]),
          section[isAdmin ? "invited_id" : "admin_id"],
        );
      }
      // List<List> newBoard = [[], [], [], [], [], [], [], []];
      // for (int i = 0; i < boardListen.docs.length; i++) {
      //   newBoard[i] = boardListen.docs[i].get("value");
      // }
      // board = newBoard.asObservable();
    });
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
                await endSection(context);
                Navigator.pop(context);
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
    } catch (e) {
      if (kDebugMode) {
        print("E: $e");
      }
    }
    entry.remove();
  }

  @action
  Future loadGame() async {
    userId = await Webservice.getUserId();
    await getSectionId();
    setSectionSubscription();
    // setBoardSubscription();
  }

  @action
  void disposeGame() {
    _sectionSubscription?.cancel();
    _boardSubscription?.cancel();
  }
}
