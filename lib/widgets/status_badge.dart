import 'package:flutter/material.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/models/post_model.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: post.isAvailable ? active : inActive,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          post.isAvailable ? "For Sale" : "Sold Out",
          style: badgeText,
        ),
      ),
    );
  }
}
