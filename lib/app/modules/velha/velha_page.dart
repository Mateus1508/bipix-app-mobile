import 'package:bipixapp/app/modules/velha/velha_store.dart';
import 'package:bipixapp/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../pages/constants.dart';
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
    store.loadGame(context);
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
          backgroundColor: const Color(0XFF171A1D),
          title: const Text('Jogo da Velha'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                store.exitGame(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: const Color(0XFF3C4FFA),
        body: Center(
          child: Observer(
            builder: (context) {
              print("############# SectionObserver");
              if (store.section.isNotEmpty) {
                if (store.section["status"] == "SEARCHING") {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Aguardando jogador"),
                      vSpace(40),
                      CircularProgressIndicator(),
                    ],
                  );
                }
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
                if (store.section["status"] == "FINISHED") {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.pushReplacementNamed(context, "/home");
                    store.disposeGame();
                  });
                }
                return SizedBox(
                  width: maxWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 250,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ZegoUIKitPrebuiltCall(
                                    appID: VideoConst.appId,
                                    appSign: VideoConst.appSign,
                                    userID: store.userId,
                                    userName: store.section[store.isAdmin
                                        ? "admin_username"
                                        : "invited_username"],
                                    callID: store.sectionId,
                                    config: ZegoUIKitPrebuiltCallConfig
                                        .oneOnOneVideoCall()
                                      // ..topMenuBarConfig.isVisible = true
                                      // ..topMenuBarConfig.buttons = [
                                      //   ZegoMenuBarButtonName.minimizingButton,
                                      //   ZegoMenuBarButtonName.showMemberListButton,
                                      // ]
                                      ..bottomMenuBarConfig.buttons = []
                                      ..onOnlySelfInRoom = (context) {
                                        if (PrebuiltCallMiniOverlayPageState
                                                .idle !=
                                            ZegoUIKitPrebuiltCallMiniOverlayMachine()
                                                .state()) {
                                          ZegoUIKitPrebuiltCallMiniOverlayMachine()
                                              .changeState(
                                                  PrebuiltCallMiniOverlayPageState
                                                      .idle);
                                        } else {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: store.myTurn
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  hSpace(5),
                                  Text(
                                    store.myTurn
                                        ? 'Sua jogada'
                                        : 'Vez do ${store.isAdmin ? store.section["invited_username"] : store.section["admin_username"]}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          height: 300,
                          width: 300,
                          child: BoardWidget(
                            store: store,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 80),
          child: FloatingActionButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/call');
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
      ),
    );
  }
}
