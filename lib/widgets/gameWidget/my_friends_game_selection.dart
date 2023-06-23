import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/games_list.dart';

class MyFriendsGameSelection extends StatefulWidget {
  const MyFriendsGameSelection({super.key});

  @override
  State<MyFriendsGameSelection> createState() => _MyFriendsGameSelectionState();
}

class _MyFriendsGameSelectionState extends State<MyFriendsGameSelection> {
  late PageController _pageController;
  int currentGame = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.5,
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
      child: SizedBox(
        height: 500,
        child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentGame = value;
              });
            },
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: gameImages.length,
            itemBuilder: (context, index) =>
                Stack(children: <Widget>[buildGameItemsSlider(index)])),
      ),
    );
  }

  Widget buildGameItemsSlider(int index) => AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        return AnimatedScale(
          scale: currentGame == index ? 1.0 : 0.7,
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currentGame == index ? gameImages[index].title : "",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 4),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(gameImages[index].path),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(currentGame == index ? "Toque para jogar" : "")
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(begin: 1.1, duration: 1000.ms, curve: Curves.easeIn)
                  .then()
                  .fadeOut(duration: 700.ms, curve: Curves.easeOut),
            ],
          ),
        );
      });
}
