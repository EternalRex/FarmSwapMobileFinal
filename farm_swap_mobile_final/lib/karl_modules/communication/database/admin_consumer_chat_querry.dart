import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/model/consumer_admin_chat_model.dart';

class AdminConsumerChatQuery {
  Future<void> sendMessage(
    String consumerid,
    String adminId,
    String adminEmail,
    String message,
  ) async {
    String finalDocId = 'Chat$adminId$consumerid';
    DateTime chatDate = DateTime.now();

    final adminFarmerChat = AdminConsumerChatModel(
      adminId: adminId,
      adminEmail: adminEmail,
      consumerId: consumerid,
      time: chatDate,
      messageContent: message,
      senderId: consumerid,
    );
    await FirebaseFirestore.instance
        .collection('sample_AdminConsumerChat')
        .doc(finalDocId)
        .collection('adminconsumerchat')
        .add(adminFarmerChat.toMap());
  }

  //Gettig the message
  Stream<QuerySnapshot> getChatMessages(String consumerid, String adminId) {
    String finalChatRoomId = 'Chat$adminId$consumerid';

    //pulls out the messages in the specific chat room
    return FirebaseFirestore.instance
        .collection('sample_AdminConsumerChat')
        .doc(finalChatRoomId)
        .collection("adminconsumerchat")
        .orderBy('messageTime', descending: false)
        .snapshots();
  }
}
