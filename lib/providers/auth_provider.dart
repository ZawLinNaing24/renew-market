import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  void loadUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  //Email SignIn
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      loadUser();
      return true;
    } catch (e) {
      print('Sign-in error: $e');
      return false;
    }
  }

  // Email SingUp
  Future<bool> signUp(
    String email,
    String password,
    String name,
    String nickname,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        /* createUserWithEmailAndPassword(from Firebase Authenication) to register the new account*/
        email: email,
        password: password,
      );
      await createUserDocument(userCredential.user!, name, nickname);
      return true;
    } catch (e) {
      print('Sign-up error: $e');
      return false;
    }
  }

  /* use this method to store User information in the firestore */
  Future<void> createUserDocument(
    User user,
    String name,
    String nickname,
  ) async {
    final userDoc = {
      'email': user.email,
      'name': name,
      'nickname': nickname,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userDoc);
  }

  // Email SignOut
  /* to log users out using Firebase Authentication */
  Future<void> signOut() async {
    await _auth.signOut();
    loadUser();
    print('User signed out.');
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  void sendEmailVerification() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  void sendPasswordRestEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: _auth.currentUser!.email!);
    } catch (e) {
      print(e);
    }
  }
}
