import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:renew_market/models/post_model.dart';

class CloudFirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream() {
    return _firestore.collection("posts").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOnePost(String postId) {
    return _firestore.collection("posts").doc(postId).snapshots();
  }

  Future<void> uploadPost(PostModel post) async {
    try {
      await _firestore.collection('posts').doc(post.postId).set({
        'postId': post.postId,
        'title': post.title,
        'description': post.description,
        'price': post.price,
        'images': post.images,
        'sellerId': post.sellerId,
        'sellerName': post.sellerName,
        'location': GeoPoint(post.location.latitude, post.location.longitude),
        'isAvailable': post.isAvailable,
        'createdAt': post.createdAt,
      });
    } catch (e) {
      throw Exception('Error uploading post: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception("Error Whild deleting the post: $e");
    }
  }

  Future<void> updatePost({
    required String postId,
    required String title,
    required String description,
    required String price,
    required String selectedImageUrl,
  }) async {
    try {
      await _firestore.collection("posts").doc(postId).update({
        "title": title,
        "description": description,
        "price": num.tryParse(price),
        "images": [selectedImageUrl],
      });
    } catch (e) {
      throw Exception("Error While Updating the post: $e");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsStream(String userId) {
    return _firestore
        .collection("chats")
        .where("participants", arrayContains: userId)
        .snapshots();
  }
}
