import 'package:bipixapp/services/ad_helper.dart';
import 'package:bipixapp/services/utilities.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/infoBarWidget/info_bar.dart';
import 'package:bipixapp/widgets/rechargeWidget/recharge.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../widgets/gameWidget/games_bipix.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BannerAd _bottomBannerAd;

  bool _isBottomBannerAdLoaded = false;

  RewardedAd? _rewardedAd;

  int selectedItem = 0;

  List<String> navigationItems = ["Jogos Bipix", "Ponto de recarga"];
  void _loadRewardedAd() {
    RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: ["B344A2E6F1812DD05F37ADBEB20D4D89"],
    );
    MobileAds mobileAds = MobileAds.instance;
    mobileAds.updateRequestConfiguration(configuration);
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          setState(() {
            _rewardedAd = ad;
          });

          ad.onUserEarnedRewardCallback = (ad, reward) {};
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  void _createBottomBannerAd() {
    RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: ["B344A2E6F1812DD05F37ADBEB20D4D89"],
    );
    MobileAds mobileAds = MobileAds.instance;
    mobileAds.updateRequestConfiguration(configuration);
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print(ad);
          print(error);
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  navigationItemSelected() {
    if (selectedItem == 0) {
      return const GamesBipix();
    }
    if (selectedItem == 1) {
      return const Recharge();
    }
  }

  @override
  void initState() {
    // _createBottomBannerAd();

    _loadRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    _bottomBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoBar(),
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: _bottomBannerAd,
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 500,
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: navigationItems.length,
                itemBuilder: (context, index) =>
                    buildNavigation(index, context),
              ),
            ),
            navigationItemSelected(),
          ],
        ),
      ),
      floatingActionButton: _rewardedAd != null
          ? FloatingActionButton(
              onPressed: () {
                _rewardedAd!.show(
                  onUserEarnedReward: (ad, reward) async {
                    Webservice.post(
                      function: "earnReward",
                      body: {
                        "userId": await Webservice.getUserId(),
                        "value": 1,
                      },
                    );
                    setState(() {
                      _rewardedAd = null;
                    });
                    _loadRewardedAd();
                  },
                );
              },
              child: Icon(
                Icons.play_arrow,
                color: getColors(context).primary,
              ),
            )
          : null,
    );
  }

  Container buildNavigation(int index, BuildContext context) {
    return Container(
      height: 25,
      width: MediaQuery.of(context).size.width * 0.461,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == selectedItem
            ? const Color(0XFF0472E8)
            : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedItem = index;
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          navigationItems[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
