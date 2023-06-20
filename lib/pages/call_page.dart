import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../services/webservice.dart';
import 'constants.dart';

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key, required this.callID, required this.currentSectionID})
      : super(key: key);

  final String callID;
  final String currentSectionID;

  Future<Map<String, dynamic>> getUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('sections')
        .doc(currentSectionID)
        .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final sessionID = userData['id'];
          final userName = userData['admin_name'];

          return ZegoUIKitPrebuiltCall(
            appID: VideoConst.appId,
            appSign: VideoConst.appSign,
            userID: sessionID,
            userName: userName,
            callID: sessionID,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              ..topMenuBarConfig.isVisible = true
              ..topMenuBarConfig.buttons = [
                ZegoMenuBarButtonName.minimizingButton,
                ZegoMenuBarButtonName.showMemberListButton,
              ],
          );
        } else {
          return Text('Erro ao obter os dados do usuário.');
        }
      },
    );
  }
}
