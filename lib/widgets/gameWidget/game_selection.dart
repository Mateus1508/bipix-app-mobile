import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameSelection extends StatefulWidget {
  const GameSelection({super.key});

  @override
  State<GameSelection> createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: PageView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            const Text(
              "Dama",
              style: TextStyle(fontSize: 32, letterSpacing: 7),
            ),
            const SizedBox(
              height: 20,
            ),
            /* SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/baralho.png'),
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/dama.png'),
                  ),
                  SizedBox(
                    child: Image.asset('assets/images/truco.png'),
                  ),
                ],
              ),
            ), */
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/damas');
                    },
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
        ),
      ),
    );
  }
}
