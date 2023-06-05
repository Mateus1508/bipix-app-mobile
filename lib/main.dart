import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/game_page.dart';
import 'package:bipixapp/pages/initial_screen.dart';
import 'package:bipixapp/pages/edit_profile.dart';
import 'package:bipixapp/pages/loading_app.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:bipixapp/pages/pre_game.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:bipixapp/pages/rematch.dart';
import 'package:bipixapp/pages/select_bet_value.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:bipixapp/widgets/damas.dart';
import 'package:bipixapp/pages/nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({super.key});

  static Map<String, WidgetBuilder> routes = {
    '/initial': (context) => const InitialScreen(),
    '/signup': (context) => const SignUp(),
    '/login': (context) => const Login(),
    '/home': (context) => const BottomBar(),
    '/editprofile': (context) => const EditProfile(),
    '/damas': (context) => MyApp(),
    '/selectbet': (context) => const SelectBetValue(),
    '/rematch': (context) => const Rematch(),
    '/velha': (context) => const GamePage(),
    '/pregame': (context) => const PreGame(),
    '/profile': (context) => const Profile(),
    '/payment': (context) => const Payment(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bipix",
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: routes,
    );
  }
}
