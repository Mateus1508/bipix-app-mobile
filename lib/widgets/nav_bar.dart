import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

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
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          tabBorderRadius: 10,
          color: Color(0XFF0472E8),
          activeColor: Colors.white,
          tabBackgroundColor: Color(0XFF0472E8),
          padding: EdgeInsets.all(15),
          gap: 8,
          tabs: [
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
            GButton(
              icon: Icons.settings,
              text: 'Configurações',
            ),
          ],
        ),
      ),
    );
  }
}
