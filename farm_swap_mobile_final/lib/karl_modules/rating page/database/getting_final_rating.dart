import 'package:cloud_firestore/cloud_firestore.dart';

class GettingFinalRating {
  Future<int> calculateAverageRating(String farmerId) async {
    // Reference to the Firestore collection 'sample_FarmerUsers'
    CollectionReference farmerUsersCollection =
        FirebaseFirestore.instance.collection('sample_FarmerUsers');

    // Query the 'sample_FarmerUsers' collection based on the 'userId' field
    QuerySnapshot userSnapshot =
        await farmerUsersCollection.where('userId', isEqualTo: farmerId).get();

    if (userSnapshot.docs.isNotEmpty) {
      // Get the reference to the document with the matching user ID
      DocumentSnapshot userDoc = userSnapshot.docs.first;

      // Get the reference to the 'ratingreview' subcollection of the matched document
      CollectionReference ratingReviewCollection = userDoc.reference.collection('reviewrating');

      // Get documents from the 'ratingreview' subcollection
      QuerySnapshot ratingSnapshot = await ratingReviewCollection.get();

      int totalRatings = 0;
      int numberOfRatings = 0;

      // Iterate through each document in the 'ratingreview' subcollection
      for (QueryDocumentSnapshot doc in ratingSnapshot.docs) {
        // Retrieve the document data as a Map<String, dynamic>
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        // Check if data is not null and contains the 'rating' field
        if (data != null && data.containsKey('rate')) {
          // Retrieve the 'rating' field value as a num
          num rating = data['rate'] as num;

          // Accumulate the total ratings and count the number of ratings
          totalRatings += rating.toInt();
          numberOfRatings++;
          print("Working diri tooo memememeem");
        }
      }

      // Calculate the average rating
      double averageRating = numberOfRatings > 0 ? totalRatings / numberOfRatings : 0;
      print("$averageRating mao ni average rating");
      // Return the average rating as an integer
      return averageRating.toInt();
    } else {
      // Handle if the user document with the given userId is not found
      return 0; // Or any default value indicating no ratings
    }
  }

  /*Method to calculate the average rating of the consumer*/
  Future<int> calculateConsumerAverageRating(String consumerId) async {
    // Reference to the Firestore collection 'sample_FarmerUsers'
    CollectionReference farmerUsersCollection =
        FirebaseFirestore.instance.collection('sample_ConsumerUsers');

    // Query the 'sample_FarmerUsers' collection based on the 'userId' field
    QuerySnapshot userSnapshot =
        await farmerUsersCollection.where('userId', isEqualTo: consumerId).get();

    if (userSnapshot.docs.isNotEmpty) {
      // Get the reference to the document with the matching user ID
      DocumentSnapshot userDoc = userSnapshot.docs.first;

      // Get the reference to the 'ratingreview' subcollection of the matched document
      CollectionReference ratingReviewCollection = userDoc.reference.collection('consreviewrating');

      // Get documents from the 'ratingreview' subcollection
      QuerySnapshot ratingSnapshot = await ratingReviewCollection.get();

      int totalRatings = 0;
      int numberOfRatings = 0;

      // Iterate through each document in the 'ratingreview' subcollection
      for (QueryDocumentSnapshot doc in ratingSnapshot.docs) {
        // Retrieve the document data as a Map<String, dynamic>
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        // Check if data is not null and contains the 'rating' field
        if (data != null && data.containsKey('rate')) {
          // Retrieve the 'rating' field value as a num
          num rating = data['rate'] as num;

          // Accumulate the total ratings and count the number of ratings
          totalRatings += rating.toInt();
          numberOfRatings++;
          print("Working diri tooo memememeem");
        }
      }

      // Calculate the average rating
      double averageRating = numberOfRatings > 0 ? totalRatings / numberOfRatings : 0;
      print("$averageRating mao ni average rating");
      // Return the average rating as an integer
      return averageRating.toInt();
    } else {
      // Handle if the user document with the given userId is not found
      return 0; // Or any default value indicating no ratings
    }
  }
}
