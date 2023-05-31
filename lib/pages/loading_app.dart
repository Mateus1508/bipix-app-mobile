import 'dart:async';

import 'package:bipixapp/pages/initial_screen.dart';
import 'package:bipixapp/pages/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingApp extends StatefulWidget {
  const LoadingApp({super.key});

  @override
  LoadingAppState createState() => LoadingAppState();
}

class LoadingAppState extends State<LoadingApp>
    with SingleTickerProviderStateMixin {
  String? userId;
  @override
  void initState() {
    super.initState();
    getUser();
    // Aguarda 2 segundos antes de abrir a tela de login
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              userId != null ? const BottomBar() : const InitialScreen(),
        ),
      );
    });
  }

  getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("USER_ID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0472E8),
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
