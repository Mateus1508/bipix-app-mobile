import 'package:flutter/material.dart';

class PaymentBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0XFF0472E8),
      leading: Image.asset('assets/images/bipixLogo.png'),
      actions: [
        IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          icon: const Icon(Icons.logout),
        ),
      ],
    );
    ;
  }
}
