import 'package:cloud_firestore/cloud_firestore.dart';

class CheckUsernameAvailability {
  Future<bool> userNameCheck(String username) async {
    bool isUsed = false;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sample_FarmerUsers')
          .where('userName', isEqualTo: username)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        isUsed = true;
      } else {
        isUsed = false;
      }
    } catch (e) {
      throw const FormatException("Sayop ang process sa username check");
    }
    return isUsed;
  }
}
