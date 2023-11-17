import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/farmer_consumer_chatbubble.dart';

class FarmerConsumerGetMessages extends StatefulWidget {
  const FarmerConsumerGetMessages({super.key, required this.farmerId, required this.consumerId});

  final String farmerId;
  final String consumerId;

  @override
  State<FarmerConsumerGetMessages> createState() => _FarmerConsumerGetMessagesState();
}

class _FarmerConsumerGetMessagesState extends State<FarmerConsumerGetMessages> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('sample_FC_ChatRoom')
          .doc('${widget.farmerId}${widget.consumerId}')
          .collection('chats')
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.error);
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((document) => accessDocumentContents(document))
                .toList(),
          );
        } else {
          return Text('Loading');
        }
      },
    );
  }

  /*This methods access the properties and its value of each document that is baing passed here*/
  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var messageAlignment = (data["senderId"] != FirebaseAuth.instance.currentUser!.uid)
        ? Alignment.topLeft
        : Alignment.topRight;

    /*Converting the date into string*/
    Timestamp timeSTMP = data["time"];
    DateTime dateTime = timeSTMP.toDate();
    String finalDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return Container(
      alignment: messageAlignment,
      child: Column(
        crossAxisAlignment: (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(
            finalDate,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
          (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
              ? FarmerConsumerSenderChatBubble(content: data["content"])
              : FarmerConsumerReceiverChatBubble(content: data["content"])
        ],
      ),
    );
  }
}
