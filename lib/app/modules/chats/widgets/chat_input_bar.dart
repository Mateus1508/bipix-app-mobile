import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/utilities.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      decoration: BoxDecoration(
        color: getColors(context).surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, -3),
            color: getColors(context).shadow,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                    hintText: "Digitar mensagem...",
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("./assets/svg/chat.svg"),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("./assets/svg/game.svg"),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("./assets/svg/call.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
