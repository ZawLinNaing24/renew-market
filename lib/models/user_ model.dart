import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String profileImage;
  final Timestamp joinedDate;
  final List<String> favorites;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.joinedDate,
    required this.favorites,
  });
}
