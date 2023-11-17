import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';

class ConsumerProfilePhotQuerry {
  GetSpecificUserDocumentId documentId = GetSpecificUserDocumentId();

  Future<String> getConsumerProfilePhoto(String docid) async {
    String finaldocid = await documentId.getConsumerDocumentId(docid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(finaldocid).get();

    /*E return nato ang value sa doument */
    return snapshot["profilePhoto"];
  }
}
