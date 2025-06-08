import 'package:flutter/material.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/widgets/status_badge.dart' show StatusBadge;
import 'package:renew_market/widgets/time_ago.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // Rounded corners for the card
      ),
      elevation: 3, // Shadow effect for the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ), // Sets border radius
            child: Stack(
              children: [
                Image.network(
                  post.images[0], // Replace with your image URL
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(left: 125, top: 10, child: StatusBadge(post: post)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: title2),
                Text("\$${post.price.toString()}", style: priceText2),
                Text(timeAgo(post.createdAt)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
