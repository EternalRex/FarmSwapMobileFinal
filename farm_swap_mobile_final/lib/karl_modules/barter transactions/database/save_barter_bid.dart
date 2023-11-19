import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/model/bartering_model.dart';

class SaveBarterBid {
  Future<void> saveBarterBid(
    String farmerUnameBid,
    String farmerIdBid,
    String farmerFnameBid,
    String farmerLnameBid,
    String farmerBarangayBid,
    String farmerMunisipyoBid,
    String consumerIdBid,
    String consumerFnameBid,
    String consumerLnameBid,
    String consumerUnameBid,
    String consumerBarangayBid,
    String consumerMunispyoBid,
    String listingIdBid,
    String listingNameBid,
    String listingDiscBid,
    double listingEquivPriceBid,
    double listingQuantityBid,
    String listingStatusBid,
    String itemNameBid,
    String itemDiscBid,
    String itemConditionBid,
    double itemQuantityBid,
    String itemPicUrlBid,
    double itemValueBid,
    bool isAlreadyBarteredBid,
  ) async {
    String category = "BARTER";
    String docid = '$farmerUnameBid$category$farmerIdBid';

    final proposedBid = BarteringModel(
      itemName: itemNameBid,
      itemDisc: itemDiscBid,
      itemCondition: itemConditionBid,
      itemQuantity: itemQuantityBid,
      itemPicUrl: itemPicUrlBid,
      bidTime: DateTime.now(),
      isAlreadyBartered: isAlreadyBarteredBid,
      selected: false,
      listingId: listingIdBid,
      listingName: listingNameBid,
      listingDisc: listingDiscBid,
      listingEquivalentPrice: listingEquivPriceBid,
      listingQuantity: listingQuantityBid,
      itemValue: itemValueBid,
      listingStatus: listingStatusBid,
      farmerId: farmerIdBid,
      farmerFName: farmerFnameBid,
      farmerLname: farmerLnameBid,
      farmerUname: farmerUnameBid,
      farmerBaranggay: farmerBarangayBid,
      farmerMunicaplity: farmerMunisipyoBid,
      consumerId: consumerIdBid,
      consumerFname: consumerFnameBid,
      consumerLname: consumerLnameBid,
      consumerUname: consumerUnameBid,
      consumerBarangay: consumerBarangayBid,
      consumerMunicipality: consumerMunispyoBid,
      completed: false,
      consCompleted: false,
    );

    var barterListingRef =
        FirebaseFirestore.instance.collection("sample_BarterListings").doc(docid);
    var bidsCollectionRef =
        barterListingRef.collection('barter').doc(listingIdBid).collection('barterbids');

    await bidsCollectionRef.add(proposedBid.toMap());
  }
}
