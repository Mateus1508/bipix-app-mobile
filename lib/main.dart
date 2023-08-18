import 'package:bipixapp/firebase_options.dart';
import 'package:bipixapp/pages/buy_coins.dart';
import 'package:bipixapp/pages/call_page.dart';
import 'package:bipixapp/pages/loading_app.dart';
import 'package:bipixapp/pages/login_call.dart';
import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/initial_screen.dart';
import 'package:bipixapp/pages/edit_profile.dart';
import 'package:bipixapp/pages/login.dart';
import 'package:bipixapp/pages/pre_game.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:bipixapp/pages/select_bet_value.dart';
import 'package:bipixapp/pages/sign_up.dart';
import 'package:bipixapp/services/ad_helper.dart';
import 'package:bipixapp/themes/theme_constants.dart';
import 'package:bipixapp/pages/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
  });
  ZIMKit().init(
    appID: 524754273, // your appid
    appSign:
        '6f1f75143b5c4a54053a2a32df62f8004f6b82fdbedf7eed61ab8c62aba0e8cf', // your appSign
  );
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
}

void onUserLogin(String id, String name) {
  /// 2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 524754273, // your appid
    appSign:
        '6f1f75143b5c4a54053a2a32df62f8004f6b82fdbedf7eed61ab8c62aba0e8cf', // your appSign
    userID: id,
    userName: name,
    plugins: [ZegoUIKitSignalingPlugin()],
  );
}

/// on App's user logout
void onUserLogout() {
  /// 2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLifecycleReactor _appLifecycleReactor;

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
    '/buycoins': (context) => const BuyCoins(),
    '/damas': (context) => MyApp(
          navigatorKey: navigatorKey,
        ),
    // '/playerwon': (context) => const PlayerWon(),
    '/loadingapp': (context) => const LoadingApp(),
    // '/call': (context) => const CallOverlay(),
    '/logincall': (context) => const LoginCall(),
    // '/join': (context) => const JoinScreen(),
    // '/call': (context) => const CallScreen(),
    // '/intro': (context) => const IntroScreen(),
    // '/join': (context) => const JoinScreen(),
    // '/call': (context) => const CallScreen(),
    // '/intro': (context) => const IntroScreen(),
    // '/damas': (context) => MyApp(),

    // '/playerwon': (context) => const PlayerWon(),
    'loadingapp': (context) => const LoadingApp(),
  };

  @override
  initState() {
    AdHelper appOpenAdManager = AdHelper()..loadAppOpenAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bipix",
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      home: const SafeArea(child: LoadingApp()),
      routes: routes,
      navigatorKey: widget.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}
