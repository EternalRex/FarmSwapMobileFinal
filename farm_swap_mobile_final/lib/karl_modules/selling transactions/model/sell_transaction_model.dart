class SellTransactionModel {
  SellTransactionModel({
    required this.consProfileUrl,
    required this.consName,
    required this.consLName,
    required this.consUname,
    required this.consId,
    required this.consBarangay,
    required this.consMunicipality,
    required this.farmerProfileUrl,
    required this.farmerName,
    required this.farmerLName,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.listingName,
    required this.listingId,
    required this.listingPrice,
    required this.listingQuantity,
    required this.listingUrl,
    required this.purchaseQuantity,
    required this.purchaseTotalPrice,
    required this.purchaseTime,
    required this.isConfirmed,
    required this.selected,
    required this.confirmedDate,
    required this.listingStatus,
    required this.addedFarmerWalletAmount,
    required this.decutedFarmerSwapCoins,
    required this.tranasctinDate,
  });

  //Consumer Details
  String consProfileUrl;
  String consName;
  String consLName;
  String consUname;
  String consId;
  String consBarangay;
  String consMunicipality;

  /*Farmer Details */
  String farmerProfileUrl;
  String farmerName;
  String farmerLName;
  String farmerUname;
  String farmerId;
  String farmerBarangay;
  String farmerMunicipality;

  /*listing details*/
  String listingName;
  String listingId;
  String listingPrice;
  String listingQuantity;
  String listingUrl;

  /*Purchase details*/
  double purchaseQuantity;
  double purchaseTotalPrice;
  DateTime purchaseTime;
  bool isConfirmed;
  DateTime confirmedDate;
  String listingStatus;
  bool selected;

/*Computations*/
  double addedFarmerWalletAmount;
  double decutedFarmerSwapCoins;
  DateTime tranasctinDate;

  Map<String, dynamic> toMap() {
    return {
      'consProfileUrl': consProfileUrl,
      'consName': consName,
      'consLName': consLName,
      'consUname': consUname,
      'consId': consId,
      'consBaranay': consBarangay,
      'consMunicipality': consMunicipality,
      'farmerProfileUrl': farmerProfileUrl,
      'farmerName': farmerName,
      'farmerLname': farmerLName,
      'farmerUname': farmerUname,
      'farmerId': farmerId,
      'farmerBarangay': farmerBarangay,
      'farmerMunicipality': farmerMunicipality,
      'listingName': listingName,
      'listingId': listingId,
      'listingPrice': listingPrice,
      'listingQuan': listingQuantity,
      'listingUrl': listingUrl,
      'purchaseQuan': purchaseQuantity,
      'purchasePrice': purchaseTotalPrice,
      'purchaseTime': purchaseTime,
      'isConfirmed': isConfirmed,
      'listingStatus': listingStatus,
      'selected': selected,
      'addedFarmerWalletAmnt': addedFarmerWalletAmount,
      'deductedFarmerSwapCoins': decutedFarmerSwapCoins,
      'transactionDate': tranasctinDate,
    };
  }
}
