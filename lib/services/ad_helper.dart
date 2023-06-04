import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7035408665940003/9407193830";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7035408665940003/7343319034";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7035408665940003/8361705472";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7035408665940003/3300950487";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }
}
