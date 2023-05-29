import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PreGame extends StatefulWidget {
  const PreGame({super.key});

  @override
  State<PreGame> createState() => _PreGameState();
}

class _PreGameState extends State<PreGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/tic-tac-toe.png'),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Dama',
                    style: TextStyle(fontSize: 42, letterSpacing: 4),
                  ),
                ],
              )
                  .animate()
                  .fade(delay: 500.ms)
                  .slideY(
                      begin: -5,
                      end: 0,
                      curve: Curves.easeIn,
                      duration: 1000.ms)
                  .then(),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black54),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/bipixLogo.png'),
                      ),
                    )
                        .animate()
                        .fade(delay: 1300.ms)
                        .slideX(
                            begin: -2,
                            end: 0,
                            curve: Curves.easeIn,
                            duration: 800.ms)
                        .then(),
                    const Text(
                      'VS',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ).animate().fade(delay: 200.ms, duration: 500.ms).then(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black54),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/bipixLogo.png'),
                      ),
                    )
                        .animate()
                        .fade(delay: 1500.ms)
                        .slideX(
                            begin: 2,
                            end: 0,
                            curve: Curves.easeIn,
                            duration: 1000.ms)
                        .then(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Valor apostado',
                style: TextStyle(fontSize: 18),
              ).animate().fade(delay: 500.ms, duration: 500.ms).then(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '+5.00',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ).animate().fade(delay: 500.ms, duration: 500.ms).then(),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF0472E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Começar jogo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
                  .animate()
                  .fade(delay: 800.ms)
                  .slideY(
                      begin: 5, end: 0, curve: Curves.easeIn, duration: 1000.ms)
                  .then(),
            ],
          ),
        ),
      ),
    );
  }
}
