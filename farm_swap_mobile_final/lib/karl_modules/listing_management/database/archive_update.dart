import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArchiveUpdateListing {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> archiveBarterListing(String farmerUname, String pcitureUrl) async {
    print("updating1");
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "BARTER";
    String farmerUsername = farmerUname;
    String docId = '$farmerUsername$category$userid';
    String newStatus = "ARCHIVE";

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_BarterListings")
        .doc(docId)
        .collection("barter")
        .where('listingpictureUrl', isEqualTo: pcitureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docref = querySnapshot.docs.first.reference;
      try {
        await docref.update({'listingstatus': newStatus});
      } catch (e) {
        throw ('Way docs makit an', e);
      }
    } else {
      print("no docs found");
    }
  }

  Future<void> archiveSellingListing(String farmerUname, String pcitureUrl) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "SELL";
    String farmerUsername = farmerUname;
    String docId = '$farmerUsername$category$userid';
    String newStatus = "ARCHIVE";

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_SellListings")
        .doc(docId)
        .collection("sell")
        .where('listingpictureUrl', isEqualTo: pcitureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docref = querySnapshot.docs.first.reference;
      try {
        await docref.update({'listingstatus': newStatus});
      } catch (e) {
        throw ('Way docs makit an', e);
      }
    }
  }
}
