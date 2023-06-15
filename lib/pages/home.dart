import 'package:bipixapp/services/ad_helper.dart';
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

  int selectedItem = 0;

  List<String> navigationItems = ["Jogos Bipix", "Ponto de recarga"];

  void _createBottomBannerAd() async {
    _bottomBannerAd = await AdHelper.loadBanner(onAdLoaded: (ad) {
      setState(() {
        _isBottomBannerAdLoaded = true;
      });
    });
    await _bottomBannerAd.load();
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
    _createBottomBannerAd();

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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundWhite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 500,
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
      ),
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
          ),
        ),
      ),
    );
  }
}
