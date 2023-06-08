import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/initial_screen.dart';
import '../pages/nav_bar.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool loaded = false;
  @override
  void initState() {
    Future.delayed(3.seconds, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => loaded ? BottomBar() : InitialScreen()));
    });
    Future(() async {
      String? userId =
          (await SharedPreferences.getInstance()).getString("USER_ID");
      if (userId != null) loaded = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/bipixLogo.png')
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .flipH(
                begin: 1,
                end: 2,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 1, end: 1.5)
              .then(delay: 500.ms)
              .flipV(
                begin: 2,
                end: 1,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 1.5, end: 1),
        ),
      ),
    );
  }
}
