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

  Future<String> getFarmerUserId() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userId"];
  }

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

  Future<String> getFarmerContactNum() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["contactnum"];
  }

  Future<String> getFarmerUserRole() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userRole"];
  }

  Future<String> getFarmerUserProfilePhoto() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["profilePhoto"];
  }

/*Getting farmer photo with a parameter accepted */
  Future<String> getFarmerUserProfilePhotoWithParameter(String id) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(id);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["profilePhoto"];
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

  Future<String> getUname() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userName"];
  }

  Future<double> getSwapCoins() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double coins = (snapshot["swapcoins"] as num).toDouble();
    return coins;
  }

/*Get farmer wallet balance*/
  Future<double> getWalletBalance() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double coins = (snapshot["balance"] as num).toDouble();
    return coins;
  }

/*Get farmer rating balance with parameter*/
  Future<double> getFarmerRating(String farmerid) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getFarmerDocumentId(farmerid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_FarmerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double rating = (snapshot["rating"] as num).toDouble();
    return rating;
  }

  //So pun e lang ni og method diri kung aduna pamoy ganahan na value na e pullout sa propert ni farmer
}
