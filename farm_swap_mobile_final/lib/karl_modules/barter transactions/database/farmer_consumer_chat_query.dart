import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/model/farmer_consumer_chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FarmerConsumerChatQuery {
  Future<void> sendMessage(
    String consumerid,
    String listingId,
    String message,
  ) async {
    final farmerid = FirebaseAuth.instance.currentUser!.uid;
    final farmerEmail = FirebaseAuth.instance.currentUser!.email;
    final Timestamp time = Timestamp.now();
    String docId = '$farmerid$consumerid';

    ChatMessagModel messageModel = ChatMessagModel(
      farmerId: farmerid,
      consumerId: consumerid,
      content: message,
      time: time,
      currentUserEmail: farmerEmail.toString(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    await FirebaseFirestore.instance
        .collection('sample_FC_ChatRoom')
        .doc(docId)
        .collection('chats')
        .add(messageModel.toMap());
  }

/*Send message method for consumer */
  Future<void> sendMessageConsumer(
    String farmerid,
    String listingId,
    String message,
  ) async {
    final consumerid = FirebaseAuth.instance.currentUser!.uid;
    final consumerEmail = FirebaseAuth.instance.currentUser!.email;
    final Timestamp time = Timestamp.now();
    String docId = '$farmerid$consumerid';

    ChatMessagModel messageModel = ChatMessagModel(
      farmerId: farmerid,
      consumerId: consumerid,
      content: message,
      time: time,
      currentUserEmail: consumerEmail.toString(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    await FirebaseFirestore.instance
        .collection('sample_FC_ChatRoom')
        .doc(docId)
        .collection('chats')
        .add(messageModel.toMap());
  }

  /*Pull outing the chat data */
  Stream<QuerySnapshot> getChatMessages(String farmerid, String consumerid) {
    String finaldocid = '$farmerid$consumerid';

    return FirebaseFirestore.instance
        .collection('sample_FC_ChatRoom')
        .doc(finaldocid)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  /*Pull outing the chat data */
  Stream<QuerySnapshot> getChatMessagesConsumerSide(String farmerid, String consumerid) {
    String finaldocid = '$farmerid$consumerid';

    return FirebaseFirestore.instance
        .collection('sample_FC_ChatRoom')
        .doc(finaldocid)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }
}
