import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RenewUpdateListing {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /*Gamiton taning class na naa sa atong commons folder para mag pull out sa document id
  sa current user */
  GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();

  Future<void> renewBarterListing(String farmerUname, String pcitureUrl, Timestamp endTime) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "BARTER";
    String farmerUsername = farmerUname;
    String docId = '$farmerUsername$category$userid';
    String newStatus = "REACTIVATED";

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_BarterListings")
        .doc(docId)
        .collection("barter")
        .where('listingpictureUrl', isEqualTo: pcitureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docref = querySnapshot.docs.first.reference;
      try {
        await docref.update(
            {'listingstatus': newStatus, 'renewaldate': DateTime.now(), 'listingEndTime': endTime});
      } catch (e) {
        throw ('Way docs makit an', e);
      }
    }
  }

  Future<void> renewSellingListing(String farmerUname, String pcitureUrl, Timestamp endTime) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "SELL";
    String farmerUsername = farmerUname;
    String docId = '$farmerUsername$category$userid';
    String newStatus = "REACTIVATED";

    QuerySnapshot querySnapshot = await _firestore
        .collection("sample_SellListings")
        .doc(docId)
        .collection("sell")
        .where('listingpictureUrl', isEqualTo: pcitureUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docref = querySnapshot.docs.first.reference;
      try {
        await docref.update(
            {'listingstatus': newStatus, 'renewaldate': DateTime.now(), 'listingEndTime': endTime});
      } catch (e) {
        throw ('Way docs makit an', e);
      }
    }
  }

  /*Function that updates the swap coins field of the farmer*/
  Future<void> updateFarmerSwapCoins(int newswapCoins) async {
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['swapcoins'] = newswapCoins;
      await reference.doc(documentId).update(data);
    }
  }
}
