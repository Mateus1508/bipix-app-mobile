import 'package:bipixapp/app/modules/chats/widgets/chat_app_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/message_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ChatAppBar(username: "Bia"),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: List.generate(
                  100,
                  (index) => MessageWidget(
                    index: index,
                  ),
                ),
              ),
            ),
          ),
          const ChatInputBar(),
        ],
      ),
    );
  }
}
