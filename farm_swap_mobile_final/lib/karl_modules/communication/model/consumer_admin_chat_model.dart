class AdminConsumerChatModel {
  AdminConsumerChatModel({
    required this.adminId,
    required this.adminEmail,
    required this.consumerId,
    required this.time,
    required this.messageContent,
    required this.senderId,
  });
  final String adminId;
  final String adminEmail;
  final String consumerId;
  final String senderId;
  final String messageContent;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'adminEmail': adminEmail,
      'senderId': senderId,
      'farmerId': consumerId,
      'messageTime': time,
      'messageContent': messageContent,
    };
  }
}
