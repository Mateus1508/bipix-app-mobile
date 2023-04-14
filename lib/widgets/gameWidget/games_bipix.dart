import 'package:bipixapp/widgets/gameWidget/play_with_friends.dart';
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
    "Conhecer pessoas",
    "Jogar com amigos",
  ];

  navigationGameModeOption() {
    if (selectedMode == 0) {
      return const GameSelection();
    }
    if (selectedMode == 1) {
      return const PlayWithFriends();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Conheça novas pessoas"),
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
          const SizedBox(
            height: 10,
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
        color: index == selectedMode ? Colors.blue : Colors.transparent,
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
          ),
        ),
      ),
    );
  }
}
