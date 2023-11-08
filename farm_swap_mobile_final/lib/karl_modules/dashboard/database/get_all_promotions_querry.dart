import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllPromotionsQuerry {
  final _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getAllSubcollectionData() {
    final controller = StreamController<QuerySnapshot>();

    FirebaseFirestore.instance
        .collection('sample_BarterListings')
        .snapshots() // Stream of the parent collection documents
        .listen((parentCollectionSnapshot) async {
      // Iterate through the parent collection documents and retrieve subcollection data
      for (var parentDoc in parentCollectionSnapshot.docs) {
        final subcollectionSnapshot =
            await parentDoc.reference.collection('barter').get(); // Get the subcollection data
        controller.add(subcollectionSnapshot);
      }
    });

    return controller.stream;
  }

  Future<List<String>> getDocumentIdsFromFirestore() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('yourCollection').get();
    final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

/*We pull out the listing that has only promoted status set to true */
  Stream<QuerySnapshot> getPromotedBarterListings() {
    print(getDocumentIdsFromFirestore().toString());
    return _firestore
        .collection("sample_BarterListings")
        .doc(
          getDocumentIdsFromFirestore().toString(),
        )
        .collection('barter')
        .where('promoted', isEqualTo: true)
        .orderBy('listingStartTime', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getPromotedListings() {
    return _firestore
        .collection("sample_BarterListings")
        .doc()
        .collection('barter')
        .where('promoted', isEqualTo: true)
        .orderBy('listingStartTime', descending: false)
        .snapshots();
  }
}
