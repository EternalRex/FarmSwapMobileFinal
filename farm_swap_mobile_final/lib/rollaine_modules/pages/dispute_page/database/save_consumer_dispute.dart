import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/consumer/barter_dispute_model.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/consumer/sale_dispute_model.dart';

class SaveCBarterDispute {
  Future<void> addCBarterDispute(
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
    final cBarterDispute = BarterDisputeModel(
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
    String finalId = '$disputeId$consumerId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_ConsumerBarterDispute')
        .doc(finalId)
        .collection('cBarterDispute')
        .add(cBarterDispute.toMap());
  }

  /*Querry that will update the decline field to false */
  Future<void> updateConsumerDisputed(String listid, String itemUrl, farmerId, consumerId) async {
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
        await docRef.update({'isConsumerDisputed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}

/*For Consumers */
class SaveCSaleDispute {
  Future<void> addCSaleDispute(
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
    final cSaleDispute = SaleDisputeModel(
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
      isResolved: false,
    );

    String disputeId = 'DISPUTE';
    String finalId = '$disputeId$cid';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_ConsumerSaleDispute')
        .doc(finalId)
        .collection('cSaleDispute')
        .add(cSaleDispute.toMap());
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
        await docRef.update({'isConsumerDisputed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}
