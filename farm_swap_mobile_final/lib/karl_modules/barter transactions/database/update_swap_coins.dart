import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateConsumerFarmerSwapCoins {
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

  /*Function para mo update kung pila nalay value sa swap coins ni consumer */
  Future<void> updateConsumerSwapCoins(String consumerId, double newSwapCoins) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .where('userId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docref = querySnapshot.docs.first.reference;
      try {
        await docref.update({'swapcoins': newSwapCoins});
      } catch (e) {
        throw ("Anga uyy wa man na update $e");
      }
    }
  }
}
