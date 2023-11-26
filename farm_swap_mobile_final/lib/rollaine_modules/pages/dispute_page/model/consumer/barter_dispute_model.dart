class BarterDisputeModel {
  BarterDisputeModel({
    required this.farmerName,
    required this.farmerId,
    required this.farmerLastName,
    required this.farmerUname,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.consumerName,
    required this.consumerId,
    required this.consumerUname,
    required this.consumserLastName,
    required this.consumerBarangay,
    required this.consumerMunicipality,
    required this.itemName,
    required this.itemValue,
    required this.itemUrl,
    required this.farmerDisputeStatus,
    required this.isResolved,
    required this.disputeDateFile,
    required this.farmerDisputeText,
    required this.farmerDisputeUrl,
    required this.listingId,
    required this.listingName,
    required this.listingPrice,
    required this.listingQuan,
    required this.listingStatus,
    required this.listingUrl,
  });

  /*Farmer Details */
  String farmerName;
  String farmerId;
  String farmerLastName;
  String farmerUname;
  String farmerBarangay;
  String farmerMunicipality;

  /*Consumer Details */
  String consumerName;
  String consumerId;
  String consumerUname;
  String consumserLastName;
  String consumerBarangay;
  String consumerMunicipality;

  /*Item details */
  String itemName;
  double itemValue;
  String itemUrl;

  String listingName;
  String listingId;
  String listingPrice;
  String listingQuan;
  String listingStatus;
  String listingUrl;

  DateTime disputeDateFile;

  bool isResolved;

  String farmerDisputeStatus;

  String farmerDisputeText;

  String farmerDisputeUrl;

  Map<String, dynamic> toMap() {
    return {
      'farmerName': farmerName,
      'farmerId': farmerId,
      'farmerLname': farmerLastName,
      'farmerUname': farmerUname,
      'farmerBarangay': farmerBarangay,
      'farmerMunicipality': farmerMunicipality,
      'consumerName': consumerName,
      'consumerId': consumerId,
      'consumerUname': consumerUname,
      'consumerLname': consumserLastName,
      'consumerBarangay': consumerBarangay,
      'consumerMunicipality': consumerMunicipality,
      'itemName': itemName,
      'itemValue': itemValue,
      'itemUrl': itemUrl,
      'farmerDisputeStatus': farmerDisputeStatus,
      'isResolved': isResolved,
      'disputeDateFile': disputeDateFile,
      'farmerDisputeText': farmerDisputeText,
      'farmerDisputeUrl': farmerDisputeUrl,
      'listingId': listingId,
      'listingName': listingName,
      'listingPrice': listingPrice,
      'listingQuan': listingQuan,
      'listingStatus': listingStatus,
      'listingUrl': listingUrl,
    };
  }
}
