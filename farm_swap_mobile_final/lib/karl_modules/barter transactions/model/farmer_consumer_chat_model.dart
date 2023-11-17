import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessagModel {
  ChatMessagModel({
    required this.farmerId,
    required this.consumerId,
    required this.content,
    required this.time,
    required this.currentUserEmail,
    required this.senderId,
  });

//properties
  final String farmerId;
  final String currentUserEmail;
  final String consumerId;
  final String content;
  final Timestamp time;
  final String senderId;

  Map<String, dynamic> toMap() {
    return {
      'farmerId': farmerId,
      'consumerId': consumerId,
      'userEmail': currentUserEmail,
      'content': content,
      'time': time,
      'senderId': senderId,
    };
  }
}
