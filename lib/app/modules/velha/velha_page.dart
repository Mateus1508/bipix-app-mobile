import 'package:bipixapp/app/modules/velha/velha_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../pages/player_lose.dart';
import '../../../pages/player_won.dart';
import 'widgets/board_widget.dart';

class VelhaPage extends StatefulWidget {
  const VelhaPage({super.key});

  @override
  VelhaPageState createState() => VelhaPageState();
}

class VelhaPageState extends State<VelhaPage> {
  final VelhaStore store = Modular.get();

  @override
  void initState() {
    store.loadGame();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => store.exitGame(context),
      child: Scaffold(
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
          child: Observer(
            builder: (context) {
              print("############# SectionObserver");
              if (store.section.isNotEmpty) {
                if (store.section["status"] == "GAME-FINISHED") {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            store.section["winner_id"] == store.userId
                                ? PlayerWon(
                                    sectionId: store.section["id"],
                                  )
                                : PlayerLose(
                                    section: store.section,
                                    looserId: store.section["looser_id"],
                                  ),
                      ),
                    ).then((value) => store.disposeGame());
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color:
                            store.myTurn ? const Color(0XFF0472E8) : Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        store.myTurn
                            ? 'Sua vez'
                            : 'Vez do ${store.isAdmin ? store.section["invited_username"] : store.section["admin_username"]}',
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
                          store: store,
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
      ),
    );
  }
}
