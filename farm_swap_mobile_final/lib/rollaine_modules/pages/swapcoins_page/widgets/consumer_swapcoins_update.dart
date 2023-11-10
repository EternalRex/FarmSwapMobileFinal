import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateConsumerSwapCoins {

  final FirebaseAuth auth = FirebaseAuth.instance;

  GetSpecificUserDocumentId retrieve = GetSpecificUserDocumentId();

  //this will update the balance as well as the swap coins in the firetsore
  Future<void> updateConsumerSwapCoins(double topupSwapCoins) async {
    try {
      //Get the current user's ID
      final userId = auth.currentUser!.uid;

      //Get the document ID for the consumer
      String myDocId = await retrieve.getConsumerDocumentId(userId);

      if (myDocId.isNotEmpty) {
        //Reference to the consumer's document in firestore
        final DocumentReference<Map<String, dynamic>> documentRef = FirebaseFirestore.instance.collection('sample_ConsumerUsers').doc(myDocId);

        //Retrieve the current balance from firestore
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();

        final dynamic data = documentSnapshot.data();

        if (documentSnapshot.exists) {
          //Get the current balance from the document
          final balance = (data['balance'] as num?)?.toDouble() ?? 0.0;

          //Get the current swapcoins from the document
          final swapcoins = (data['swapcoins'] as num?)?.toDouble() ?? 0.0;

          //Calculate the new balance, balance minus the topup amount
          double newBalance = (balance - topupSwapCoins).toDouble();

          //Calculate the new swapcoins, current swapcoins plus the new top up amount
          double newSwapCoins = (swapcoins + topupSwapCoins).toDouble();

          //Update the balance and swapcoins field in the firestore document with the new balance
          await documentRef.update({'balance': newBalance, 'swapcoins': newSwapCoins});

          print('Balance has been updated for user ID: $userId');
        }
        else {
          print('Document not found for user ID: $userId');
        }
      }
      else {
        print('Document ID retrieval failed or is empty for user ID: $userId');
      }
    }
    catch (e) {
      print('Error updating balance: $e');
    }
  }
}