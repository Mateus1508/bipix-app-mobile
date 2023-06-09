import 'package:flutter/material.dart';

class InConstruction extends StatelessWidget {
  const InConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/games_logos/in_construction.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
