import 'package:cloud_firestore/cloud_firestore.dart';

/* For item listing posts */
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

  @override
  String toString() {
    return "title:$title";
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      sellerId: map['sellerId'] ?? '',
      sellerName: map['sellerName'] ?? '',
      location: map['location'] ?? const GeoPoint(0.0, 0.0),
      isAvailable: map['isAvailable'] ?? true,
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'location': location,
      'isAvailable': isAvailable,
      'createdAt': createdAt,
    };
  }
}
