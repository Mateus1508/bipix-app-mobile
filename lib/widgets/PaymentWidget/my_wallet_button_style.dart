import 'package:flutter/material.dart';

class MyWalletButtonStyle extends StatelessWidget {
  final String text;
  final IconData icon;

  const MyWalletButtonStyle(
      {super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(text),
          Icon(
            icon,
            size: 48,
          )
        ],
      ),
    );
  }
}
