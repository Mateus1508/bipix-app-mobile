import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.blue,
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.person,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset('assets/images/bipixLogo.png'),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.wallet,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
