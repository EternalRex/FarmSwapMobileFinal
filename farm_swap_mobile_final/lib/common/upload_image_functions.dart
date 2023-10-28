import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageFunctions {
  /*Saving pricutre from gallery */
  Future<String?> uploadImageToFirebaseGallery() async {
    // Pick an image from the device using image_picker
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      // User canceled image selection
      return null;
    }

    // Get a reference to the Firebase Storage bucket
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${DateTime.now()}.jpg");

    // Upload the image to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(File(image.path));

    await uploadTask.whenComplete(() => null);

    // Get the download URL for the uploaded image
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }

/*Saving picture from camera */
  Future<String?> uploadImageToFirebaseCamera() async {
    // Pick an image from the device using image_picker
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      // User canceled image selection
      return null;
    }

    // Get a reference to the Firebase Storage bucket
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${DateTime.now()}.jpg");

    // Upload the image to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(File(image.path));

    await uploadTask.whenComplete(() => null);

    // Get the download URL for the uploaded image
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }
}
