import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/model/barter_transaction_model.dart';

class BarterTransactionDatabase {
  Future<void> addBarterTransaction(
    /*Farmer Details */
    String farmerName,
    String farmerId,
    String farmerUname,
    String farmerBarangay,
    String farmerMunicipality,

    /*Consumer Details */
    String consumerName,
    String consumerId,
    String consumerUname,
    String consumerBarangay,
    String consumerMunicipality,

    /*Item details */
    String listingid,
    String listingName,
    double? listingValue,
    String itemName,
    double? itemValue,

    /*Transaction details*/
    double averageValueRange,
    double deductedFarmerCoins,
    double deductConsumerCoins,
    String percentageValue,
  ) async {
    final barterTransaction = BarterTransactionModel(
      farmerName: farmerName,
      farmerId: farmerId,
      farmerUname: farmerUname,
      farmerBarangay: farmerBarangay,
      farmerMunicipality: farmerMunicipality,
      consumerName: consumerName,
      consumerId: consumerId,
      consumerUname: consumerUname,
      consumerBarangay: consumerBarangay,
      consumerMunicipality: consumerMunicipality,
      listingid: listingid,
      listingName: listingName,
      listingValue: listingValue!,
      itemName: itemName,
      itemValue: itemValue!,
      averageValueRange: averageValueRange,
      deductedFarmerCoins: deductedFarmerCoins,
      deductConsumerCoins: deductConsumerCoins,
      percentage: percentageValue,
      acceptDate: DateTime.now(),
    );
    FirebaseFirestore.instance
        .collection('sample_BarterTransactions')
        .add(barterTransaction.toMap());
  }
}
