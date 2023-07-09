import 'package:cloud_firestore/cloud_firestore.dart';

import 'damas_entity.dart';
import 'get_default_board.dart';

class GetDefaultEntity {
  static Future<DamasEntity> call(
      Map<String, dynamic> section, int player) async {
    final board = GetDefaultBoard.call();

    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    final sectionRef = instance.collection("sections").doc(section["id"]);

    for (int i = 0; i < board.length; i++) {
      batch.update(
        sectionRef.collection("board").doc(i.toString()),
        {"value": board[i]},
      );
    }
    await batch.commit();

    return DamasEntity(
      section: section,
      board: board,
      player: player,
      // playerOne: true // true = player 1, false = player 2
    );
  }
}
