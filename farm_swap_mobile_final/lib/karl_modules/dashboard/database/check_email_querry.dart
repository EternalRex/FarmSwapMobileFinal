/*Class  query nga mo check if ang gigamit na email sa current user is already in the users
account ba*/

import 'package:cloud_firestore/cloud_firestore.dart';

class CheckEmailInConsumerCollection {
  Future<bool> checkFarmerEmail(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .where('email', isEqualTo: email)
        .get();

    try {
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ("Sayop ang querry sa pag check sa email bobo ka gago");
    }
  }
}
