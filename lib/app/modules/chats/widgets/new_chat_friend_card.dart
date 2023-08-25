import 'package:flutter/material.dart';

import '../../../../services/utilities.dart';
import '../../../../widgets/avatar_widget.dart';

class NewChatFriendCard extends StatelessWidget {
  const NewChatFriendCard(this.friendData, {super.key});

  final Map<String, dynamic> friendData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(left: 5, right: 15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: friendData["online"] ? Colors.green : Colors.transparent,
            ),
          ),
          const AvatarWidget(size: 43),
          hSpace(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friendData["username"],
                style: getStyles(context).titleMedium,
              ),
              Text(
                "@${friendData["tag"]}",
                style: getStyles(context).displayMedium?.copyWith(
                      color: getColors(context).primaryContainer,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
