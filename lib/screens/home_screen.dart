import 'package:flutter/material.dart';
import 'package:renew_market/datas/mock_posts.dart';

import 'package:renew_market/widgets/post_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PostGridView(postData: mockPosts);
  }
}
