import 'package:flutter/material.dart';

class SelectFriend extends StatelessWidget {
  const SelectFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '@Joaozinho',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
