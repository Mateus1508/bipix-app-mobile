import 'package:bipixapp/widgets/profileWidget/settings_modal_bottom.dart';
import 'package:flutter/material.dart';

import '../widgets/navbarWidget/nav_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return Center(
      child: Column(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () => _handleShowModalBottomSheet(context),
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
