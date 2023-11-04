import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellListingUpdate {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /*Method for updating String fields */
  Future<void> updateListingStringValues(
      String fname, String newValue, String newData, String profileUrl) async {
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "SELL";
    String farmerUsername = fname;
    String docId = '$farmerUsername$category$userid';

    switch (newValue) {
      /*Executes if the selected option is listing name*/
      case "LISTINGNAME":
        QuerySnapshot querySnapshot = await _firestore
            .collection("sample_SellListings")
            .doc(docId)
            .collection('sell')
            .where('listingpictureUrl', isEqualTo: profileUrl)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          try {
            await docRef.update({'listingName': newData});
          } catch (e) {
            throw ('Wa makit e ang docs', e);
          }
        }
        break;

      /*Executes if the selected option is listingdiscription */
      case "LISTINGDISC":
        QuerySnapshot querySnapshot = await _firestore
            .collection("sample_SellListings")
            .doc(docId)
            .collection('sell')
            .where('listingpictureUrl', isEqualTo: profileUrl)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          try {
            await docRef.update({'listingdiscription': newData});
          } catch (e) {
            throw ('Wa makit e ang docs', e);
          }
        }
        break;

/*Executes if the selected option is listing price */
      case "LISTINGPRICE":
        QuerySnapshot querySnapshot = await _firestore
            .collection("sample_SellListings")
            .doc(docId)
            .collection('sell')
            .where('listingpictureUrl', isEqualTo: profileUrl)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          try {
            await docRef.update({'listingprice': double.parse(newData)});
          } catch (e) {
            throw ('Wa makit e ang docs', e);
          }
        }
        break;

      /*Executes if the selected option is listing quantity is selected */
      case "LISTINGQUANTITY":
        QuerySnapshot querySnapshot = await _firestore
            .collection("sample_SellListings")
            .doc(docId)
            .collection('sell')
            .where('listingpictureUrl', isEqualTo: profileUrl)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          try {
            await docRef.update({'listingQuantity': double.parse(newData)});
          } catch (e) {
            throw ('Wa makit e ang docs', e);
          }
        }
        break;

      default:
        throw const FormatException('Failed Update');
    }
  }
}
