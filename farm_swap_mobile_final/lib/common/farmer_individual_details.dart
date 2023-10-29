import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*Kani na class is ako gi common kay pwde ni nato magamit anytime kwaon nato ang
specifc data sa farmer pinaagi sa querry lang og dli atong pina futurebuilder
*/

class ListinGetFarmerDetails {
  /*Gamiton taning class na naa sa atong commons folder para mag pull out sa document id
  sa current user */
  GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();

  Future<String> getFarmerFirstname() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["firstname"];
  }

  Future<String> getLastName() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["lastname"];
  }

/*Municipality na value */
  Future<String> getMunicipalityFirstname() async {
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    return snapshot["city_municipality"];
  }

/*Barangay na Value */
  Future<String> getBaranggay() async {
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    return snapshot["city_baranggay"];
  }

  //So pun e lang ni og method diri kung aduna pamoy ganahan na value na e pullout sa propert ni farmer
}
