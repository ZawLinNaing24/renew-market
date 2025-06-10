import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/datas/mock_posts.dart';
import 'package:renew_market/datas/mock_user.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/widgets/post_grid_view.dart';

class MySalesTab extends StatelessWidget {
  const MySalesTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<PostModel> currentUserSellPost =
        mockPosts.where((post) => post.sellerId == mockUser.userId).toList();
    debugPrint(currentUserSellPost.toString());
    return PostGridView(postData: currentUserSellPost);
  }
}

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Reviews'));
  }
}

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userPvider = Provider.of<UserProvider>(context);
    List<PostModel> favoritePost =
        mockPosts
            .where((post) => userPvider.user.favorites.contains(post.postId))
            .toList();

    return PostGridView(postData: favoritePost);
  }
}
