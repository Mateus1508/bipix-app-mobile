import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bipixapp/models/board.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../widgets/board_widget.dart';
import 'login_call.dart';

// void main() {
//   runApp(const GamePage());
// }

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.sectionId});
  final String sectionId;
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  Board board = Board(size: 3);

  String userId = "";

  @override
  void initState() {
    super.initState();
    board = Board(size: 3);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> sectionSnapshot() async* {
    userId = await Webservice.getUserId();
    await for (var section in FirebaseFirestore.instance
        .collection("sections")
        .doc(widget.sectionId)
        .snapshots()) {
      yield section;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF0472E8),
        title: const Text('Jogo da Velha'),
        centerTitle: true,
        leading: Image.asset('assets/images/bipixLogo.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      backgroundColor: const Color(0XFF00bbf9),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: sectionSnapshot(),
          builder: (context, sectionSnap) {
            if (sectionSnap.hasData) {
              Map<String, dynamic> section = sectionSnap.data!.data()!;
              // List<QueryDocumentSnapshot<Map<String, dynamic>>> moves =
              //     sectionSnap.data!["moves"].docs;
              bool isAdmin = section["admin_id"] == userId;
              // setBoard(moves);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: section["player_turn"] == userId
                          ? const Color(0XFF0472E8)
                          : Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      section["player_turn"] == userId
                          ? 'Sua vez'
                          : 'Vez do ${section["invited_name"]}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: BoardWidget(
                        board: board,
                        myTurn: section["player_turn"] == userId,
                        section: section,
                        isAdmin: isAdmin,
                        userId: userId,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/call');
          if (ZegoUIKitPrebuiltCallMiniOverlayMachine().isMinimizing) {
            /// When the application is minimized (in a minimized state),
            /// Disable button clicks to prevent multiple ZegoUIKitPrebuiltCall components from being created.
            return;
          }
        },
        child: const Icon(
          Icons.video_call_outlined,
          color: Colors.blue,
        ),
      ),
    );
  }
}
