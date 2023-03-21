import 'package:bipixapp/pages/edit_profile.dart';
import 'package:bipixapp/pages/loading.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:bipixapp/pages/home.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:bipixapp/damas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  static final Map<String, WidgetBuilder> routes = {
    '/signup': (context) => const SignUp(),
    '/login': (context) => const Login(),
    '/home': (context) => const Home(),
    '/editprofile': (context) => const EditProfile(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      routes: routes,
    );
  }
}
