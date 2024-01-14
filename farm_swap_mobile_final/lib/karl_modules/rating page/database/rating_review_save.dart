import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/model/rating_review_model.dart';

class RatingAndReview {
  final _firebase = FirebaseFirestore.instance;

  Future<void> updateRatingValue(
    String farmerUname,
    String farmerId,
    String farmerLname,
    String farmerName,
    String farmerBarangay,
    String farmerMunicipal,
    String consumerId,
    String consumerName,
    String consumerLname,
    String consumerUname,
    String consBarangay,
    String consMunicipal,
    String review,
    int rate,
    DateTime reviewDate,
    String photo,
  ) async {
    final rateReviewSave = RatingReviewModel(
      farmerId: farmerId,
      farmerName: farmerName,
      farmerLname: farmerLname,
      farmerUname: farmerUname,
      farmerBarangay: farmerBarangay,
      farmerMunicipal: farmerMunicipal,
      consumerId: consumerId,
      consumerName: consumerName,
      consumerLname: consumerLname,
      consumerUname: consumerUname,
      consBarangay: consBarangay,
      consMunicipal: consMunicipal,
      review: review,
      rate: rate,
      reviewDate: reviewDate,
      profilePhoto: photo,
    );

    /*Mao ni querry where mag create tag subcollection sa specific na document iniside sa isa ka collection */
    CollectionReference farmerUsers = _firebase.collection('sample_FarmerUsers');
    QuerySnapshot farmerSnapshot = await farmerUsers.where('userId', isEqualTo: farmerId).get();
    if (farmerSnapshot.docs.isNotEmpty) {
      DocumentReference currentDoc = farmerSnapshot.docs.first.reference;
      CollectionReference subCollection = currentDoc.collection("reviewrating");
      await subCollection.add(rateReviewSave.toMap());
    } else {
      throw const FormatException("Wa makit-e ang document gwap");
    }
  }

  /*Function for saving the review in the consumer side */
  Future<void> updateRatingValueConsumer(
    String farmerUname,
    String farmerId,
    String farmerLname,
    String farmerName,
    String farmerBarangay,
    String farmerMunicipal,
    String consumerId,
    String consumerName,
    String consumerLname,
    String consumerUname,
    String consBarangay,
    String consMunicipal,
    String review,
    int rate,
    DateTime reviewDate,
    String photo,
  ) async {
    final rateReviewSave = RatingReviewModel(
      farmerId: farmerId,
      farmerName: farmerName,
      farmerLname: farmerLname,
      farmerUname: farmerUname,
      farmerBarangay: farmerBarangay,
      farmerMunicipal: farmerMunicipal,
      consumerId: consumerId,
      consumerName: consumerName,
      consumerLname: consumerLname,
      consumerUname: consumerUname,
      consBarangay: consBarangay,
      consMunicipal: consMunicipal,
      review: review,
      rate: rate,
      reviewDate: reviewDate,
      profilePhoto: photo,
    );

    /*Mao ni querry where mag create tag subcollection sa specific na document iniside sa isa ka collection */
    CollectionReference consumerUsers = _firebase.collection('sample_ConsumerUsers');
    QuerySnapshot consumerSnapshot =
        await consumerUsers.where('userId', isEqualTo: consumerId).get();
    if (consumerSnapshot.docs.isNotEmpty) {
      DocumentReference currentDoc = consumerSnapshot.docs.first.reference;
      CollectionReference subCollection = currentDoc.collection("consreviewrating");
      await subCollection.add(rateReviewSave.toMap());
    } else {
      throw const FormatException("Wa makit-e ang document gwap");
    }
  }
}
