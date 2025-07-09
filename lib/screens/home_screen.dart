import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/helpers/cloud_firestore_helper.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/providers/post_provider.dart';

import 'package:renew_market/widgets/post_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CloudFirestoreHelper cloudFirestoreHelper = CloudFirestoreHelper();
  @override
  Widget build(BuildContext context) {
    final postPvider = Provider.of<PostProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: cloudFirestoreHelper.getPostsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('An error occurred: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text("No posts available")));
        }

        final List<PostModel> posts =
            snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return PostModel.fromMap(data);
            }).toList();
        // debugPrint("posts data from firestore => ${posts.toString()}");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: PostGridView(postData: posts),
        );
      },
    );
  }
}
