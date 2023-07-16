import 'package:flutter/material.dart';

class WaitingPlayer extends StatefulWidget {
  const WaitingPlayer({super.key});

  @override
  State<WaitingPlayer> createState() => _WaitingPlayerState();
}

class _WaitingPlayerState extends State<WaitingPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.arrow_back),
      ),
      backgroundColor: const Color(0xFF393641),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 1),
                Column(
                  children: [
                    const Text(
                      'Esperando adversário...',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: SizedBox(
                            width: 150,
                            child: Image.asset('assets/images/bipixLogo.png')))
                  ],
                ),
                SizedBox(
                    width: 150, child: Image.asset('assets/images/logo.png')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
