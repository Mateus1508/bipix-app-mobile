import 'package:bipixapp/models/games_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameItems extends StatelessWidget {
  final GameItem gameItem;

  const GameItems({super.key, required this.gameItem});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          gameItem.title,
          style: const TextStyle(fontSize: 32, letterSpacing: 7),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(gameItem.path),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Jogar",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
              SizedBox(
                child: Image.asset('assets/images/vector.png'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text("Toque para jogar")
            .animate(onPlay: (controller) => controller.repeat())
            .fadeIn(begin: 1.1, duration: 1000.ms, curve: Curves.easeIn)
            .then()
            .fadeOut(duration: 700.ms, curve: Curves.easeOut),
      ],
    );
  }
}
