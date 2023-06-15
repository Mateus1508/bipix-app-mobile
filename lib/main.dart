import 'package:bipixapp/firebase_options.dart';
import 'package:bipixapp/pages/loading_app.dart';
import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/initial_screen.dart';
import 'package:bipixapp/pages/edit_profile.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:bipixapp/pages/pre_game.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:bipixapp/pages/select_bet_value.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:bipixapp/themes/theme_constants.dart';
import 'package:bipixapp/widgets/damas.dart';
import 'package:bipixapp/pages/nav_bar.dart';
import 'package:bipixapp/widgets/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bipixapp/widgets/zoomWidget/call_screen.dart';
import 'package:bipixapp/widgets/zoomWidget/intro_screen.dart';
import 'package:bipixapp/widgets/zoomWidget/join_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({Key? key});

  static Map<String, WidgetBuilder> routes = {
    '/initial': (context) => const InitialScreen(),
    '/signup': (context) => const SignUp(),
    '/login': (context) => const Login(),
    '/home': (context) => const BottomBar(),
    '/editprofile': (context) => const EditProfile(),
    '/selectbet': (context) => const SelectBetValue(),
    // '/playerlose': (context) => const PlayerLose(),
    // '/velha': (context) => const GamePage(),
    '/pregame': (context) => const PreGame(),
    '/profile': (context) => const Profile(),
    '/payment': (context) => const Payment(),
    "Join": (context) => const JoinScreen(),
    "Call": (context) => const CallScreen(),
    "Intro": (context) => const IntroScreen(),
    '/damas': (context) => MyApp(),
    // '/playerwon': (context) => const PlayerWon(),
    'loadingapp': (context) => const LoadingApp(),
  };

  @override
  Widget build(BuildContext context) {
    var zoom = ZoomVideoSdk();
    InitConfig initConfig = InitConfig(
      domain: "zoom.us",
      enableLog: true,
    );
    zoom.initSdk(initConfig);
    return MaterialApp(
      title: "Bipix",
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const SafeArea(
        child: IntroScreen(),
      ),
      routes: routes,
    );
  }
}
