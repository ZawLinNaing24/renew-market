import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/helpers/cloud_firestore_helper.dart';
import 'package:renew_market/models/message_model.dart';
import 'package:renew_market/providers/user_provider.dart';

class ChatDetailScreen extends StatefulWidget {
  String chatId;
  String title;
  ChatDetailScreen({super.key, required this.chatId, required this.title});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late Stream<List<MessageModel>> _messagesStream;
  final CloudFirestoreHelper _cloudFirestoreHelper = CloudFirestoreHelper();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late UserProvider currentUser;

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    final newMessage = MessageModel(
      content: _messageController.text.trim(),
      senderId: currentUser.user.userId!,
      timestamp: Timestamp.now(),
    );
    await _cloudFirestoreHelper.sendMessage(
      chatId: widget.chatId,
      message: newMessage,
    );
    _messageController.clear();
  }

  Future<void> _loadCurrentUser() async {
    currentUser = Provider.of<UserProvider>(context, listen: false);
    await currentUser.loadUser(); // or any async method
  }

  @override
  void initState() {
    super.initState();
    _messagesStream = _cloudFirestoreHelper.getMessagesStream(widget.chatId);

    _loadCurrentUser();
    debugPrint("current user id${currentUser.user.userId}");
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('An error occurred: ${snapshot.error}'),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Scaffold(
                      body: Center(child: Text("No messages yet.")),
                    );
                  }
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSendByMe =
                          message.senderId == currentUser.user.userId;
                      return Column(
                        crossAxisAlignment:
                            isSendByMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                isSendByMe
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              if (!isSendByMe)
                                Padding(
                                  padding: const EdgeInsets.only(right: 9.0),
                                  child: CircleAvatar(
                                    backgroundColor: inActive,
                                    child: Icon(Icons.person_outlined),
                                  ),
                                ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSendByMe ? primary : inActive,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(message.content),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 2,
                            ),
                            child: Text(
                              DateFormat(
                                'hh:mm a',
                              ).format(message.timestamp.toDate()),
                            ),
                          ),
                        ],
                      ); // Placeholder
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.attach_file, size: 30),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      // onTapOutside: (_) {
                      //   FocusScope.of(context).unfocus();
                      // },
                      // focusNode: FocusNode(),
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Start typing...",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE8E8E8),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 53, 53, 53),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: primary,

                    icon: Icon(Icons.send, size: 30),
                    onPressed: () async {
                      _sendMessage();

                      await _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                      if (context.mounted) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
