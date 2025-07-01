import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renew_market/datas/mock_user.dart';
import 'package:renew_market/models/user_%20model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;
  // final bool _isLoading = true;
  // final bool _hasError = false;
  // bool get isLoading => _isLoading;
  // bool get hasError => _hasError;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserProvider() {
    loadUser();
  }

  void addFavorite(String postId) {
    // Add implementation
    if (!_user.favorites!.contains(postId)) {
      _user.favorites!.add(postId);
    }
    notifyListeners();
  }

  void removeFavorite(String postId) {
    // Add implementation
    if (_user.favorites!.contains(postId)) {
      _user.favorites!.remove(postId);
    }
    notifyListeners();
  }

  Future<void> loadUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      try {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get();
        print("doc data -> ${doc.data()} ");
        if (doc.exists) {
          _user = await UserModel.fromJson(doc.data()!);
          // debugPrint("add _user from UserModel ${user.name}");
          // debugPrint("Current user doc form firestorre ${_user.email}");
          notifyListeners();
        } else {
          print('User document not found in Firestore.');
        }
      } catch (e) {
        print('Error loading user: $e');
      }
    } else {
      print('No user is currently logged in.');
    }
  }
}
