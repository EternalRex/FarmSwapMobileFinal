import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetConsumerListsForChat extends StatefulWidget {
  const GetConsumerListsForChat({super.key});

  @override
  State<GetConsumerListsForChat> createState() => _GetConsumerListsForChatState();
}

class _GetConsumerListsForChatState extends State<GetConsumerListsForChat> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("sample_ConsumerUsers").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView(
            children:
                snapshot.data!.docs.map<Widget>((document) => accessDocuments(document)).toList(),
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }

  Widget accessDocuments(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Container();
  }
}
