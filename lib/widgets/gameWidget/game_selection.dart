import 'package:bipixapp/pages/select_bet_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            children: [
              Text(
                currentGame == index ? gameImages[index].title : "",
                style: const TextStyle(fontSize: 32, letterSpacing: 4),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(gameImages[index].path),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: currentGame == index
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectBetValue(
                                          index: currentGame,
                                        )),
                              );
                            },
                            child: const Text(
                              "Jogar",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32),
                            ),
                          ),
                          SizedBox(
                            child: Image.asset('assets/images/vector.png'),
                          ),
                        ],
                      )
                    : null,
              ),
              const SizedBox(height: 10),
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
