import 'package:flutter/material.dart';
import 'package:renew_market/datas/mock_posts.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/widgets/post_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<PostModel>? _searchResult;

  void _performSearch(String searchItem) {
    _searchResult =
        mockPosts
            .where(
              (post) =>
                  post.title.toLowerCase().contains(searchItem.toLowerCase()),
            )
            .toList();
    print(_searchResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _performSearch(value);
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child:
                _searchResult == null
                    ? Center(child: Text("No Result Found"))
                    : PostGridView(postData: _searchResult!),
          ),
        ],
      ),
    );
  }
}
