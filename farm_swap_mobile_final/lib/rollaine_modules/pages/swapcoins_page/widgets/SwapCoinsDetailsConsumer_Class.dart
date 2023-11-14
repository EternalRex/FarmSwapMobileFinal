import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../common/get_specific_user_docid.dart';

class SwapCoinsDetailsConsumer {
  final GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();

  Future<DocumentSnapshot> getConsumerDocument() async {
    /*Get the document ID for the current user */
    String documentId = await docId
        .getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);

    /*Access the document from Firestore */
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    return await reference.doc(documentId).get();
  }

  Future<String> getConsumeFirstname() async {
    DocumentSnapshot snapshot = await getConsumerDocument();
    return snapshot["firstname"];
  }

  Future<String> getConsumeLastname() async {
    DocumentSnapshot snapshot = await getConsumerDocument();
    return snapshot["lastname"];
  }

  Future<Map<String, String>> getConsumerAddress() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId =
        await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return {
      "baranggay": snapshot["baranggay"],
      "city_municipality": snapshot["city_municipality"],
    };
  }

  Future<String> getConsumerProfile() async {
    DocumentSnapshot snapshot = await getConsumerDocument();
    return snapshot["profilePhoto"];
  }
}
