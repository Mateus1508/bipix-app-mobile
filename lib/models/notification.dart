import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationM {
  final String content;
  final String id;
  final DateTime createdAt;
  final String from;
  final String title;
  final String to;
  final String type;
  final String status;
  final bool visualized;

  NotificationM({
    required this.content,
    required this.id,
    required this.createdAt,
    required this.from,
    required this.title,
    required this.to,
    required this.type,
    required this.status,
    required this.visualized,
  });

  factory NotificationM.fromJson(Map<String, dynamic> map) => NotificationM(
        id: map["id"],
        content: map["content"],
        createdAt: Timestamp(
          (map["created_at"] as Timestamp).seconds,
          map["created_at"].nanoseconds,
        ).toDate(),
        from: map["from"],
        title: map["title"],
        to: map["to"],
        type: map["type"],
        status: map["status"],
        visualized: map["visualized"],
      );

  static Map fromList(List<dynamic> maps) {
    List<NotificationM> notifications = [];
    int newNotifications = 0;
    for (int i = 0; i < maps.length; i++) {
      final notificationM = NotificationM.fromJson(maps[i]);
      notifications.add(notificationM);
      if (!notificationM.visualized) {
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
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "from": from,
        "title": title,
        "to": to,
        "type": type,
        "status": status,
        "visualized": visualized,
      };
}
