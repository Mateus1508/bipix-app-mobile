import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? "ca-app-pub-3940256099942544/3419835294"
          : "ca-app-pub-7035408665940003/6110084258";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5662855259";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-7035408665940003/8424406343";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7035408665940003/7343319034";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? "ca-app-pub-3940256099942544/1033173712"
          : "ca-app-pub-7035408665940003/9378395361";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? "ca-app-pub-3940256099942544/5224354917"
          : "ca-app-pub-7035408665940003/8767983283";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7035408665940003/3300950487";
    } else {
      throw UnsupportedError("Usupported platform");
    }
  }

  AppOpenAd? _appOpenAd;

  bool _isShowingAd = false;

  final Duration maxCacheDuration = const Duration(hours: 4);

  DateTime? _appOpenLoadTime;

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  Future<void> loadRewardedAd({
    required final void Function(RewardedAd ad) onLoaded,
  }) async {
    await updateConfigurations();
    await RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdClicked: (ad) {},
          );

          ad.onUserEarnedRewardCallback = (ad, reward) {};

          onLoaded(ad);
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  static Future<BannerAd> loadBanner({
    required void Function(Ad ad) onAdLoaded,
  }) async {
    await updateConfigurations();
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
  }

  static Future<void> loadInterstistialAd(
      {required void Function(InterstitialAd ad) onAdLoaded}) async {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdClicked: (ad) {},
          );
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void loadAppOpenAd() async {
    await updateConfigurations();
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void showAdIfAvailable() async {
    if (!isAdAvailable) {
      loadAppOpenAd();
      return;
    }
    if (_isShowingAd) {
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      if (kDebugMode) {}
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAppOpenAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd();
      },
    );

    _appOpenAd!.show();
  }

  static Future<void> updateConfigurations() async {
    RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: ["B344A2E6F1812DD05F37ADBEB20D4D89"],
    );
    MobileAds mobileAds = MobileAds.instance;
    await mobileAds.updateRequestConfiguration(configuration);
  }
}

class AppLifecycleReactor {
  final AdHelper appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
