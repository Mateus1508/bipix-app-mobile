import 'package:bipixapp/pages/loading.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  static final Map<String, WidgetBuilder> routes = {
    '/signup': (context) => SignUp(),
    '/login': (context) => Login(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
      routes: routes,
    );
  }
}
