import 'package:flutter/material.dart';
import 'package:renew_market/datas/mock_posts.dart';
import 'package:renew_market/screens/post_detail_screen.dart';
import 'package:renew_market/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            debugPrint("Print debug ${mockPosts[index]}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: mockPosts[index]),
              ),
            );
          },
          child: PostCard(post: mockPosts[index]),
        );
      },
    );
  }
}
