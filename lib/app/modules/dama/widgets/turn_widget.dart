import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../pages/constants.dart';
import '../../../../services/utilities.dart';
import '../dama_store.dart';
import '../services/damas_logic.dart';

class TurnWidget extends StatelessWidget {
  final DamasLogic damasLogic;
  final DamaStore store;
  const TurnWidget({super.key, required this.damasLogic, required this.store});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DamasState>(
      valueListenable: damasLogic,
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(top: 15, left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ZegoUIKitPrebuiltCall(
                    appID: VideoConst.appId,
                    appSign: VideoConst.appSign,
                    userID: store.userId,
                    userName: store.section[
                        store.isAdmin ? "admin_username" : "invited_username"],
                    callID: store.sectionId,
                    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                      // ..topMenuBarConfig.isVisible = true
                      // ..topMenuBarConfig.buttons = [
                      //   ZegoMenuBarButtonName.minimizingButton,
                      //   ZegoMenuBarButtonName.showMemberListButton,
                      // ]
                      ..bottomMenuBarConfig.buttons = []
                      ..onOnlySelfInRoom = (context) {
                        if (PrebuiltCallMiniOverlayPageState.idle !=
                            ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
                          ZegoUIKitPrebuiltCallMiniOverlayMachine().changeState(
                              PrebuiltCallMiniOverlayPageState.idle);
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
                      color: store.myTurn ? Colors.green : Colors.red,
                    ),
                  ),
                  hSpace(5),
                  Text(
                    store.myTurn
                        ? 'Sua vez'
                        : 'Vez do ${store.oponentUsername}',
                    style: TextStyle(
                      fontSize: 20,
                      color: getColors(context).onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        // return Container(
        //   margin: const EdgeInsets.symmetric(vertical: 40),
        //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //   decoration: BoxDecoration(
        //     color: store.myTurn
        //         ? value.damasEntity.player == 1
        //             ? Colors.brown
        //             : Colors.blue
        //         : value.damasEntity.player == 1
        //             ? Colors.blue
        //             : Colors.brown,
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   child: Text(
        //     store.myTurn ? 'Sua vez' : 'Vez do ${store.oponentUsername}',
        //     style: const TextStyle(
        //       fontSize: 24,
        //       color: Colors.white,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // );
      },
    );
  }
}
