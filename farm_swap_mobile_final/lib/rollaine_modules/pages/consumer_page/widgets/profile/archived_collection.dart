import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArchivedCollection {
  //this function will move the collection to farmeruser if the account status if the field is archived
  Future<void> moveConsumerToArchivedCollection() async {
    // Get a reference to the Firestore collections
    CollectionReference adminUsersCollection =
        FirebaseFirestore.instance.collection('sample_ConsumerUsers');
    CollectionReference archivedUsersCollection =
        FirebaseFirestore.instance.collection('sample_ConsumerArchived');
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

      if (accountStatus == 'ARCHIVED') {
        // Move the document to the ConsumerArchived collection
        await archivedUsersCollection.doc(userDoc.id).set(userDoc.data());

        // Delete the document from the sample_FarmerUsers collection
        await adminUsersCollection.doc(userDoc.id).delete();
      }
    }
  }
}
