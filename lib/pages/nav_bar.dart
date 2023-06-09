import 'package:bipixapp/pages/home.dart';
import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(15),
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0XFF0472E8),
          color: const Color(0XFF0472E8),
          duration: const Duration(seconds: 1),
          tabBorderRadius: 10,
          gap: 10,
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Perfil',
            ),
            GButton(
              icon: Icons.wallet,
              text: 'Carteira',
            ),
          ],
        ),
      ),
    );
  }
}
