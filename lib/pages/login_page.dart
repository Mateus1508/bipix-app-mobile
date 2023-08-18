import 'dart:convert';
import 'dart:math';

import 'package:bipixapp/pages/home_page.dart';
import 'package:bipixapp/pages/random_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../services/api.dart';
import '../services/webservice.dart';

final String testRandomUserID = Random().nextInt(10000).toString();
final String testRandomUserName = randomName();

class ChatLoginPage extends StatefulWidget {
  const ChatLoginPage({Key? key}) : super(key: key);

  @override
  State<ChatLoginPage> createState() => _ChatLoginPageState();
}

class _ChatLoginPageState extends State<ChatLoginPage> {
  Stream<Map<String, dynamic>> getStream() async* {
    await for (DocumentSnapshot<Map<String, dynamic>> doc in FirebaseFirestore
        .instance
        .collection("users")
        .doc((await Webservice.getUserId()))
        .snapshots()) {
      yield doc.data()!;
    }
  }

  Future<String> getUserName(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/idusers/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['username'];
    } else {
      throw Exception('Erro ao recuperar o usuário');
    }
  }

  Future<String> getUserId() async {
    return Webservice.getUserId();
  }

  final userID = TextEditingController(text: testRandomUserID);
  var username = TextEditingController(text: testRandomUserName);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: userID,
                        decoration: const InputDecoration(labelText: 'user ID'),
                      ),
                      TextFormField(
                        controller: username,
                        decoration:
                            const InputDecoration(labelText: 'user name'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await ZIMKit()
                              .connectUser(id: userID.text, name: username.text)
                              .then((errorCode) {
                            if (mounted) {
                              if (errorCode == 0) {
                                onUserLogin(userID.text, username.text);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const ChatPage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'login failed, errorCode: $errorCode'),
                                  ),
                                );
                              }
                            }
                          });
                        },
                        child: const Text('login'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
