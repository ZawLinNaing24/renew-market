import "package:cloud_firestore/cloud_firestore.dart";

/*  For individual chat messages */
class MessageModel {
  final String senderId;
  final String content;
  final Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      content: map['content'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'senderId': senderId, 'content': content, 'timestamp': timestamp};
  }
}


/* 
  This model represents messages exchanged between users in the chat screen (to be developed in Chapter 5).
  This model will later be used for uploading mock message data.
*/