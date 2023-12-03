class AdminFarmerChatModel {
  AdminFarmerChatModel({
    required this.adminId,
    required this.adminEmail,
    required this.farmerId,
    required this.time,
    required this.messageContent,
    required this.senderId,
  });
  final String adminId;
  final String adminEmail;
  final String farmerId;
  final String senderId;
  final String messageContent;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'adminEmail': adminEmail,
      'senderId': senderId,
      'farmerId': farmerId,
      'messageTime': time,
      'messageContent': messageContent,
    };
  }
}
