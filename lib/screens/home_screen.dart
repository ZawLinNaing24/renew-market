import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/providers/post_provider.dart';

import 'package:renew_market/widgets/post_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postPvider = Provider.of<PostProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: PostGridView(postData: postPvider.posts),
    );
  }
}
