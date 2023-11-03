import 'package:cloud_firestore/cloud_firestore.dart';

/*So diri ato rang gi pull out ang document id kung diin ni si userid na belong, duha ni kabook kay kung
ang consuemer mo login, katong getConsumerDocumentId ang gamiton*/

class GetLoginUserDocumentId {
  String documentId = "";

  //functions for user FARMER
  Future<String> getFarmerDocumentId(String userid) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");
    QuerySnapshot query =
        await reference.where('userId', isEqualTo: userid).get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot snapshot = query.docs.first;
      documentId = snapshot.reference.id;
    }
    return documentId;
  }

  /*
  This function will check the account status if it exists it will 
  return the accountStatus which is naa nay value nya ipasa sa log in  na function
  */
  Future<String> checkAccountStatus(String documentId) async {
    // Query Firestore to check the account status
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(documentId)
        .get();

    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        String accountStatus = data['accountStatus'] ?? "";
        return accountStatus;
      }
    }

    // If the document doesn't exist or the field is missing, return an empty string
    return "";
  }

  /*this function is to update the field account status into requesting
  then this will also create farmer logs
  */
  Future<void> updateFieldReactivateRequest(
      String? updatedata, String userid) async {
    GetLoginUserDocumentId retrieve = GetLoginUserDocumentId();
    /*Calling the getFarmerDocumentId function from the class GetLoginUserDocumentId 
    reusing the class for retrieving doc id
    */
    await retrieve.getFarmerDocumentId(userid);

    final documentRef = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(retrieve.documentId);

    // Define the data to update which is the account status
    final updateData = {
      'accountStatus': updatedata,
    };

    // Create an admin log with a activity reactivation request farmer account
    //adminLogs.createAdminLogs(
    //  email, userID, "Accept_Reactivation_Request", DateTime.now());

    try {
      // Update the Firestore document with the new data
      await documentRef.update(updateData);
    } catch (e) {
      print("Error while updating document: $e");
    }
  }

  /*
  This function will check the account user role FARMER if it exists it will 
  return the userRole which is naa nay value nya ipasa sa log in  na function
  */
  Future<String> checkAccountRoleFarmer(String documentId) async {
    // Query Firestore to check the user role
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(documentId)
        .get();

    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        String userRoleFarmer = data['userRole'] ?? "";
        return userRoleFarmer;
      }
    }

    // If the document doesn't exist or the field is missing, return an empty string
    return "";
  }

  //functions for user CONSUMER
  Future<String> getConsumerDocumentId(
    String userid,
  ) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_ConsumerUsers");
    QuerySnapshot query =
        await reference.where('userId', isEqualTo: userid).get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot snapshot = query.docs.first;
      documentId = snapshot.reference.id;
    }
    return documentId;
  }

  /*
  This function will check the account status if it exists it will 
  return the accountStatus which is naa nay value nya ipasa sa log in  na function
  */
  Future<String> checkConsumerStatus(String documentId) async {
    // Query Firestore to check the account status
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .doc(documentId)
        .get();

    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        String accountStatus = data['accountStatus'] ?? "";
        return accountStatus;
      }
    }

    // If the document doesn't exist or the field is missing, return an empty string
    return "";
  }

  /*this function is to update the field account status into requesting
  then this will also create farmer logs
  */
  Future<void> updateReactivateRequest(
      String? updatedata, String userid) async {
    GetLoginUserDocumentId retrieve = GetLoginUserDocumentId();
    /*Calling the getFarmerDocumentId function from the class GetLoginUserDocumentId 
    reusing the class for retrieving doc id
    */
    await retrieve.getConsumerDocumentId(userid);

    final documentRef = FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .doc(retrieve.documentId);

    // Define the data to update which is the account status
    final updateData = {
      'accountStatus': updatedata,
    };

    // Create an admin log with a activity reactivation request farmer account
    //adminLogs.createAdminLogs(
    //  email, userID, "Accept_Reactivation_Request", DateTime.now());

    try {
      // Update the Firestore document with the new data
      await documentRef.update(updateData);
    } catch (e) {
      print("Error while updating document: $e");
    }
  }

  /*
  This function will check the account user role CONSUMER if it exists it will 
  return the userRole which is naa nay value nya ipasa sa log in  na function
  */
  Future<String> checkAccountRoleConsumer(String documentId) async {
    // Query Firestore to check the user role
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .doc(documentId)
        .get();

    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        String userRoleConsumer = data['userRole'] ?? "";
        return userRoleConsumer;
      }
    }

    // If the document doesn't exist or the field is missing, return an empty string
    return "";
  }
}
