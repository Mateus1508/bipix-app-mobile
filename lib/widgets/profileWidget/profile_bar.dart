import 'package:bipixapp/widgets/profileWidget/settings_modal_bottom.dart';
import 'package:flutter/material.dart';

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
        initialChildSize: 0.4,
        minChildSize: 0.32,
        maxChildSize: 0.9,
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
      actions: [
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
