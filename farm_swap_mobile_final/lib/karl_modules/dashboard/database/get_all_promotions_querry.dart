import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllPromotionsQuerry {
  final _firestore = FirebaseFirestore.instance;
  String docid = "";

/*
  Stream<List<DocumentSnapshot>> getSubCollectionData4() {
    Stream<List<DocumentSnapshot>> snapshots = [];

    _firestore
        .collection("sample_BarterListings")
        .get()
        .then((value) => value.docs.forEach((result) {
              _firestore
                  .collection("sample_BarterListings")
                  .doc(result.id)
                  .collection('barter')
                  .get()
                  .asStream();
            }));

    return snapshots;
  }

/*
  Stream<QueryDocumentSnapshot> getDocs() {
    _firestore
        .collection("sample_BarterListings")
        .where(FieldPath.documentId, isGreaterThan: '')
        .get()
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              _firestore
                  .collection("sample_BarterListing")
                  .doc(doc.id)
                  .collection('barter')
                  .get()
                  .then((QuerySnapshot subquerySnapshot) => subquerySnapshot.docs.forEach((subdoc) {
                        stream = subdoc;
                      }));
            }));
    return stream;
  }*/

  Future<List<DocumentSnapshot>> getSubCollectionDataFuture() async {
    final parentCollectionQuery = _firestore.collection("sample_BarterListings");
    final parentCollectionSnapshot = await parentCollectionQuery.get();

    final List<DocumentSnapshot> subCollectionDocuments = [];

    for (var parentDoc in parentCollectionSnapshot.docs) {
      final subCollectionQuery = parentCollectionQuery.doc(parentDoc.id).collection('barter');
      final subCollectionSnapshot = await subCollectionQuery.get();
      subCollectionDocuments.addAll(subCollectionSnapshot.docs);
    }

    return subCollectionDocuments;
  }

  Future<void> getSubCollectionData() async {
    _firestore
        .collection("sample_BarterListings")
        .get()
        .then((value) => value.docs.forEach((resutl) {
              _firestore
                  .collection("sampleBarterListings")
                  .doc(resutl.id)
                  .collection('barter')
                  .get()
                  .then((subcol) => subcol.docs.forEach((element) {
                        print(element);
                      }));
            }));
  }

  Future<void> subcollectionSnap() {
    return _firestore
        .collection("sample_BarterListings")
        .get()
        .then((value) => value.docs.forEach((element) {
              _firestore
                  .collection('sample_BarterListings')
                  .doc(element.id)
                  .collection('barter')
                  .snapshots();
            }));
  }

  Stream<QueryDocumentSnapshot> getAllSubcollectionData() {
    final controller = StreamController<QueryDocumentSnapshot>();

    FirebaseFirestore.instance
        .collection('sample_BarterListings')
        .snapshots()
        .listen((parentCollectionSnapshot) async {
      for (var parentDoc in parentCollectionSnapshot.docs) {
        final subcollectionSnapshot = await parentDoc.reference.collection('barter').get();
        for (var document in subcollectionSnapshot.docs) {
          controller.add(document);
        }
      }
    });

    return controller.stream;
  }

/*
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
*/
  Stream<QuerySnapshot> getPromotedListings() {
    return _firestore
        .collection("sample_BarterListings")
        .doc()
        .collection('barter')
        .where('promoted', isEqualTo: true)
        .orderBy('listingStartTime', descending: false)
        .snapshots();
  }

  /*
  StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('parent_collection')
      .where(FieldPath.documentId(), isGreaterThan: '')
      .snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Text("Loading");
    }

    List<Widget> subCollectionWidgets = [];

    snapshot.data.docs.forEach((doc) {
      subCollectionWidgets.add(
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('parent_collection')
              .doc(doc.id)
              .collection('subcollection')
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> subCollectionSnapshot) {
            if (subCollectionSnapshot.hasError) {
              return Text('Something went wrong');
            }

            if (subCollectionSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Text("Loading");
            }

            List<Widget> subCollectionSnapshots = [];

            subCollectionSnapshot.data.docs.forEach((subDoc) {
              subCollectionSnapshots.add(
                // Do something with the subcollection snapshot
              );
            });

            return Column(
              children: subCollectionSnapshots,
            );
          },
        ),
      );
    });

    return Column(
      children: subCollectionWidgets,
    );
  },
);


  
   */*/
}
