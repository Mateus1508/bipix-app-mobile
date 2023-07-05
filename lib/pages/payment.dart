import 'package:bipixapp/pages/buy_coins.dart';
import 'package:bipixapp/widgets/PaymentWidget/payment_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_helper.dart';
import '../services/webservice.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  RewardedAd? _rewardedAd;

  late BannerAd _bottomBannerAd;

  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    AdHelper().loadRewardedAd(
      onLoaded: (ad) => setState(() => _rewardedAd = ad),
    );
    _createBottomBannerAd();

    super.initState();
  }

  void _createBottomBannerAd() async {
    _bottomBannerAd = await AdHelper.loadBanner(onAdLoaded: (ad) {
      setState(() {
        _isBottomBannerAdLoaded = true;
      });
    });
    _bottomBannerAd.load();
  }

  Stream<Map<String, dynamic>> getUserStream() async* {
    String userId = await Webservice.getUserId();
    await for (final doc in FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()) {
      yield doc.data() ?? {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaymentBar(),
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: _bottomBannerAd,
              ),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 80,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyCoins()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor:
                        Colors.amber.shade600, // background (button) color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset('assets/images/payment/crown.png'),
                      ),
                      const SizedBox(height: 25),
                      StreamBuilder(
                        stream: getUserStream(),
                        builder: (context, userSnap) {
                          if (userSnap.hasData) {
                            return Text(
                              "\$ ${userSnap.data!["credit"]}",
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF373737),
                              ),
                            );
                          } else {
                            return const SizedBox(
                              width: 80,
                              child: LinearProgressIndicator(minHeight: 40),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _rewardedAd != null
                    ? () {
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
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue.shade800),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(5),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    const Text(
                      'Assistir para ganhar',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
