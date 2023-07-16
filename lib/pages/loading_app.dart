import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingApp extends StatefulWidget {
  const LoadingApp({super.key});

  @override
  LoadingAppState createState() => LoadingAppState();
}

class LoadingAppState extends State<LoadingApp>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Aguarda 2 segundos antes de abrir a tela de login
    Timer(const Duration(seconds: 2), () {
      getUser(context);
    });
  }

  getUser(context) async {
    await Future.delayed(2.seconds);
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Navigator.pushNamed(context, "/home");
      } else {
        Navigator.pushNamed(context, "/initial");
      }
    } else {
      Navigator.pushNamed(context, "/initial");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF02cb0a),
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/logo.png')
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .flipH(
                begin: 1,
                end: 2,
                duration: 900.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 0, end: 1.5)
              .then(delay: 1000.ms)
              .flipV(
                begin: 2,
                end: 1,
                duration: 900.ms,
                curve: Curves.easeInOut,
              )
              .scaleXY(begin: 1.5, end: 0),
        ),
      ),
    );
  }
}
