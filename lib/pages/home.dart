import 'package:bipixapp/widgets/info_bar.dart';
import 'package:bipixapp/widgets/my_wallet.dart';
import 'package:flutter/material.dart';
import '../widgets/gameWidget/games_bipix.dart';
//import '../widgets/game_widget/games_bipix.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedItem = 0;

  navigationItemSelected() {
    if (selectedItem == 0) {
      return GamesBipix();
    }
    if (selectedItem == 1) {
      return MyWallet();
    }
  }

  List<String> navigationItems = [
    "Jogos Bipix",
    "Minha carteira",
    "Ponto de recarga"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              padding: const EdgeInsetsDirectional.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: navigationItems.length,
                  itemBuilder: (context, index) =>
                      buildNavigation(index, context),
                ),
              ),
            ),
            navigationItemSelected(),
          ],
        ),
      ),
    );
  }

  Container buildNavigation(int index, BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == selectedItem ? Colors.blue : Colors.transparent,
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
