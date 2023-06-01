import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationM {
  final String content;
  final DateTime createdAt;
  final String from;
  final String title;
  final String to;
  final String type;
  final bool visulized;

  NotificationM({
    required this.content,
    required this.createdAt,
    required this.from,
    required this.title,
    required this.to,
    required this.type,
    required this.visulized,
  });

  factory NotificationM.fromJson(Map<String, dynamic> map) => NotificationM(
        content: map["content"],
        createdAt: Timestamp(map["created_at"]["_seconds"],
                map["created_at"]["_nanoseconds"])
            .toDate(),
        from: map["from"],
        title: map["title"],
        to: map["to"],
        type: map["type"],
        visulized: map["visualized"],
      );

  static Map fromList(List<dynamic> maps) {
    List<NotificationM> notifications = [];
    int newNotifications = 0;
    for (int i = 0; i < maps.length; i++) {
      final notificationM = NotificationM.fromJson(maps[i]);
      notifications.add(notificationM);
      if (!notificationM.visulized) {
        newNotifications++;
      }
    }
    return {
      "notifications": notifications,
      "newNotifications": newNotifications
    };
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "created_at": createdAt,
        "from": from,
        "title": title,
        "to": to,
        "type": type,
        "visualized": visulized,
      };
}
