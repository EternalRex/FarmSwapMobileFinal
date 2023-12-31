import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*Kani na class is ako gi common kay pwde ni nato magamit anytime kwaon nato ang
specifc data sa consumer pinaagi sa querry lang og dli atong pina futurebuilder
*/

class ListinGetConsumerDetails {
  /*Gamiton taning class na naa sa atong commons folder para mag pull out sa document id
  sa current user */
  GetSpecificUserDocumentId docId = GetSpecificUserDocumentId();
  Future<String> getConsumerUserId() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userId"];
  }

  Future<String> getConsumerFirstname() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["firstname"];
  }

  Future<String> getConsumerLastName() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["lastname"];
  }

  Future<String> getConsumerContactNum() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["contactnum"];
  }

  Future<String> getConsumerUserRole() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userRole"];
  }

  Future<String> getConsumerProfilePhoto() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["profilePhoto"];
  }

  Future<String> getConsumerProfilePhotoWithParameter(String id) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(id);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["profilePhoto"];
  }

/*Municipality na value */
  Future<String> getMunicipalityFirstname() async {
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    return snapshot["city_municipality"];
  }

/*Barangay na Value */
  Future<String> getBaranggay() async {
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    return snapshot["baranggay"];
  }

  Future<String> getUname() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    /*E return nato ang value sa doument */
    return snapshot["userName"];
  }

  Future<double> getSwapCoins() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double coins = (snapshot["swapcoins"] as num).toDouble();
    return coins;
  }

/*Kuha gihapon ni siyag swap coins ang naka lahi lang is mag need ni siyag user id from the class diin ni gi call na method unlike sa babaw
na largo ratag provide sa firebase Auth */

  Future<double> getSwapCoinsWithProvidedId(String consId) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(consId);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double coins = (snapshot["swapcoins"] as num).toDouble();
    return coins;
  }

/*Method to pull out the wallet balance */
  Future<double> getWalletBalance() async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double walletBalance = (snapshot["balance"] as num).toDouble();
    return walletBalance;
  }

/*Method to pull out the wallet balance with parameter*/
  Future<double> getWalletBalanceWithParameter(String id) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(id);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double walletBalance = (snapshot["balance"] as num).toDouble();
    return walletBalance;
  }

/*Method to pull out the wallet balance with parameter*/
  Future<double> getConsumerRating(String id) async {
    /*Mao ni buhaton para ma access nato ang properties sa document */
    String documentId = await docId.getConsumerDocumentId(id);
    CollectionReference reference = FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    DocumentSnapshot snapshot = await reference.doc(documentId).get();

    double rating = (snapshot["rating"] as num).toDouble();
    return rating;
  }
  //So pun e lang ni og method diri kung aduna pamoy ganahan na value na e pullout sa propert ni farmer
}
