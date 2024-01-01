import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInFarmerEmail {
  Future<bool> checkInFarmerEmail(myEmail) async {
    QuerySnapshot querry = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('email', isEqualTo: myEmail)
        .get();

    try {
      if (querry.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ('Wala ma pull out ang document na imong gipangita bogo-a ka');
    }
  }
}
