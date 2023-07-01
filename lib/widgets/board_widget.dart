import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/load_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bipixapp/models/board.dart';

class BoardWidget extends StatefulWidget {
  final Board board;

  final bool myTurn;

  final bool isAdmin;

  final Map<String, dynamic> section;

  final String userId;

  // final void Function() onMove;

  const BoardWidget({
    super.key,
    required this.board,
    required this.myTurn,
    required this.section,
    required this.isAdmin,
    required this.userId,
    // required this.onMove,
  });

  @override
  BoardWidgetState createState() => BoardWidgetState();
}

class BoardWidgetState extends State<BoardWidget> {
  bool gameOver = false;

  void updateCellValue(int row, int col) async {
    OverlayEntry entry = LoadOverlay.load();
    Overlay.of(context).insert(entry);
    if (!gameOver && widget.board.cells[row][col].value.isEmpty) {
      DocumentReference sectionRef = FirebaseFirestore.instance
          .collection("sections")
          .doc(widget.section["id"]);
      await sectionRef.update({
        "player_turn": widget.isAdmin
            ? widget.section["invited_id"]
            : widget.section["admin_id"],
      });
      DocumentReference moveRef = sectionRef.collection("moves").doc();
      String player = widget.isAdmin
          ? widget.section["admin_player"]
          : widget.section["invited_player"];
      await moveRef.set({
        "id": moveRef.id,
        "created_at": FieldValue.serverTimestamp(),
        "user_id": widget.userId,
        "row": row,
        "col": col,
        "player": player,
      });
      // widget.onMove();
    }
    entry.remove();
  }

  setBoard(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    for (DocumentSnapshot doc in docs) {
      widget.board.cells[doc.get("row")][doc.get("col")].value =
          doc.get("player");
      widget.board.cells[doc.get("row")][doc.get("col")].isFilled = true;
      String winner = widget.board.checkWinner();
      gameOver = winner.isNotEmpty;

      if (gameOver) {
        String winnerId = "";

        String looserId = "";

        if (winner != "draw") {
          winnerId = widget.section["admin_player"] == winner
              ? widget.section["admin_id"]
              : widget.section["invited_id"];
          looserId = widget.section["admin_player"] == winner
              ? widget.section["invited_id"]
              : widget.section["admin_id"];
        } else {
          winnerId = "";
          looserId = "";
        }

        Webservice.post(function: "endGame", body: {
          "sectionId": widget.section["id"],
          "winnerId": winnerId,
          "looserId": looserId,
        });
        // Verifica se há um vencedor e navega para a tela playerlose
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => winnerId == widget.userId
        //             ? PlayerWon(
        //                 sectionId: widget.section["id"],
        //               )
        //             : PlayerLose(
        //                 section: widget.section,
        //               )),
        //   );
        // });
        gameOver = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("sections")
            .doc(widget.section["id"])
            .collection("moves")
            .snapshots(),
        builder: (context, movesSnap) {
          if (movesSnap.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> moves =
                movesSnap.data!.docs;
            if (widget.section["status"] != "GAME-FINISHED") {
              setBoard(moves);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.board.size,
              ),
              itemCount: widget.board.size * widget.board.size,
              itemBuilder: (context, index) {
                final row = index ~/ widget.board.size;
                final col = index % widget.board.size;
                final cell = widget.board.cells[row][col];

                return GestureDetector(
                  onTap: () => widget.myTurn ? updateCellValue(row, col) : null,
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0XFF0472E8), width: 15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: cell.value != ""
                            ? Image.asset(
                                "assets/images/tic_tac_toe/${cell.value}.png")
                            : null,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
