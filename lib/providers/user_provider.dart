import 'package:flutter/material.dart';
import 'package:renew_market/datas/mock_user.dart';
import 'package:renew_market/models/user_%20model.dart';

class UserProvider extends ChangeNotifier {
  final UserModel _user = mockUser;
  UserModel get user => _user;

  void addFavorite(String postId) {
    // Add implementation
    if (!_user.favorites.contains(postId)) {
      _user.favorites.add(postId);
    }
    notifyListeners();
  }

  void removeFavorite(String postId) {
    // Add implementation
    if (_user.favorites.contains(postId)) {
      _user.favorites.remove(postId);
    }
    notifyListeners();
  }
}
