import 'package:bipixapp/widgets/gameWidget/my_friends.dart';
import 'package:bipixapp/widgets/gameWidget/add_new_friends.dart';
import 'package:flutter/material.dart';
import 'game_selection.dart';

class GamesBipix extends StatefulWidget {
  const GamesBipix({super.key});

  @override
  State<GamesBipix> createState() => _GamesBipixState();
}

class _GamesBipixState extends State<GamesBipix> {
  int selectedMode = 0;

  List<String> gameModeOptions = [
    "modo aleatório",
    "contra amigos",
    "add amigo",
  ];

  navigationGameModeOption() {
    if (selectedMode == 0) {
      return const GameSelection();
    } else if (selectedMode == 1) {
      return const AddNewFriends();
    } else if (selectedMode == 2) {
      return const Myfriends();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Conheça novas pessoas",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsetsDirectional.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: gameModeOptions.length,
              itemBuilder: (context, index) => buildNavigation(index, context),
            ),
          ),
          navigationGameModeOption(),
        ],
      ),
    );
  }

  Container buildNavigation(int index, BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == selectedMode
            ? const Color(0XFF0472E8)
            : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedMode = index;
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          gameModeOptions[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
