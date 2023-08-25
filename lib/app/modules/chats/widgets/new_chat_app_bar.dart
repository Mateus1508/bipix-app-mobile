import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';

class NewChatAppBar extends StatelessWidget {
  const NewChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: viewPaddingTop(context)),
      padding: const EdgeInsets.all(20),
      width: maxWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            "Nova Conversa",
            style: getStyles(context).titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: getColors(context).onBackground,
                ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}
