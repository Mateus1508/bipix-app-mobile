import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';
import 'new_chat_friend_card.dart';

class NewChatLetterGroup extends StatelessWidget {
  const NewChatLetterGroup({
    super.key,
    required this.letter,
    required this.letterFriends,
  });

  final String letter;

  final List<Map<String, dynamic>> letterFriends;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            letter,
            style: getStyles(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          vSpace(10),
          ...letterFriends
              .map((friendData) => NewChatFriendCard(friendData))
              .toList()
        ],
      ),
    );
  }
}
