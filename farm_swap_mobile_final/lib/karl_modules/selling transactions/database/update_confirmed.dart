import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateConfirmedOrder {
/*Querry ni para e update ang confirmed field into true kung e hit ni farmer ang confirmed button */
  Future<void> updateOrderConfirmed(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'confirmed': true, 'selected': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*MO update sa field nga denied*/
  Future<void> updateOrderDenied(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'declined': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Mo update sa swapcoins field sa farmer*/
  /*Function para mo update kung pila nalay value sa swap coins ni farmer */
  Future<void> updateFarmerSwapCoins(String farmerId, double newSwapCoinBalance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: farmerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'swapcoins': newSwapCoinBalance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Function na mo update sa wallet ni farmer na naaddan siya*/
  Future<void> updateFarmerWalletBalance(String farmerId, double balance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: farmerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'balance': balance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*Function na mo update sa wallet ni consumer */
  /*Function na mo update sa wallet ni farmer na naaddan siya*/
  Future<void> updateConsumerWalletBalance(String consumerId, double balance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .where('userId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'balance': balance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}
