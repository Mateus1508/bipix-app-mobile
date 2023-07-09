import 'package:flutter/material.dart';

class PieceWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color? color;
  final String icon;
  final BoxConstraints constraints;
  const PieceWidget(
      {super.key,
      required this.onTap,
      required this.color,
      required this.icon,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        width: constraints.maxWidth / 8,
        height: constraints.maxWidth / 8,
        child: Image.asset(icon),
      ),
    );
  }
}
