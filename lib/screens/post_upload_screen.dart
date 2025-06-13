import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/datas/mock_posts.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/providers/post_provider.dart';
import 'package:renew_market/widgets/custom_input_field.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  @override
  _PostUploadScreenState createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  final _formKey = GlobalKey<FormState>(); // Form validation key
  final TextEditingController _titleController =
      TextEditingController(); // Controller for title input
  final TextEditingController _descriptionController =
      TextEditingController(); // Controller for description input
  final TextEditingController _priceController =
      TextEditingController(); // Controller for price input

  @override
  void dispose() {
    // Dispose controllers when the screen is destroyed
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  PostModel _addPost() {
    PostModel? newPost;
    if (_formKey.currentState!.validate()) {
      newPost = PostModel(
        postId: 'post_${mockPosts.length + 1}',
        title: _titleController.text,
        description: _descriptionController.text,
        price: num.tryParse(_priceController.text) ?? 0,
        images: [
          'https://raw.githubusercontent.com/devSWF/MicroLearnable-Resources/refs/heads/main/Practical%20Application%20Project/Assets/Images/default_image.png',
        ],
        sellerId: 'user_001',
        sellerName: 'John Doe',
        location: const GeoPoint(37.7749, -122.4194), // 임시 위치 값
        isAvailable: true,
        createdAt: Timestamp.now(),
      );
    }
    return newPost!;
  }

  @override
  Widget build(BuildContext context) {
    final postPvider = Provider.of<PostProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach the validation key
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Photo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: text,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.camera_alt_outlined),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: text,
                    ),
                  ),
                ),
                CustomInputField(
                  controller: _titleController,
                  isNum: false,
                  lines: 1,
                  validationMessage: "Title cannot be empty",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: text,
                    ),
                  ),
                ),
                CustomInputField(
                  controller: _priceController,
                  isNum: true,
                  lines: 1,
                  validationMessage: "Price cannot be empty",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Descriptioin",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: text,
                    ),
                  ),
                ),
                CustomInputField(
                  controller: _descriptionController,
                  isNum: false,
                  lines: 3,
                  validationMessage: "Desription cannot be empty ",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          isSemanticButton: true,
                          onPressed: () {
                            debugPrint("add new${_addPost()}");
                            postPvider.addPost(_addPost());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully added!')),
                            );
                            _titleController.clear();
                            _priceController.clear();
                            _descriptionController.clear();
                          },
                          child: Text(
                            "Add a Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
