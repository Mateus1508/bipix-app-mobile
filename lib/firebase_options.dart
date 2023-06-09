// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;

      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyAfat70q3Au3TUX293SnSxDjLaepMTL-Ig",
    authDomain: "bipix-63992.firebaseapp.com",
    databaseURL: "https://bipix-63992-default-rtdb.firebaseio.com",
    projectId: "bipix-63992",
    storageBucket: "bipix-63992.appspot.com",
    messagingSenderId: "700616056019",
    appId: "1:700616056019:web:05fdb4ab6a0df87f7d8826",
    measurementId: "G-MS7JF031P6",
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfat70q3Au3TUX293SnSxDjLaepMTL-Ig',
    appId: '1:700616056019:web:4e3b6f89091730897d8826',
    messagingSenderId: '700616056019',
    projectId: 'bipix-63992',
    authDomain: 'bipix-63992.firebaseapp.com',
    databaseURL: 'https://bipix-63992-default-rtdb.firebaseio.com',
    storageBucket: 'bipix-63992.appspot.com',
    measurementId: 'G-E2FN9KZQFB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACzWcBhzLCE0ORYzkzFaPFqEnCBfzbtQg',
    appId: '1:700616056019:android:b344937b2ac090497d8826',
    messagingSenderId: '700616056019',
    projectId: 'bipix-63992',
    databaseURL: 'https://bipix-63992-default-rtdb.firebaseio.com',
    storageBucket: 'bipix-63992.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC65zIBCQCUkvoupo-5ABYuzfYPHT0sd-4',
    appId: '1:700616056019:ios:2a0df9db16a7bf0f7d8826',
    messagingSenderId: '700616056019',
    projectId: 'bipix-63992',
    databaseURL: 'https://bipix-63992-default-rtdb.firebaseio.com',
    storageBucket: 'bipix-63992.appspot.com',
    iosClientId:
        '700616056019-p4mqg98hfdg1ciau3bfocubg7h3anjrp.apps.googleusercontent.com',
    iosBundleId: 'br.com.mateusbelmonte.bipixapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC65zIBCQCUkvoupo-5ABYuzfYPHT0sd-4',
    appId: '1:700616056019:ios:2a0df9db16a7bf0f7d8826',
    messagingSenderId: '700616056019',
    projectId: 'bipix-63992',
    databaseURL: 'https://bipix-63992-default-rtdb.firebaseio.com',
    storageBucket: 'bipix-63992.appspot.com',
    iosClientId:
        '700616056019-p4mqg98hfdg1ciau3bfocubg7h3anjrp.apps.googleusercontent.com',
    iosBundleId: 'br.com.mateusbelmonte.bipixapp',
  );
}
