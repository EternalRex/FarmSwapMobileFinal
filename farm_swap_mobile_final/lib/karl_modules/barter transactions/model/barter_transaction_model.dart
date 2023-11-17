class BarterTransactionModel {
  BarterTransactionModel({
    required this.farmerName,
    required this.farmerId,
    required this.farmerUname,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.consumerName,
    required this.consumerId,
    required this.consumerUname,
    required this.consumerBarangay,
    required this.consumerMunicipality,
    required this.listingid,
    required this.listingName,
    required this.listingValue,
    required this.itemName,
    required this.itemValue,
    required this.averageValueRange,
    required this.deductedFarmerCoins,
    required this.deductConsumerCoins,
    required this.percentage,
    required this.acceptDate,
  });

  /*Farmer Details */
  String farmerName;
  String farmerId;
  String farmerUname;
  String farmerBarangay;
  String farmerMunicipality;

  /*Consumer Details */
  String consumerName;
  String consumerId;
  String consumerUname;
  String consumerBarangay;
  String consumerMunicipality;

  /*Item details */
  String listingid;
  String listingName;
  double listingValue;
  String itemName;
  double itemValue;

  /*Transaction details*/
  double averageValueRange;
  double deductedFarmerCoins;
  double deductConsumerCoins;
  String percentage;
  DateTime acceptDate;

  Map<String, dynamic> toMap() {
    return {
      'farmerid': farmerId,
      'farmername': farmerName,
      'farmerUname': farmerUname,
      'farmerbarangay': farmerBarangay,
      'farmermunicipality': farmerMunicipality,
      'consumername': consumerName,
      'consumerid': consumerId,
      'consumerUname': consumerUname,
      'consumerbarangay': consumerBarangay,
      'consumermunisipyo': consumerMunicipality,
      'listingid': listingid,
      'listingname': listingName,
      'listingvalue': listingValue,
      'itemname': itemName,
      'itemvalue': itemValue,
      'averagevalue': averageValueRange,
      'deductedFarmerCoins': deductedFarmerCoins,
      'deductedConsumerCoins': deductConsumerCoins,
      'percentageFee': percentage,
      'transactionDate': acceptDate,
    };
  }
}
