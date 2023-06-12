import 'package:bipixapp/widgets/zoomWidget/call_screen.dart';
import 'package:bipixapp/widgets/zoomWidget/intro_screen.dart';
import 'package:bipixapp/widgets/zoomWidget/join_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';

class ZoomVideoSdkProvider extends StatelessWidget {
  const ZoomVideoSdkProvider({super.key});

  @override
  Widget build(BuildContext context) {
    var zoom = ZoomVideoSdk();
    InitConfig initConfig = InitConfig(
      domain: "zoom.us",
      enableLog: true,
    );
    zoom.initSdk(initConfig);
    return const SafeArea(
      child: IntroScreen(),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'My Appp', // used by the OS task switcher
      home: const SafeArea(
        child: ZoomVideoSdkProvider(),
      ),
      routes: {
        "Join": (context) => const JoinScreen(),
        "Call": (context) => const CallScreen(),
        "Intro": (context) => const IntroScreen(),
      },
    ),
  );
}
