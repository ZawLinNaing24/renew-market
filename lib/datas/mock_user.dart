import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renew_market/models/user_%20model.dart';

UserModel mockUser = UserModel(
  userId: 'user_001',
  name: 'Jone Doe',
  email: 'janedoe@example.com',
  profileImage: '',
  joinedDate: Timestamp.fromDate(DateTime(2024, 1, 1)),
  favorites: ['post_001', 'post_002', 'post_003'],
);
