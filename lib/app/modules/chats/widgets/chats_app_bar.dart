import 'package:bipixapp/app/modules/chats/new_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/utilities.dart';

class ChatsAppBar extends StatelessWidget {
  const ChatsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: viewPaddingTop(context) + 15,
        left: 10,
        right: 20,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          hSpace(10),
          Text(
            "Big Chat",
            style: getStyles(context).titleMedium,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: getColors(context).onBackground,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewChatPage(),
                  ));
            },
            icon: SvgPicture.asset("./assets/svg/create.svg"),
          ),
        ],
      ),
    );
  }
}
