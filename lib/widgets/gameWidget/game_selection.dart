import 'dart:io';

import 'package:bipixapp/widgets/gameWidget/game_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../models/games_list.dart';

class GameSelection extends StatefulWidget {
  const GameSelection({super.key});

  @override
  State<GameSelection> createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {
  late PageController _pageController;
  int currentGame = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: currentGame,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 1,
        child: SizedBox(
          height: 200,
          child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentGame = value;
                });
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: gameImages.length,
              itemBuilder: (context, index) => buildGameItemsSlider(index)),
        ),
      ),
    );
  }

  Widget buildGameItemsSlider(int index) => AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          double? page = _pageController.page;
          value = index - page!;
          value = (value * 0.038).clamp(-1, 1);
        }

        return Transform.rotate(
          angle: math.pi * value,
          child: GameItems(gameItem: gameImages[index]),
        );
      });
}
