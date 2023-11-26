import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatingConsumerRating {
  Future<void> updateConsumerRating(String consumerId, averagRating) async {
    print("Nigana diring dapita sa updating sa farmer rating, $averagRating");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .where('userId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'rating': averagRating});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}
