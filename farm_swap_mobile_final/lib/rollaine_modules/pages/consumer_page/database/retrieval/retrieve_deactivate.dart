import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//para ni sa pagkuha sa doc ID sa deactivate account
class RetrieveDeactivate {
  String documentID = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  Future<String> getDocsId() async {
    // Query to retrieve the document ID
    await db
        .collection('sample_ConsumerUsers')
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
    await db.collection('sample_ConsumerUsers').doc(docId).update({
      'accountStatus': 'DEACTIVATED',
      // Add more fields to update as needed
    });
  }
}
