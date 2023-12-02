import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/model/farmer_admin_chat_model.dart';

class FarmerAdminChatQuerry {
  Future<void> sendMessage(
    String farmerid,
    String adminId,
    String adminEmail,
    String message,
  ) async {
    String finalDocId = 'Chat$adminId$farmerid';
    DateTime chatDate = DateTime.now();

    final adminFarmerChat = AdminFarmerChatModel(
      adminId: adminId,
      adminEmail: adminEmail,
      farmerId: farmerid,
      time: chatDate,
      messageContent: message,
      senderId: farmerid,
    );

    await FirebaseFirestore.instance
        .collection('sample_AdminFarmerChat')
        .doc(finalDocId)
        .collection('adminfarmerchat')
        .add(adminFarmerChat.toMap());
  }

  //Gettig the message
  Stream<QuerySnapshot> getChatMessages(String farmerid, String adminId) {
    String finalChatRoomId = 'Chat$adminId$farmerid';

    //pulls out the messages in the specific chat room
    return FirebaseFirestore.instance
        .collection('sample_AdminFarmerChat')
        .doc(finalChatRoomId)
        .collection("adminfarmerchat")
        .orderBy('messageTime', descending: false)
        .snapshots();
  }
}
