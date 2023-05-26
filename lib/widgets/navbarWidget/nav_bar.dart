import 'package:bipixapp/pages/home.dart';
import 'package:bipixapp/pages/payment.dart';
import 'package:bipixapp/pages/profile.dart';
import 'package:bipixapp/widgets/infoBarWidget/info_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<String> _widgetOptions = <String>[
    "home",
    "profile",
    "payment"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 1),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          tabBorderRadius: 10,
          color: const Color(0XFF0472E8),
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0XFF0472E8),
          padding: const EdgeInsets.all(15),
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
            Navigator.pushNamed(
                context, '/${_widgetOptions.elementAt(_selectedIndex)}');
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Início',
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
