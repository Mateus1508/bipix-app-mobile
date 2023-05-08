import 'dart:async';
import 'package:bipixapp/pages/InitialScreen.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Aguarda 2 segundos antes de abrir a tela de login
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InitialScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
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
              .scaleXY(begin: 0, end: 1.5)
              .then(delay: 500.ms)
              .flipV(
                begin: 2,
                end: 1,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 1.5, end: 0),
        ),
      ),
    );
  }
}
