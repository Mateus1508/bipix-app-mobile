import 'package:flutter/material.dart';

class ModalItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const ModalItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      // <-- TextButton
      onPressed: () {},
      icon: Icon(
        icon,
        size: 36.0,
      ),
      label: Text(text),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF454545),
      ),
    );
  }
}
