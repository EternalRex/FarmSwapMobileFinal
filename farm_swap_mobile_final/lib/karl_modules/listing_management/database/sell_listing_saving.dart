/*Kani na class is mag create ni siyag collection sa firebase named Sell Listing Collection
nga naay subcollection nga sell, nya ang document id sa atong e save is, sell + farmername plus
farmeruid */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/models/sell_listing_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/farmer_individual_details.dart';

class SellListingSaving {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

/*Instance of the class that directly pulls out the individual data the current farmer user */
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();

  /*Function para mag save og data sa database*/
  Future<void> saveSellingListing(
    String prodName,
    String prodDisc,
    String prodQuan,
    double prodPrice,
    String prodCateg,
    String prodPicUrl,
    String fnameFarmer,
    String lnameFarmer,
    String munisipyoFarmer,
    String barangayFarmer,
    String farmerUname,
    DateTime start,
    DateTime end,
  ) async {
    String userid = _firebaseAuth.currentUser!.uid;

    /*Assigning our gathered value to our model and putting all of them into one
    variable para ma usa natog pansak sa database */
    final saveDate = SellListingModels(
      listingName: prodName,
      listingDiscription: prodDisc,
      listingQuantityKg: prodQuan,
      listingPircePerKilo: prodPrice,
      listingCategory: prodCateg,
      listingPictureUrl: prodPicUrl,
      listingStartTime: start,
      listingEndTime: end,
      farmerFName: fnameFarmer,
      farmerLname: lnameFarmer,
      farmerMuncipality: munisipyoFarmer,
      farmerBaranggay: barangayFarmer,
      farmerUserName: farmerUname,
    );

    /*Construkon nato ang id sa atong listing*/
    List<String> semiId = [farmerUname, prodCateg, userid];
    semiId.sort();
    String finalId = semiId.join("_");

    await _firestore
        .collection("sample_SellListings")
        .doc(finalId)
        .collection('sell')
        .add(saveDate.toMap());
  }

  /*This is the function that will pull out the data based on the farmerusername, prodcategory, farmer userid */
  Stream<QuerySnapshot> getSellingListing(String farmerUName) {
    String userid = _firebaseAuth.currentUser!.uid;
    String category = "SELL";

    /*Construct the id to be pulled out*/
    List<String> semiId = [farmerUName, category, userid];
    semiId.sort();
    String finalId = semiId.join("_");

    return _firestore
        .collection("sample_SellListings")
        .doc(finalId)
        .collection('sell')
        .orderBy('listingStartTime', descending: false)
        .snapshots();
  }
}
