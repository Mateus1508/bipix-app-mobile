import 'package:bipixapp/widgets/PaymentWidget/payment_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/PaymentWidget/my_wallet_button_style.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double amount = 400.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaymentBar(),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundWhite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 240),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF373737),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const MyWalletButtonStyle(
                            text: 'Comprar moedas', icon: Icons.attach_money)),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const MyWalletButtonStyle(
                          text: 'Comprar moedas', icon: Icons.attach_money),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const MyWalletButtonStyle(
                          text: 'Comprar moedas', icon: Icons.attach_money),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const MyWalletButtonStyle(
                          text: 'Comprar moedas', icon: Icons.attach_money),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
