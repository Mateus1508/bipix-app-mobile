import 'package:firebase_auth/firebase_auth.dart';
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
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, "/initial");
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
    ;
  }
}
