import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/helpers/cloud_firestore_helper.dart';
import 'package:renew_market/models/post_model.dart';
import 'package:renew_market/providers/post_provider.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/widgets/custom_input_field.dart';

class PostEditScreen extends StatefulWidget {
  final PostModel post;
  const PostEditScreen({super.key, required this.post});

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final _formKey = GlobalKey<FormState>(); // Form validation key
  final TextEditingController _titleController =
      TextEditingController(); // Controller for title input
  final TextEditingController _descriptionController =
      TextEditingController(); // Controller for description input
  final TextEditingController _priceController =
      TextEditingController(); // Controller for price input
  late String? userId;
  late String? userName;
  // String? selectedImage;
  late ValueNotifier<String?> selectedImageNotifier;
  final firestoreHelper = CloudFirestoreHelper();

  @override
  void initState() {
    selectedImageNotifier = ValueNotifier<String?>(widget.post.images[0]);
    _titleController.value = TextEditingValue(text: widget.post.title);
    _priceController.value = TextEditingValue(
      text: widget.post.price.toString(),
    );
    _descriptionController.value = TextEditingValue(
      text: widget.post.description,
    );

    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers when the screen is destroyed
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updatePost(
    postId,
    title,
    description,
    price,
    selectedImageUrl,
  ) async {
    if (_formKey.currentState!.validate()) {
      await firestoreHelper.updatePost(
        postId: postId,
        title: title,
        description: description,
        price: price,
        selectedImageUrl: selectedImageUrl,
      );
    }
  }

  Future<void> _pickImage() async {
    final albumImages = [
      postImg1,
      postImg2,
      postImg3,
      postImg4,
      postImg5,
      postImg6,
      postImg7,
      postImg8,
      postImg9,
    ];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Center(child: Text("Select Photo", style: title2)),
              ),
              Divider(thickness: 0.5),
              GridView.builder(
                itemCount: albumImages.length,
                padding: const EdgeInsets.all(12),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () async {
                      // setState(() {
                      //   selectedImage = albumImages[index].toString();
                      // });
                      selectedImageNotifier.value =
                          albumImages[index].toString();
                      print("image url => ${selectedImageNotifier.value}");
                      Navigator.pop(context);
                    },
                    child: Image.network(albumImages[index], fit: BoxFit.cover),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final postPvider = Provider.of<PostProvider>(context, listen: false);
    final userPvider = Provider.of<UserProvider>(context, listen: false);
    userPvider.loadUser();

    return Scaffold(
      appBar: AppBar(title: Text("Edit Post"), centerTitle: true),
      body: FutureBuilder(
        future: userPvider.loadUser(),
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
          userId = userPvider.user.userId;
          userName = userPvider.user.name;
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
                      InkWell(
                        onTap: () async {
                          await _pickImage();
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedImageNotifier,
                          builder: (context, currentSelectedImage, child) {
                            print("Current select image $currentSelectedImage");
                            if (currentSelectedImage != null &&
                                currentSelectedImage.isNotEmpty) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    currentSelectedImage,
                                    height: 40,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(Icons.camera_alt_outlined),
                              );
                            }
                          },
                        ),
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
                        type: "price",
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
                                onPressed: () async {
                                  // debugPrint("add new${_addPost()}");
                                  // postPvider.addPost(_addPost());
                                  // await firestoreHelper.uploadPost(_addPost());
                                  try {
                                    await _updatePost(
                                      widget.post.postId,
                                      _titleController.text,
                                      _descriptionController.text,
                                      _priceController.text,
                                      selectedImageNotifier.value,
                                    );

                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Post Updated Successfully',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to update the post',
                                        ),
                                      ),
                                    );
                                    throw Exception(
                                      "Error Happen while updatig the post: $e",
                                    );
                                  }

                                  // setState(() {});
                                },
                                child: Text(
                                  "Update Product",
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
        },
      ),
    );
  }
}
