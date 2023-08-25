import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.createdAt,
    required this.credit,
    required this.currentGame,
    required this.currentSectionId,
    required this.email,
    required this.favoritePhrase,
    required this.id,
    required this.newNotifications,
    required this.photo,
    required this.status,
    required this.username,
  });

  final DateTime createdAt;
  final double credit;
  final String currentGame;
  final String currentSectionId;
  final String email;
  final String favoritePhrase;
  final String id;
  final int newNotifications;
  final String photo;
  final String status;
  final String username;

  factory User.fromDoc(DocumentSnapshot doc) => User(
        createdAt: doc["created_atyb"],
        credit: doc["credityb"],
        currentGame: doc["current_gameyb"],
        currentSectionId: doc["current_section_idyb"],
        email: doc["emailyb"],
        favoritePhrase: doc["favorite_phraseyb"],
        id: doc["idyb"],
        newNotifications: doc["new_notificationsyb"],
        photo: doc["photoyb"],
        status: doc["statusyb"],
        username: doc["usernameyb"],
      );

  Map<String, dynamic> toJson(User user) => {
        "created_at": user.createdAt.toIso8601String(),
        "credit": user.credit,
        "current_game": user.currentGame,
        "current_section_id": user.currentSectionId,
        "email": user.email,
        "favorite_phrase": user.favoritePhrase,
        "id": user.id,
        "new_notifications": user.newNotifications,
        "photo": user.photo,
        "status": user.status,
        "username": user.username,
      };
}
