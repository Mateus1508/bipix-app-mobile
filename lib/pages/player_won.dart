import 'package:bipixapp/app/modules/velha/velha_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/webservice.dart';
import '../widgets/load_overlay.dart';

class PlayerWon extends StatefulWidget {
  const PlayerWon({super.key, required this.sectionId});

  final String sectionId;

  @override
  State<PlayerWon> createState() => _PlayerWonState();
}

class _PlayerWonState extends State<PlayerWon> {
  bool allowed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("sections")
                  .doc(widget.sectionId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.data!.get("status") == "IN_PROGRESS") {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => VelhaModule()));
                  });
                }
                if (snapshot.data!.get("status") == "FINISHED") {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                          'assets/images/games_logos/tic_tac_toe.png'),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'VITÓRIAAA',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: snapshot.data!.get("allow_rematch")
                          ? null
                          : () async {
                              try {
                                allowed = true;
                                await FirebaseFirestore.instance
                                    .collection("sections")
                                    .doc(widget.sectionId)
                                    .update({"allow_rematch": true});
                              } catch (e) {
                                allowed = false;
                                setState(() {});
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Permitir revanche',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        OverlayEntry entry = LoadOverlay.load();
                        Overlay.of(context).insert(entry);
                        try {
                          await Webservice.post(function: "endSection", body: {
                            "sectionId": widget.sectionId,
                          });
                        } catch (e) {
                          if (kDebugMode) {
                            print("E: $e");
                          }
                        }
                        entry.remove();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF0472E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Voltar para o Início',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
