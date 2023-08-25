import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';
import '../../../../widgets/avatar_widget.dart';
import '../../../../widgets/button.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: viewPaddingTop(context) + 15,
        left: 10,
        right: 20,
      ),
      // height: 60,
      alignment: Alignment.centerLeft,

      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Text(
                "X",
                style: TextStyle(
                  // color: getColors(context).onBackground,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          hSpace(10),
          Column(
            children: [
              const AvatarWidget(),
              vSpace(2),
              SizedBox(
                height: 13,
                child: Text(
                  "online",
                  style: getStyles(context).displaySmall?.copyWith(
                        fontSize: 10,
                      ),
                ),
              )
            ],
          ),
          hSpace(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Text(
                username,
                style: getStyles(context).labelLarge,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 13),
            child: Button(
              label: "seguir",
              icon: Icons.add_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
