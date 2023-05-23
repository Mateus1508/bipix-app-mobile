import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    String cash = "400,00";

    return AppBar(
      backgroundColor: const Color(0XFF0472E8),
      elevation: 2,
      leading: Image.asset('assets/images/bipixLogo.png'),
      actions: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(right: 7, left: 1),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 1,
                    spreadRadius: 3),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wallet,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "\$ $cash",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
