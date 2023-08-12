import 'package:bipixapp/pages/chat_page.dart';
import 'package:bipixapp/pages/home.dart';
import 'package:bipixapp/pages/list_page.dart';
import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  final tabs = [
    const Home(),
    const Profile(),
    const Payment(),
    const ListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(10),
          activeColor: Colors.white,
          tabBackgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 1),
          tabBorderRadius: 10,
          gap: 10,
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              iconColor: Theme.of(context).colorScheme.primary,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              iconColor: Theme.of(context).colorScheme.primary,
              text: 'Perfil',
            ),
            GButton(
              icon: Icons.wallet,
              iconColor: Theme.of(context).colorScheme.primary,
              text: 'Carteira',
            ),
            const GButton(
              icon: Icons.chat,
              text: 'Chat Bipix',
            ),
          ],
        ),
      ),
    );
  }
}
