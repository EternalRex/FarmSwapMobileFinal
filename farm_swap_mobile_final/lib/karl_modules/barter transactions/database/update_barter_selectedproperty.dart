/*This class updates the selected property of the bid into true*/

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateSelectedBarterBid {
  Future<void> updateBidSelectedStatus(bool accepted, String listid, String consumerId) async {
    /*Diri na querry kay atong e update ang document where ni match ning atong gi pasa na value nga
    customer id og listing id sa property values ato na document, kay no two bids can have the same
    customerid and listing id man diba? kay a customer can only bid to a particular listing, once or kaisa ra*/
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('barterbids')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'selected': accepted});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*Kani is once ma selected na ang isa ka bid, tanan nga barteredout propety sa tanang bids is ma 
update to true, meaning nanay bid nga napili-an si farmer.  ang nakalahi lang sa bid na napili an ni
farmer is ang iyang selected property is equal to true pd, while sa uban kay false*/
  Future<void> updateIsBarteredOutProperty() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collectionGroup('barterbids').get();
      var batch = FirebaseFirestore.instance.batch();

      querySnapshot.docs.forEach((element) {
        var reference = element.reference;
        batch.update(reference, {'isBarteredOut': true});
      });

      await batch.commit();
    } catch (e) {
      print("Wala na updated ang bartered out choy $e");
    }
  }

/*Mao ni function na mo confirm na ang transaction kay completed na jud */
  Future<void> updateIsBarteredCompletedProperty(String listingid, String customerid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('barterbids')
        .where('listingId', isEqualTo: listingid)
        .where('consumerId', isEqualTo: customerid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'completed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Mao ni function na mo confirm na ang transaction kay completed na jud sa consumer side ni */
  Future<void> updateConsumerIsCompeleted(String listingid, String customerid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('barterbids')
        .where('listingId', isEqualTo: listingid)
        .where('consumerId', isEqualTo: customerid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'consumerCompleted': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}
