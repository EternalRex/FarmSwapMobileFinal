import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/farmer_wallet_query.dart';

RetrieveDocID retrieve = RetrieveDocID();

class CheckBalance {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*this function kay para kuhaon ang balance sa firestore then gi convert into double */
  Future<double> getBalanceFromFirestore() async {
    try {
      String documentId = await RetrieveDocID().getDocsIdUsers();
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('sample_FarmerUsers')
          .doc(documentId)
          .get();
      final dynamic data = documentSnapshot.data();

      if (documentSnapshot.exists) {
        final balance = (data['balance'] as num?)?.toDouble() ?? 0.0;
        return balance;
      } else {
        print('Firestore error: $documentId');
        return 0.0; // Default value if the document doesn't exist
      }
    } catch (e) {
      // Handle any Firestore errors here
      print('Firestore error: $e');
      return 0.0; // Default value in case of an error
    }
  }
}
