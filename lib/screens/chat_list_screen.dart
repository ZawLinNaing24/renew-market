import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/helpers/cloud_firestore_helper.dart';
import 'package:renew_market/models/chat_model.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/widgets/time_ago.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final CloudFirestoreHelper _cloudFirestoreHelper = CloudFirestoreHelper();
  late UserProvider userPvider;

  // @override
  // void initState() async {
  //   userPvider = Provider.of<UserProvider>(context);
  //   await userPvider.loadUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserProvider>().loadUser(),
      builder: (context, snapshot) {
        userPvider = Provider.of<UserProvider>(context);
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
        return StreamBuilder<QuerySnapshot>(
          stream: _cloudFirestoreHelper.getChatsStream(userPvider.user.userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
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
                body: Center(child: Text("No chats available yet")),
              );
            }
            final chats =
                snapshot.data!.docs
                    .map(
                      (doc) => ChatModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                        doc.id,
                      ),
                    )
                    .toList();
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      title: Text(chats[index].title),
                      subtitle:
                          chats[index].lastMessage!.content != "" ||
                                  chats[index].lastMessage!.content.isNotEmpty
                              ? Text(
                                chats[index].lastMessage!.content,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              )
                              : Text("No Messages yet."),
                      trailing:
                          chats[index].lastMessage!.content != "" ||
                                  chats[index].lastMessage!.content.isNotEmpty
                              ? Text(
                                timeAgo(chats[index].lastMessage!.timestamp),
                              )
                              : null,
                    ),
                    Divider(thickness: 1, height: 0, indent: 10, endIndent: 10),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
