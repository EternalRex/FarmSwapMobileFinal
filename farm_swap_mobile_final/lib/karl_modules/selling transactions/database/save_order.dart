import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/model/buyandsell_model.dart';

class SaveCustomerBuyOrder {
  Future<void> saveBuyOrder(
/*Consumer Details */
    String consName,
    String consLName,
    String consUname,
    String consId,
    String consBarangay,
    String consMunicipality,

    /*Farmer Details */
    String farmerName,
    String farmerLName,
    String farmerUname,
    String farmerId,
    String farmerBarangay,
    String farmerMunicipality,

    /*listing details*/
    String listingName,
    String listingId,
    String listingPrice,
    String listingQuantity,

    /*Purchase details*/
    double purchaseQuantity,
    double purchaseTotalPrice,
    DateTime purchaseTime,
    bool isCompletedPurchase,
    String listingstatus,
    String imageurl,
  ) async {
    String category = "SELL";
    String docId = '$farmerUname$category$farmerId';

    final saveOrder = BuyAndSell(
      consName: consName,
      consLName: consLName,
      consUname: consUname,
      consId: consId,
      consBarangay: consBarangay,
      consMunicipality: consMunicipality,
      farmerName: farmerName,
      farmerLName: farmerLName,
      farmerUname: farmerUname,
      farmerId: farmerId,
      farmerBarangay: farmerBarangay,
      farmerMunicipality: farmerMunicipality,
      listingName: listingName,
      listingId: listingId,
      listingPrice: listingPrice,
      listingQuantity: listingQuantity,
      purchaseQuantity: purchaseQuantity,
      purchaseTotalPrice: purchaseTotalPrice,
      purchaseTime: purchaseTime,
      isCompletedPurchase: isCompletedPurchase,
      isConfirmed: false,
      completeDate: DateTime.now(),
      confirmedDate: DateTime.now(),
      listingStatus: listingstatus,
      selected: false,
      declined: false,
      imageUrl: imageurl,
      consumerCompleted: false,
      consumerCompletedDate: DateTime.now(),
    );

    var sellListingRef = FirebaseFirestore.instance.collection("sample_SellListings").doc(docId);
    var buyCollectionRef = sellListingRef.collection('sell').doc(listingId).collection('sellbuy');
    await buyCollectionRef.add(saveOrder.toMap());
  }
}
