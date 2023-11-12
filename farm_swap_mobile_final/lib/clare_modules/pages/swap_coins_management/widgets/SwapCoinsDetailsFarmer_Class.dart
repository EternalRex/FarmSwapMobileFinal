import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common/get_specific_user_docid.dart';

class SwapCoinsDetailsFarmer {
  final GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();

  Future<DocumentSnapshot> getFarmerDocument() async {
    /*Get the document ID for the current user */
    String documentId =
        await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);

    /*Access the document from Firestore */
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");
    return await reference.doc(documentId).get();
  }

  Future<String> getFarmerFirstname() async {
    DocumentSnapshot snapshot = await getFarmerDocument();
    return snapshot["firstname"];
  }

  Future<String> getFarmerLastname() async {
    DocumentSnapshot snapshot = await getFarmerDocument();
    return snapshot["lastname"];
  }

  Future<Map<String, String>> getFarmerAddress() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId =
        await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return {
      "city_baranggay": snapshot["city_baranggay"],
      "city_municipality": snapshot["city_municipality"],
    };
  }

  Future<String> getFarmerProfile() async {
    DocumentSnapshot snapshot = await getFarmerDocument();
    return snapshot["profilePhoto"];
  }
}
