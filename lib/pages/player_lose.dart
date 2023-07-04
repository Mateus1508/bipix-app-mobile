// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app/modules/velha/velha_module.dart';
import '../services/webservice.dart';
import '../widgets/load_overlay.dart';

class PlayerLose extends StatelessWidget {
  const PlayerLose({super.key, required this.section, required this.looserId});

  final Map<String, dynamic> section;

  final String looserId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/games_logos/tic_tac_toe.png'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Vamos tentar de novo ?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("sections")
                      .doc(section["id"])
                      .snapshots(),
                  builder: (context, sectionSnap) {
                    if (sectionSnap.hasData &&
                        sectionSnap.data!.get("status") == "IN_PROGRESS") {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VelhaModule()));
                      });
                      return Container();
                    }
                    return ElevatedButton(
                      onPressed: sectionSnap.hasData
                          ? (sectionSnap.data!.data())!["allow_rematch"] ||
                                  looserId == ""
                              ? () async {
                                  OverlayEntry entry = LoadOverlay.load();
                                  Overlay.of(context).insert(entry);
                                  final instance = FirebaseFirestore.instance;
                                  final batch = instance.batch();
                                  DocumentReference sectionRef = instance
                                      .collection("sections")
                                      .doc(section["id"]);
                                  QuerySnapshot movesQue = await sectionRef
                                      .collection("moves")
                                      .get();
                                  for (DocumentSnapshot doc in movesQue.docs) {
                                    batch.delete(doc.reference);
                                  }
                                  batch.update(sectionRef, {
                                    "status": "IN_PROGRESS",
                                    "winner_id": null,
                                    "looser_id": null,
                                    "allow_rematch": false,
                                  });
                                  await batch.commit();
                                  entry.remove();
                                }
                              : null
                          : null,
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
                        'Revanche',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  OverlayEntry entry = LoadOverlay.load();
                  Overlay.of(context).insert(entry);
                  try {
                    Webservice.post(function: "endSection", body: {
                      "sectionId": section["id"],
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print("E: $e");
                    }
                  }
                  Navigator.pushNamed(context, '/home');
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
          ),
        ),
      ),
    );
  }
}
