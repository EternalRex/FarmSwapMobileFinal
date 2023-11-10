import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/database/consumer_wallet_query.dart';

RetrieveConsumerId retrieve = RetrieveConsumerId();

class ConsumerCheckBalance {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /*this function kay para kuhaon ang balance sa firestore then gi convert into double */
  Future<double> getConsumerBalance() async {
    try {
      String documentId = await RetrieveConsumerId().getDocsIdConsumer();
      DocumentSnapshot documentSnapshot = await firestore.collection('sample_ConsumerUsers').doc(documentId).get();

      final dynamic data = documentSnapshot.data();

      if (documentSnapshot.exists) {
        final balance = (data['balance'] as num?)?.toDouble() ?? 0.0;
        return balance;
      }
      else {
        print('Firestore error: $documentId');
        return 0.0;
      }
    }
    catch (e) {
      print('Firestore error: $e');
      return 0.0;
    }
  }
}