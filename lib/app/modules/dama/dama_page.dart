import 'package:bipixapp/app/modules/dama/dama_store.dart';
import 'package:bipixapp/pages/nav_bar.dart';
import 'package:bipixapp/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'widgets/board_widget.dart';
import 'widgets/restart_button.dart';
import 'widgets/turn_widget.dart';

class DamaPage extends StatefulWidget {
  const DamaPage({super.key});

  @override
  _DamaPageState createState() => _DamaPageState();
}

class _DamaPageState extends State<DamaPage> {
  final DamaStore store = Modular.get();

  @override
  void initState() {
    store.loadGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => store.exitGame(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF0472E8),
          title: const Text('Jogo de Damas'),
        ),
        backgroundColor: Colors.white,
        body: Observer(
          builder: (context) {
            if (store.gameStatus == "LOADING" || store.damasLogic == null) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (store.gameStatus == "SEARCHING") ...[
                    Text("Aguardando outro jogador"),
                    vSpace(40),
                  ],
                  CircularProgressIndicator(),
                ],
              ));
            }
            if (store.section["status"] == "FINISHED") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBar(),
                    ));
              });
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TurnWidget(damasLogic: store.damasLogic!, store: store),
                    const SizedBox(height: 30),
                    BoardWidget(damasLogic: store.damasLogic!),
                    const SizedBox(height: 30),
                    RestartButton(damasLogic: store.damasLogic!),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/call');
            if (ZegoUIKitPrebuiltCallMiniOverlayMachine().isMinimizing) {
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
