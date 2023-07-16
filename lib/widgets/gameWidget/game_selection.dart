import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/load_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/games_list.dart';
import '../../services/utilities.dart';
import 'package:http/http.dart';

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

  String getGame() {
    switch (currentGame) {
      case 0:
        return "TRUCO";
      case 1:
        return "DAMA";
      case 2:
        return "VELHA";
      case 3:
        return "LUDO";
      case 4:
        return "CHESS";
      case 5:
        return "STOP";
      case 6:
        return "MONOPOLY";
      case 7:
        return "WHO_KILLED_MARIO";
      case 8:
        return "BIPIX_WORLD";
      default:
        return "Jogo não reconhecido";
    }
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
                            onPressed: () async {
                              final entry = LoadOverlay.load();
                              Overlay.of(context).insert(entry);
                              if ([1, 2].contains(currentGame)) {
                                try {
                                  String userId = await Webservice.getUserId();
                                  String game = getGame();
                                  Response response = await Webservice.post(
                                      function: "newRandomGame",
                                      body: {
                                        "userId": userId,
                                        "game": game,
                                      });
                                  print("Response: $response");
                                } catch (e) {
                                  print("E: $e");
                                }
                              } else {
                                showCustomSnackBar(
                                  context,
                                  "Jogo em construção.",
                                );
                              }
                              entry.remove();
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
              Text(
                currentGame == index ? "Toque para jogar" : "",
                style: const TextStyle(color: Colors.white),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(begin: 1.1, duration: 1000.ms, curve: Curves.easeIn)
                  .then()
                  .fadeOut(duration: 700.ms, curve: Curves.easeOut),
            ],
          ),
        );
      });
}
