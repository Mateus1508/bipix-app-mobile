import 'dart:async';

import 'package:bipixapp/models/damas_logic.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../pages/home.dart';
import '../../../services/utilities.dart';
import '../../../widgets/load_overlay.dart';

part 'dama_store.g.dart';

class DamaStore = _DamaStoreBase with _$DamaStore;

abstract class _DamaStoreBase with Store {
  @observable
  String sectionId = "";
  @observable
  ObservableMap<String, dynamic> section = <String, dynamic>{}.asObservable();
  @observable
  bool gameLoaded = false;
  @observable
  ObservableList<List> board = [[], [], [], [], [], [], [], []].asObservable();
  @observable
  String userId = "";
  @observable
  GameLogic? gameLogic;
  @observable
  StreamSubscription? _sectionSubscription;
  @observable
  StreamSubscription? _boardSubscription;

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
    _sectionSubscription = FirebaseFirestore.instance
        .collection("sections")
        .doc(sectionId)
        .snapshots()
        .listen((sectionListen) {
      print("@@@@@@@@@ sectionSubscripation");
      gameLogic ??= GameLogic(
        section: sectionListen.data()!,
        userId: userId,
      );

      Map<String, dynamic> sectionData = sectionListen.data()!;

      section = sectionData.asObservable();

      if (!gameLoaded) gameLoaded = true;
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
        board[i] = boardListen.docs[i].get("value");
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
          title: const Text("Sair do jogo?"),
          content: Text(
            "Você deseja sair do jogo?",
            style: getStyles(context).displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                endSection(context);
              },
              child: const Text("Sim"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Não"),
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
      disposeGame();
    } catch (e) {
      if (kDebugMode) {
        print("E: $e");
      }
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ));
    entry.remove();
  }

  @action
  Future loadGame() async {
    userId = await Webservice.getUserId();
    await getSectionId();
    setSectionSubscription();
    setBoardSubscription();
  }

  @action
  void disposeGame() {
    _sectionSubscription?.cancel();
    _boardSubscription?.cancel();
  }
}
