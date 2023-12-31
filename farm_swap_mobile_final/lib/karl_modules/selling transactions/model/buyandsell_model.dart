class BuyAndSell {
  BuyAndSell({
    required this.consName,
    required this.consLName,
    required this.consUname,
    required this.consId,
    required this.consBarangay,
    required this.consMunicipality,
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
    required this.purchaseQuantity,
    required this.purchaseTotalPrice,
    required this.purchaseTime,
    required this.isCompletedPurchase,
    required this.isConfirmed,
    required this.confirmedDate,
    required this.completeDate,
    required this.listingStatus,
    required this.selected,
    required this.declined,
    required this.imageUrl,
    required this.consumerCompleted,
    required this.consumerCompletedDate,
  });

  /*Consumer Details */
  String consName;
  String consLName;
  String consUname;
  String consId;
  String consBarangay;
  String consMunicipality;

  /*Farmer Details */
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

  /*Purchase details*/
  double purchaseQuantity;
  double purchaseTotalPrice;
  DateTime purchaseTime;
  bool isCompletedPurchase;
  bool isConfirmed;
  DateTime confirmedDate;
  DateTime completeDate;
  String listingStatus;
  bool selected;
  bool declined;
  String imageUrl;
  bool consumerCompleted;
  DateTime consumerCompletedDate;

  Map<String, dynamic> toMap() {
    return {
      'consumerName': consName,
      'consumerLname': consLName,
      'consumerUname': consUname,
      'consumerId': consId,
      'consumerBarangay': consBarangay,
      'consumerMunicipal': consMunicipality,
      'farmerName': farmerName,
      'farmerLname': farmerLName,
      'farmerUname': farmerUname,
      'farmerId': farmerId,
      'farmerBarangay': farmerBarangay,
      'farmerMunicipal': farmerMunicipality,
      'listingId': listingId,
      'listingName': listingName,
      'listingPrice': listingPrice,
      'listingQuan': listingQuantity,
      'purchaseQuan': purchaseQuantity,
      'purchaseTotalPrice': purchaseTotalPrice,
      'purchaseDate': purchaseTime,
      'purchaseIsComplete': isCompletedPurchase,
      'confirmed': isConfirmed,
      'confirmedDate': confirmedDate,
      'completeDate': completeDate,
      'listingStatus': listingStatus,
      'selected': selected,
      'declined': declined,
      'imgurl': imageUrl,
      'consumerCompleted': consumerCompleted,
      'consumerCompletedDate': consumerCompletedDate,
    };
  }
}
