// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
  }
}
