import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    String cash = "400,00";

    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(right: 7, left: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
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
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "\$ $cash",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
