import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateFarmerRating {
  Future<void> updateFarmerRating(String farmerId, averagRating) async {
    print("Nigana diring dapita sa updating sa farmer rating");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: farmerId)
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
