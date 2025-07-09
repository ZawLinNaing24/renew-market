import 'package:cloud_firestore/cloud_firestore.dart';

/* For user-related data */
class UserModel {
  final String? userId;
  final String? name;
  final String? nickname;
  final String? email;
  final String? profileImage;
  final Timestamp? joinedDate;
  final List<String>? favorites;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.nickname,
    this.profileImage,
    required this.joinedDate,
    this.favorites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      nickname: json['nickname'],
      // profileImage: json['description'],
      joinedDate: json['createdAt'],
      favorites:
          (json['favorites'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "nickname": nickname,
      "profileImage": profileImage,
      "joinedDate": joinedDate,
    };
  }
}
