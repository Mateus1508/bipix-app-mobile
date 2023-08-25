import 'package:bipixapp/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/custom_search_bar.dart';
import 'widgets/new_chat_app_bar.dart';
import 'widgets/new_chat_letter_group.dart';

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  Future<Map<String, dynamic>> getData() async {
    String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    List<Map<String, dynamic>> users = [
      {
        "username": "Felipe",
        "online": true,
        "tag": "felipe.fontes",
      },
      {
        "username": "Bianca",
        "online": true,
        "tag": "bia.sol",
      },
      {
        "username": "Anderson",
        "online": false,
        "tag": "anderson.silva",
      },
      {
        "username": "Fábio",
        "online": false,
        "tag": "fabio.moura",
      },
      {
        "username": "Débora",
        "online": true,
        "tag": "debcarol.santos",
      },
      {
        "username": "Bruno",
        "online": false,
        "tag": "bruno.3245",
      },
    ];
    users.sort(
      (a, b) => b["username"].toString().compareTo(a["username"]),
    );
    await Future.delayed(2.seconds);
    Map<String, dynamic> data = {};

    for (String letter in letters.characters) {
      List<Map<String, dynamic>> letterUsers = users
          .where((element) =>
              element["username"][0].toString().toUpperCase() == letter)
          .toList();
      if (letterUsers.isNotEmpty) {
        data[letter] = letterUsers;
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NewChatAppBar(),
          const CustomSearchBar(),
          vSpace(30),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.keys
                        .map(
                          (key) => NewChatLetterGroup(
                            letter: key,
                            letterFriends: snapshot.data![key],
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
