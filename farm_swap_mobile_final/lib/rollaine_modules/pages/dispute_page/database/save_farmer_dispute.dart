import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/farmer/sale_dispute_model.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/farmer/barter_dispute_model.dart';

class SaveFBarterDispute {
  /*Method that save the barter dispute to the database */
  Future<void> addFBarterDispute(
    /*Farmer Details */
    String farmerName,
    String farmerId,
    String farmerLastName,
    String farmerUname,
    String farmerBarangay,
    String farmerMunicipality,

    /*Consumer Details */
    String consumerName,
    String consumerId,
    String consumerUname,
    String consumserLastName,
    String consumerBarangay,
    String consumerMunicipality,

    /*Item details */
    String itemName,
    double itemValue,
    String itemUrl,
    String listingName,
    String listingId,
    String listingPrice,
    String listingUrl,
    bool isResolved,
    String farmerDisputeStatus,
    String farmerDisputeText,
    String farmerDisputeUrl,
    double deductedFSwapCoins,
    double deductedCSwapCoins,
    double average,
    String percentage,
    DateTime transactionTime,
  ) async {
    final fBarterDispute = BarterDisputeModel(
      farmerName: farmerName,
      farmerId: farmerId,
      farmerLastName: farmerLastName,
      farmerUname: farmerUname,
      farmerBarangay: farmerBarangay,
      farmerMunicipality: farmerMunicipality,
      consumerName: consumerName,
      consumerId: consumerId,
      consumerUname: consumerUname,
      consumserLastName: consumserLastName,
      consumerBarangay: consumerBarangay,
      consumerMunicipality: consumerMunicipality,
      itemName: itemName,
      itemValue: itemValue,
      itemUrl: itemUrl,
      farmerDisputeStatus: 'PENDING',
      isResolved: isResolved,
      disputeDateFile: DateTime.now(),
      farmerDisputeText: farmerDisputeText,
      farmerDisputeUrl: farmerDisputeUrl,
      listingId: listingId,
      listingName: listingName,
      listingPrice: listingPrice,
      listingUrl: listingUrl,
      deductedFarmerCoins: deductedFSwapCoins,
      deductedConsumerCoins: deductedCSwapCoins,
      averageValue: average,
      percentage: percentage,
      transactionDate: transactionTime,
    );

    String disputeId = 'DISPUTE';
    String finalId = '$disputeId$farmerId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_FarmerBarterDispute')
        .doc(finalId)
        .collection('fBarterDispute')
        .add(fBarterDispute.toMap());
  }

  /*Querry that will update the decline field to false */
  Future<void> updateDisputed(String listid, String itemUrl, farmerId, consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_BarterTransactions')
        .where('listingid', isEqualTo: listid)
        .where('itemUrl', isEqualTo: itemUrl)
        .where('farmerid', isEqualTo: farmerId)
        .where('consumerid', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'isDisputed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}

class SaveFSaleDispute {
  Future<void> addFSaleDispute(
    double addedAmnt,
    String cBarangay,
    String cLname,
    String cMunicipality,
    String cName,
    String cUrl,
    String cUname,
    String cid,
    double deductFarm,
    String fBarangay,
    String fLname,
    String fMunicipality,
    String fName,
    String fUrl,
    String fUname,
    String fId,
    String lName,
    String lId,
    double lPrice,
    double lQuan,
    String lStatus,
    String lUrl,
    double pPrice,
    double pQuan,
    bool isResolved,
    String consumerDisputeStatus,
    String consumerDisputeText,
    String consumerDisputeUrl,
    DateTime transactionDate,
  ) async {
    final fSaleDispute = SaleDisputeModel(
      /*Farmer Details */
      farmerUrl: fUrl,
      farmerName: fName,
      farmerLName: fLname,
      farmerUname: fUname,
      farmerId: fId,
      farmerMuniciplaity: fMunicipality,
      farmerBarangay: fBarangay,
      /*Consumer Details */
      consumerUrl: cUrl,
      consumerName: cName,
      consumerLName: cLname,
      consumerUname: cUname,
      consumerId: cid,
      consumerMuniciplaity: cMunicipality,
      consumerBarangay: cBarangay,
      /*Listing Details */
      listingUrl: lUrl,
      listingId: lId,
      listingName: lName,
      listingQuan: lQuan,
      listingPrice: lPrice,
      /*Purchase Details */
      purchasePrice: pPrice,
      purchaseQuantity: pQuan,
      purchaseSwapCoinsPay: deductFarm,
      /*Transaction Details */
      isDisputed: false,
      transactionDate: transactionDate,
      disputeStatus: consumerDisputeStatus,
      disputeText: consumerDisputeText,
      disputeUrl: consumerDisputeUrl,
      disputeDate: DateTime.now(),
    );

    String disputeId = 'DISPUTESALE';
    String finalId = '$disputeId$fId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_FarmerSaleDispute')
        .doc(finalId)
        .collection('fSaleDispute')
        .add(fSaleDispute.toMap());
  }

/*Querry that will update the isdisputed field to true field to false */
  Future<void> updateDisputedSelling(String listid, farmerId, consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_SellingTransactions')
        .where('listingId', isEqualTo: listid)
        .where('farmerId', isEqualTo: farmerId)
        .where('consId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'isDisputed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}
