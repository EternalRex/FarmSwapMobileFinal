import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/database/retrieval/retrieved_archive.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/*kani na function kay mo update siya sa profilePhoto didtu 
sa firebase igka human ug upload sa picture wheter from galler or camera
*/
class UpdateProfilePicture {
// Function to upload the image to Firebase and update Firestore
  Future<void> uploadImageToFirebaseGallery() async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      // User canceled image selection
      return;
    }

    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${DateTime.now()}.jpg");
    UploadTask uploadTask = storageReference.putFile(File(image.path));

    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();

      //kani na part kay mag create ug instance para sa firestore and collection
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference collection =
          firestore.collection('sample_ConsumerUsers');
      /*nag reuse ko sa function na RetrieveArchiveDocId where in 
      iretrieve niya ang docId sa specific na userId*/
      final RetrieveArchive retrieve = RetrieveArchive();
      final String documentId = await retrieve.getDocsId();
      //then kani na part iya i map ang data iya gi pass sa variable na data
      final Map<String, dynamic> data = {
        'profilePhoto': downloadURL,
      };
      //then this line mao na ni ang mo update sa firebase profilePhoto na field
      await collection.doc(documentId).update(data);
    });
  }

// Function to upload the camera to Firebase and update Firestore
  Future<void> uploadImageToFirebaseCamera() async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      // User canceled image selection
      return;
    }

    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${DateTime.now()}.jpg");
    UploadTask uploadTask = storageReference.putFile(File(image.path));

    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();

      //kani na part kay mag create ug instance para sa firestore and collection
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference collection =
          firestore.collection('sample_ConsumerUsers');
      /*nag reuse ko sa function na RetrieveArchiveDocId where in 
      iretrieve niya ang docId sa specific na userId*/
      final RetrieveArchive retrieve = RetrieveArchive();
      final String documentId = await retrieve.getDocsId();

      //then kani na part iya i map ang data iya gi pass sa variable na data
      final Map<String, dynamic> data = {
        'profilePhoto': downloadURL,
      };

      //then this line mao na ni ang mo update sa firebase profilePhoto na field
      await collection.doc(documentId).update(data);
    });
  }
}
