import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/compnents/conversation_list.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';

import '../services/webservice.dart';
import '../widgets/gameWidget/select_friend.dart';
import 'chat_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<Map<String, dynamic>>?> getFriends() async {
    final Response response =
        await Webservice.get("listFriends/${await Webservice.getUserId()}");
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ZIMConversationType conversationType;

    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: getFriends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No friends data available.');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Bipix Chat'),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];

                return GestureDetector(
                  child: SelectFriend(
                    name: user["username"],
                    id: user["id"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ChatPage();
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

// home_page.dart
