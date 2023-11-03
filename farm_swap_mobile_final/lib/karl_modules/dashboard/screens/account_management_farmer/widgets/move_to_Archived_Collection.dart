import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoveCollection {
  //this function will move the collection to farmeruser if the account status if the field is archived
  Future<void> moveUserToArchivedCollection() async {
    // Get a reference to the Firestore collections
    CollectionReference adminUsersCollection =
        FirebaseFirestore.instance.collection('sample_FarmerUsers');
    CollectionReference archivedUsersCollection =
        FirebaseFirestore.instance.collection('sample_FarmerArchived');
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Query the sampleFarmerUsers collection for the user with the given userId
    QuerySnapshot query =
        await adminUsersCollection.where('userId', isEqualTo: userId).get();

    // Check if a document was found
    if (query.docs.isNotEmpty) {
      // Get the first document (assuming userId is unique)
      DocumentSnapshot userDoc = query.docs.first;

      // Check the "accountStatus" field
      String accountStatus = userDoc.get('accountStatus');

      if (accountStatus == 'Archived') {
        // Move the document to the FarmerArchived collection
        await archivedUsersCollection.doc(userDoc.id).set(userDoc.data());

        // Delete the document from the sample_FarmerUsers collection
        await adminUsersCollection.doc(userDoc.id).delete();
      }
    }
  }
}
