import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/database/get_loginuser_docid.dart';

/*The purpose of this class is e update niya ang value sa online status sa user, to online if mo online
and or offline if mo offline */

class UpdateOnlineStatus {
  GetLoginUserDocumentId docId = GetLoginUserDocumentId();

  Future<void> updateOnlineStatus(String userid, bool active, String userType) async {
    /*So kani na function mo dawat og usertype na field. so depende sa value sa usertype
    kong FARMER gani, katong querry sa database sa farmer ang e execute, og kung customer
    so kaning sa consumer na function */

    try {
      if (userType == "FARMER") {
        String docid = await docId.getFarmerDocumentId(userid);
        final document = FirebaseFirestore.instance.collection('sample_FarmerUsers').doc(docid);
        final statusUpdate = {'isOnline': active};
        document.update(statusUpdate);
      } else {
        String docid = await docId.getConsumerDocumentId(userid);
        final document = FirebaseFirestore.instance.collection('sample_ConsumerUsers').doc(docid);
        final statusUpdate = {'isOnline': active};
        document.update(statusUpdate);
      }
    } catch (e) {
      throw Exception("Way Document Nakit an $e");
    }
  }
}
