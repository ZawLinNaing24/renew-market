import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId; // Unique identifier for the post
  final String title; // The title of the post
  final String description; // Detailed description of the post
  final num price; // Price of the item being sold
  final List<String> images; // List of image URLs for the post
  final String sellerId; // Identifier for the seller
  final String sellerName; // Name of the seller
  final GeoPoint location; // Location of the seller or desired meeting place
  final bool
  isAvailable; // Availability status of the post (true: for sale, false: sold out)
  final Timestamp createdAt; // Timestamp for when the post was created

  PostModel({
    required this.postId,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.sellerId,
    required this.sellerName,
    required this.location,
    required this.isAvailable,
    required this.createdAt,
  });

  // String toString() {
  //   return "title:${title}";
  // }
}
