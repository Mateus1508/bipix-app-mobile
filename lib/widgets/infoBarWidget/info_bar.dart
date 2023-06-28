import 'package:bipixapp/pages/notifications_page.dart';
import 'package:bipixapp/services/webservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bipixapp/services/api.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../models/notification.dart';
import '../../pages/game_page.dart';

class InfoBar extends StatefulWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => _InfoBarState();

  @override
  Size get preferredSize => const Size.fromHeight(45.0);
}

class _InfoBarState extends State<InfoBar> {
  List<NotificationM>? notifications;

  int newNotifications = 0;
  @override
  void initState() {
    // getNotifications();
    super.initState();
  }

  Future<void> getNotifications() async {
    notifications = [];
    final response = await http.post(
      Uri.parse('$baseUrl/notifications'),
      body: {"userId": await Webservice.getUserId()},
    );

    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          Map notificationsData = NotificationM.fromList(jsonResponse);
          notifications = notificationsData["notifications"];
          newNotifications = notificationsData["newNotifications"];
        });
      } else {
        if (kDebugMode) {
          print(
              'Erro ao obter usuários. Código de status: ${response.statusCode}');
        }
      }
    } catch (e) {
      notifications = [];
    }
  }

  // void _handleShowModalBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  //     builder: (context) => DraggableScrollableSheet(
  //       expand: false,
  //       initialChildSize: 0.4,
  //       minChildSize: 0.32,
  //       maxChildSize: 0.9,
  //       builder: (context, scrollController) => SingleChildScrollView(
  //         controller: scrollController,
  //         child: NotificationsModalBottomSheeet(notifications: notifications),
  //       ),
  //     ),
  //   );
  // }

  Stream<Map<String, dynamic>> getUserStream() async* {
    String userId = await Webservice.getUserId();
    await for (final doc in FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()) {
      yield doc.data() ?? {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0XFF0472E8),
      elevation: 2,
      leading: Image.asset('assets/images/bipixLogo.png'),
      actions: [
        Flexible(
          flex: 1,
          child: StreamBuilder<Map<String, dynamic>>(
            initialData: const {},
            stream: getUserStream(),
            builder: (context, userSnap) {
              if (userSnap.data!["current_section_id"] != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(
                            sectionId: userSnap.data!["current_section_id"]),
                      ));
                });
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 70),
                    padding: const EdgeInsets.only(right: 7, left: 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 1,
                            spreadRadius: 3),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.wallet,
                          color: Colors.black,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\$ ${userSnap.data!["credit"]},00",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: <Widget>[
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationsPage()));
                            Webservice.post(
                              function: "clearNewNotifications",
                              body: {"userId": await Webservice.getUserId()},
                            );
                          },
                          icon: const Icon(Icons.notifications),
                        ),
                        if (userSnap.data != null &&
                            userSnap.data!.isNotEmpty &&
                            userSnap.data!["new_notifications"] > 0)
                          Positioned(
                            right: 20,
                            top: 2,
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationsPage()));
                                Webservice.post(
                                  function: "clearNewNotifications",
                                  body: {
                                    "userId": await Webservice.getUserId()
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(userSnap.data!["new_notifications"]
                                    .toString()),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
