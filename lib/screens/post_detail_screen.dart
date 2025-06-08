import 'package:flutter/material.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/widgets/status_badge.dart';
import 'package:renew_market/widgets/time_ago.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: IconButton(
                  padding: EdgeInsets.all(3),
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: inActive),
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
                    "Contact Seller",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
