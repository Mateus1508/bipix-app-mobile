import 'package:bipixapp/services/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() async {
    await Future.delayed(2.seconds);
    try {
      await Webservice.getUserId();
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      Navigator.pushNamed(context, "/initial");
    }
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
