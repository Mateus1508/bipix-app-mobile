import 'dart:math';

import 'package:bipixapp/pages/chatPage/random_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../main.dart';
import '../../services/webservice.dart';
import 'home_page.dart';

final String testRandomUserID = Random().nextInt(10000).toString();
final String testRandomUserName = randomName();

class ZIMKitDemoLoginPage extends StatefulWidget {
  const ZIMKitDemoLoginPage({Key? key}) : super(key: key);

  @override
  State<ZIMKitDemoLoginPage> createState() => _ZIMKitDemoLoginPageState();
}

class _ZIMKitDemoLoginPageState extends State<ZIMKitDemoLoginPage> {
  final userID = TextEditingController(text: testRandomUserID);
  final userName = TextEditingController(text: testRandomUserName);

  @override
  void initState() {
    super.initState();
    userID.text = testRandomUserID;
    userName.text = testRandomUserName;
  }

  Future getUser() async {
    final userId = await Webservice.getUserId();
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final DocumentSnapshot userdoc = snapshot.data;
                return Padding(
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
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await ZIMKit()
                                    .connectUser(
                                        id: userdoc.id,
                                        name: userdoc.get("username"))
                                    .then((errorCode) {
                                  if (mounted) {
                                    if (errorCode == 0) {
                                      onUserLogin(
                                          userdoc.id, userdoc.get("username"));
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ZIMKitDemoHomePage(),
                                        ),
                                      );
                                      print(userdoc.data());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                );
              }),
        ),
      ),
    );
  }
}
