import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BuyCoins extends StatelessWidget {
  const BuyCoins({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LIVRE DE ANÚNCIOS',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Adquira moedas Bipix',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 220,
                    child: Image.asset('assets/images/payment/comprar_100.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 220,
                    child: Image.asset('assets/images/payment/comprar_600.png'),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 220,
                    child:
                        Image.asset('assets/images/payment/comprar_2300.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 220,
                    child:
                        Image.asset('assets/images/payment/comprar_8324.png'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text('Clique para comprar')
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(begin: 1.1, duration: 1000.ms, curve: Curves.easeIn)
                  .then()
                  .fadeOut(duration: 700.ms, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}
