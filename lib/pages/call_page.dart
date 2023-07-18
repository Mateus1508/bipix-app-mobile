import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import '../services/webservice.dart';
import 'constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CallOverlay extends StatefulWidget {
  const CallOverlay({
    Key? key,
    required this.userId,
    required this.username,
    required this.sectionId,
  }) : super(key: key);

  final String userId;
  final String username;
  final String sectionId;

  @override
  _CallOverlayState createState() => _CallOverlayState();
}

class _CallOverlayState extends State<CallOverlay> {
  Stream<Map<String, dynamic>> getUserStream() async* {
    String userId = await Webservice.getUserId();
    await for (final doc in FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()) {
      yield doc.data() ?? {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: VideoConst.appId,
        appSign: VideoConst.appSign,
        userID: widget.userId,
        userName: widget.username,
        callID: widget.sectionId,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              ZegoUIKitPrebuiltCallMiniOverlayMachine()
                  .changeState(PrebuiltCallMiniOverlayPageState.idle);
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}
