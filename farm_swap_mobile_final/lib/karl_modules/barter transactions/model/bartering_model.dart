class BarteringModel {
  BarteringModel({
    required this.itemName,
    required this.itemDisc,
    required this.itemCondition,
    required this.itemQuantity,
    required this.itemPicUrl,
    required this.itemValue,
    required this.isAlreadyBartered,
    required this.listingId,
    required this.listingName,
    required this.listingDisc,
    required this.listingEquivalentPrice,
    required this.listingQuantity,
    required this.listingStatus,
    required this.farmerId,
    required this.farmerFName,
    required this.farmerLname,
    required this.farmerUname,
    required this.farmerBaranggay,
    required this.farmerMunicaplity,
    required this.consumerId,
    required this.consumerFname,
    required this.consumerLname,
    required this.consumerUname,
    required this.consumerBarangay,
    required this.consumerMunicipality,
    required this.bidTime,
    required this.selected,
  });

/*The data we needed from the lisiting */
  String listingName;
  String listingDisc;
  double listingEquivalentPrice;
  double listingQuantity;
  String listingStatus;
  String listingId;

/*The data that we need from farmer*/
  String farmerId;
  String farmerFName;
  String farmerLname;
  String farmerUname;
  String farmerBaranggay;
  String farmerMunicaplity;

/*The data that we needed from the  current login user*/
  String consumerId;
  String consumerFname;
  String consumerLname;
  String consumerUname;
  String consumerBarangay;
  String consumerMunicipality;

/*The data we needed from the item to barter */
  String itemName;
  String itemPicUrl;
  String itemDisc;
  String itemCondition;
  double itemValue;
  double itemQuantity;
  bool isAlreadyBartered;
  bool selected;
  DateTime bidTime;

  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'itemDisc': itemDisc,
      'itemCondition': itemCondition,
      'itemValue': itemValue,
      'itemQuantity': itemQuantity,
      'itemPicUrl': itemPicUrl,
      'itemBidTime': bidTime,
      'isBarteredOut': isAlreadyBartered,
      'selected': selected,
      'listingId': listingId,
      'listingName': listingName,
      'listingDiscription': listingDisc,
      'listingPrice': listingEquivalentPrice,
      'listingQuantity': listingQuantity,
      'listingStatus': listingStatus,
      'farmerName': farmerFName,
      'farmerLName': farmerLname,
      'farmerUname': farmerUname,
      'farmerId': farmerId,
      'farmerBaranggay': farmerBaranggay,
      'farmerMunisipyo': farmerMunicaplity,
      'consumerName': consumerFname,
      'consumerLName': consumerLname,
      'consumerUname': consumerUname,
      'consumerId': consumerId,
      'consumerBaranggay': consumerBarangay,
      'consumerMuniciplaity': consumerMunicipality,
    };
  }
}
