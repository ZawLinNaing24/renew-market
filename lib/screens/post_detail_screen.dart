import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/providers/post_provider.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/screens/home_screen.dart';
import 'package:renew_market/widgets/status_badge.dart';
import 'package:renew_market/widgets/time_ago.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;
  const PostDetailScreen({super.key, required this.post});

  void _showMoreOptions(
    BuildContext context,
    PostProvider postPvider,
    String postId,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder:
          (context) => ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(("edit")),
                onTap: () {
                  null;
                },
              ),
              ListTile(
                title: Text("Delete"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.grey[200],
                        content: Text(
                          "Are You Sure To Delete?",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            onPressed:
                                Navigator.of(context).pop, // Close dialog
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              postPvider.removePost(postId);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Your post has been deleted."),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postPvider = Provider.of<PostProvider>(context);
    return Consumer<UserProvider>(
      builder: (context, userPvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Image.network(logoUrl, height: 40, fit: BoxFit.contain),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(post.images[0], fit: BoxFit.contain),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: StatusBadge(post: post),
                ),
                Text(post.title, style: title1),
                Text("\$${post.price.toString()}", style: priceText1),
                Text(timeAgo(post.createdAt)),
                Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, color: Colors.white),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.sellerId,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
                Divider(thickness: 1),
                Text(post.description, style: title2),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black38, width: 1)),
            ),
            child: BottomAppBar(
              // elevation: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userPvider.user.userId == post.sellerId
                      ? Container(
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(3),
                          onPressed: () {
                            _showMoreOptions(context, postPvider, post.postId);
                          },
                          icon: Icon(Icons.more_vert, color: inActive),
                        ),
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color:
                              !userPvider.user.favorites.contains(post.postId)
                                  ? background
                                  : activeOpacity,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(3),
                          onPressed: () {
                            !userPvider.user.favorites.contains(post.postId)
                                ? userPvider.addFavorite(post.postId)
                                : userPvider.removeFavorite(post.postId);
                            debugPrint(
                              "this is user favourite list${userPvider.user.favorites}",
                            );
                          },
                          icon: Icon(
                            Icons.favorite,

                            color:
                                !userPvider.user.favorites.contains(post.postId)
                                    ? inActive
                                    : active,
                          ),
                        ),
                      ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(0, 200),
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      isSemanticButton: true,
                      onPressed: () {},
                      child: Text(
                        (userPvider.user.userId == post.sellerId)
                            ? "Contact Buyer"
                            : "Contact Seller",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
