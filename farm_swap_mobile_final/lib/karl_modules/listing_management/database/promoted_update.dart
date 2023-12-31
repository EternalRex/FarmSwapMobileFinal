/*This class will update the promoted field and set it to true*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PromotedListings {
  /*Gamiton taning class na naa sa atong commons folder para mag pull out sa document id
  sa current user */
  GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> updateListingPromotedField(String farmerUname, String pictureUrl) async {
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
        await docRef.update({
          'promoted': true,
          'promotionDate': DateTime.now(),
        });
      } catch (e) {
        throw ('Wa makit e ang docs', e);
      }
    }
  }

  Future<void> updateSellingListingPromotedField(String farmerUname, String pictureUrl) async {
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
        await docRef.update({
          'promoted': true,
          'promotionDate': DateTime.now(),
        });
      } catch (e) {
        throw ('Wa makit e ang docs', e);
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
