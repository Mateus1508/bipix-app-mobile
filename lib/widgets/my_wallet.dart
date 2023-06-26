import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  double amount = 400.25;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.amber.shade500,
                            blurRadius: 2,
                            spreadRadius: 5),
                      ],
                      color: const Color(0xFF454545),
                    ),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/bipixLogo.png'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      shape: BoxShape.rectangle,
                      color: Color(0xFF3E3838),
                    ),
                    child: const Text(
                      "Editar foto",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bipix",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF373737),
                      ),
                    ),
                    Text(
                      "@bipix.user",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF373737)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '“A vida é feita de desafios, eu estou preparada."',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF373737),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Meu saldo",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF373737),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "\$ $amount",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF373737),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Recarrega grátis",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.amber.shade300,
                          blurRadius: 9,
                          spreadRadius: 10),
                    ],
                    color: Colors.amber.shade500,
                  ),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/recarregar.png'),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scaleXY(
                        begin: 0.9,
                        end: 1,
                        duration: 1000.ms,
                        curve: Curves.easeInOut)
                    .then()
                    .scaleXY(
                        begin: 1,
                        end: 0.9,
                        duration: 1500.ms,
                        curve: Curves.easeInOut),
                const SizedBox(height: 10),
                const Text("Toque para assistir")
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(begin: 0.5, duration: 1000.ms, curve: Curves.easeIn)
                    .then()
                    .fadeOut(duration: 700.ms, curve: Curves.easeOut),
                const SizedBox(height: 10),
                const Text(
                  "Ganhe + \$ 1.00",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                const Text(
                    "Quando você assiste um anúncio,você ajuda a Bipix continuar Grátis."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
