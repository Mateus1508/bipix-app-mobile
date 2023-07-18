import 'package:bipixapp/services/utilities.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/ad_helper.dart';

class RechargePoint extends StatefulWidget {
  const RechargePoint({super.key});

  @override
  State<RechargePoint> createState() => _RechargePointState();
}

class _RechargePointState extends State<RechargePoint> {
  RewardedAd? _rewardedAd;

  String? userId;

  @override
  void initState() {
    _loadRewardedAd();
    super.initState();
  }

  void _loadRewardedAd() async {
    RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: ["B344A2E6F1812DD05F37ADBEB20D4D89"],
    );
    MobileAds mobileAds = MobileAds.instance;
    mobileAds.updateRequestConfiguration(configuration);
    userId = await Webservice.getUserId();
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

          debugPrint('$ad loaded.');

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Meu saldo",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 24),
                ),
                const SizedBox(height: 20),
                /* StreamBuilder(
                    stream: getUserStream(),
                    builder: (context, userSnap) {
                      if (userSnap.hasData) {
                        return Text(
                          "\$ ${userSnap.data!["credit"]}",
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: 80,
                          child: LinearProgressIndicator(minHeight: 40),
                        );
                      }
                    },
                  ), */
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_rewardedAd == null) {
                      showCustomSnackBar(context, "Aguarde carregar o anúncio");
                    } else {
                      _rewardedAd!.show(
                        onUserEarnedReward: (ad, reward) {
                          Webservice.post(function: "earnReward", body: {
                            "userId": userId!,
                            "value": 1,
                          });
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: 9,
                            spreadRadius: 10),
                      ],
                      color: _rewardedAd == null
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 150,
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .scaleXY(
                          begin: 0.9,
                          end: 1,
                          duration: 1000.ms,
                          curve: Curves.easeInOut)
                      .then()
                      .scaleXY(
                          begin: 1,
                          end: 0.9,
                          duration: 1500.ms,
                          curve: Curves.easeInOut),
                ),
                const SizedBox(height: 25),
                Text(
                  "Toque para assistir",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(begin: 0.5, duration: 1000.ms, curve: Curves.easeIn)
                    .then()
                    .fadeOut(duration: 700.ms, curve: Curves.easeOut),
                const SizedBox(height: 10),
                const Text(
                  "Ganhe + \$ 1.00",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: Text(
                    '"Quando você assiste um anúncio,você ajuda a Bipix continuar Grátis."',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
