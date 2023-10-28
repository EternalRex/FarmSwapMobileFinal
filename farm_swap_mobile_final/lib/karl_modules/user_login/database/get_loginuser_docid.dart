import 'package:cloud_firestore/cloud_firestore.dart';

/*So diri ato rang gi pull out ang document id kung diin ni si userid na belong, duha ni kabook kay kung
ang consuemer mo login, katong getConsumerDocumentId ang gamiton*/

class GetLoginUserDocumentId {
  String documentId = "";
  Future<String> getFarmerDocumentId(String userid) async {
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    QuerySnapshot query = await reference.where('userId', isEqualTo: userid).get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot snapshot = query.docs.first;
      documentId = snapshot.reference.id;
    }
    return documentId;
  }

  Future<String> getConsumerDocumentId(
    String userid,
  ) async {
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    QuerySnapshot query = await reference.where('userId', isEqualTo: userid).get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot snapshot = query.docs.first;
      documentId = snapshot.reference.id;
    }
    return documentId;
  }
}
