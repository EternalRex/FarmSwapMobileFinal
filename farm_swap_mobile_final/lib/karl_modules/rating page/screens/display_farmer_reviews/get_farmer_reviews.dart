import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetFarmerReviews extends StatefulWidget {
  const GetFarmerReviews({super.key});

  @override
  State<GetFarmerReviews> createState() => _GetFarmerReviewsState();
}

class _GetFarmerReviewsState extends State<GetFarmerReviews> {
  final _firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebase
          .collectionGroup('reviewrating')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>((document) => accessDocumentContents(document))
                  .toList(),
            );
          }
          return const Text("No Data Found");
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String consumerUserName = data["consumerUname"];
    String review = data["review"];
    double rate = data["rate"];
    Timestamp reviewDate = data["reviewDate"];
    DateTime finalReviewDate = reviewDate.toDate();
    String stringFinalReviewDate = DateFormat('MM-dd-yyyy').format(finalReviewDate);

    return Container();
  }
}
