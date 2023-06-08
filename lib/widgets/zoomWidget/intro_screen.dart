import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../main.dart';

class JoinArguments {
  final bool isJoin;
  JoinArguments(this.isJoin);
}

class IntroButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final bool isJoin;

  const IntroButton({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.isJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/join", arguments: JoinArguments(isJoin));
      },
      child: Container(
        height: 60.0,
        width: 300.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: buttonColor,
            border: Border.all(
              color: Colors.black12,
              width: 1,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.normal, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  // In Android we need to request the storage permission,
  // while in iOS is the photos permission
  Map<String, List<Permission>> platformPermissions = {
    "ios": [
      Permission.camera,
      Permission.microphone,
      //Permission.photos,
    ],
    "android": [
      Permission.camera,
      Permission.microphone,
      Permission.bluetoothConnect,
      Permission.phone,
      Permission.storage,
    ],
  };

  Future<void> requestFilePermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) {}
    bool blocked = false;
    List<Permission>? notGranted = [];
    List<Permission>? permissions = Platform.isAndroid
        ? platformPermissions["android"]
        : platformPermissions["ios"];
    Map<Permission, PermissionStatus>? statuses = await permissions?.request();
    statuses!.forEach((key, status) {
      if (status.isDenied) {
        blocked = true;
      } else if (!status.isGranted) {
        notGranted.add(key);
      }
    });

    for (var permission in notGranted) {
      await permission.request();
    }

    if (blocked) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    requestFilePermission();
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Center(
                child: IntroButton(
              text: "Create",
              buttonColor: Color(0xff0070f3),
              textColor: Colors.white,
              isJoin: false,
            )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: const Center(
                child: IntroButton(
                    text: "Join",
                    buttonColor: Colors.white,
                    textColor: Color(0xff0070f3),
                    isJoin: true)),
          )
        ],
      ),
    );
  }
}
