import 'package:bipixapp/models/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:bipixapp/services/api.dart';
import 'package:flutter/material.dart';

class NotificationsModalBottomSheeet extends StatefulWidget {
  const NotificationsModalBottomSheeet({super.key, this.notifications});

  final List<NotificationM>? notifications;

  @override
  State<NotificationsModalBottomSheeet> createState() =>
      _NotificationsModalBottomSheeetState();
}

class _NotificationsModalBottomSheeetState
    extends State<NotificationsModalBottomSheeet> {
  @override
  void initState() {
    clearNewNotifications();
    super.initState();
  }

  clearNewNotifications() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$baseUrl/clearNewNotifications'),
      body: {"userId": sharedPreferences.getString("USER_ID")},
    );
    if (kDebugMode) {
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
            top: -15,
            child: Container(
              width: 200,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
            )),
        Container(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) {
              return StreamBuilder<QuerySnapshot>(
                builder: (context, notificationSnap) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.notifications?.length ?? 0,
                        (index) {
                          final NotificationM notification =
                              widget.notifications![index];
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.title),
                                Text(notification.content),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    notification.createdAt
                                        .toString()
                                        .substring(5, 16)
                                        .replaceAll("-", "/"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
