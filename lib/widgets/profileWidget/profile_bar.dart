// ignore_for_file: use_build_context_synchronously

import 'package:bipixapp/widgets/profileWidget/settings_modal_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/initial_screen.dart';

class ProfileBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  void _handleShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.33,
        minChildSize: 0.32,
        maxChildSize: 0.6,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: const SettingsModalBottomSheeet(),
        ),
      ),
    );
  }

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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitialScreen(),
                ));
          },
          icon: const Icon(Icons.logout),
        ),
        IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () => _handleShowModalBottomSheet(context),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
