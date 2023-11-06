import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UnpromoteProduct {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> unpromoteBarterUpdate(String farmerUname, String pictureUrl) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String farmerUsername = farmerUname;
    String category = "BARTER";
    String finalDocId = '$farmerUsername$category$userid';

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_BarterListings")
        .doc(finalDocId)
        .collection('barter')
        .where('listingpictureUrl', isEqualTo: pictureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'promoted': false});
      } catch (e) {
        throw ('Wa makit e ang docs', e);
      }
    }
  }

  Future<void> unpromoteSellingUpdate(String farmerUname, String pictureUrl) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String farmerUsername = farmerUname;
    String category = "SELL";
    String finalDocId = '$farmerUsername$category$userid';

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_SellListings")
        .doc(finalDocId)
        .collection('sell')
        .where('listingpictureUrl', isEqualTo: pictureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'promoted': false});
      } catch (e) {
        throw ('Wa makit e ang docs', e);
      }
    }
  }
}
