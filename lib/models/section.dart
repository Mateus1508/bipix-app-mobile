import 'package:cloud_firestore/cloud_firestore.dart';

class SectionModel {
  SectionModel({
    required this.createdAt,
    required this.id,
    required this.adminId,
    required this.adminName,
    required this.invitedId,
    required this.invitedName,
  });

  final DateTime createdAt;
  final String id;
  final String adminId;
  final String adminName;
  final String invitedId;
  final String invitedName;

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        createdAt: Timestamp(
          (json["created_at"] as Timestamp).seconds,
          json["created_at"].nanoseconds,
        ).toDate(),
        id: json["id"],
        adminId: json["admin_id"],
        adminName: json["admin_name"],
        invitedId: json["invited_id"],
        invitedName: json["invited_name"],
      );
}
