import 'package:flutter/material.dart';

import '../services/utilities.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.size = const Size(94, 36),
    this.label,
    this.icon,
  });

  final Size size;
  final String? label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: getColors(context).primary,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 3),
            color: getColors(context).shadow,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (label != null)
            Text(
              label!,
              style: getStyles(context).displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          if (label != null && icon != null) hSpace(5),
          if (icon != null)
            Icon(
              icon,
              size: 20,
            ),
        ],
      ),
    );
  }
}
