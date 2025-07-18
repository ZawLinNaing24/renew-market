import 'package:renew_market/models/message_model.dart';

/* For chat room data */
class ChatModel {
  final String id; // Chat room ID
  final String title; // Chat room title
  final List<String> participants; // List of participants
  final String? postId; // Item ID
  final String transactionStatus; // Transaction status
  final MessageModel? lastMessage; // Last message in the chat

  ChatModel({
    required this.id,
    required this.title,
    required this.participants,
    this.postId,
    this.transactionStatus = 'pending',
    this.lastMessage,
  });

  // Convert Firestore data to an object
  factory ChatModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatModel(
      id: id,
      title: map['title'] ?? 'Unknown',
      participants: List<String>.from(map['participants'] ?? []),
      postId: map['postId'],
      transactionStatus: map['transactionStatus'] ?? 'pending',
      lastMessage:
          map['lastMessage'] != null
              ? MessageModel.fromMap(map['lastMessage'])
              : null,
    );
  }

  // Convert object to Firestore-storable data
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'participants': participants,
      'postId': postId,
      'transactionStatus': transactionStatus,
      'lastMessage': lastMessage?.toMap(),
    };
  }
}

/*  
  This model represents chat rooms, which will be used for implementing chat functionalities in Chapter 5.
  Mock chat data will be uploaded using this model in subsequent tasks.
*/
