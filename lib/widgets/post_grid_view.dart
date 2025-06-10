import 'package:flutter/material.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/screens/post_detail_screen.dart';
import 'package:renew_market/widgets/post_card.dart';

class PostGridView extends StatelessWidget {
  List<PostModel> postData;
  PostGridView({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: postData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            debugPrint("Print debug ${postData[index]}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: postData[index]),
              ),
            );
          },
          child: PostCard(post: postData[index]),
        );
      },
    );
  }
}
