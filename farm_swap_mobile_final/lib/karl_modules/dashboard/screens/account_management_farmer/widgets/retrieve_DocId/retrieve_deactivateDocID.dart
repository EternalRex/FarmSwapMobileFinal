import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//para ni sa pagkuha sa doc ID sa deactivate account
class RetrieveDeactivateDocId {
  String documentID = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  Future<String> getDocsId() async {
    // Query to retrieve the document ID
    await db
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) => value.docs.forEach((element) {
              documentID = element.reference.id;
            }));
    return documentID;
  }

  //this function will update the field account status to deactivate
  Future<void> updateFieldDeactivate() async {
    // Call the getDocsId method to retrieve the document ID
    String docId = await getDocsId();

    //this will create a log of the user which is deactivate account
    //adminLogs.createAdminLogs(
    //  userEmail, userId, "Account_Deactivated", DateTime.now());

    // Update a field in the Firestore document using the retrieved document ID
    await db.collection('sample_FarmerUsers').doc(docId).update({
      'accountStatus': 'Deactivate',
      // Add more fields to update as needed
    });
  }
}
