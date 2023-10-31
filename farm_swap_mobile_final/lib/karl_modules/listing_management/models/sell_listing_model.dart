class SellListingModels {
  SellListingModels({
    required this.listingName,
    required this.listingDiscription,
    required this.listingQuantityKg,
    required this.listingPircePerKilo,
    required this.listingCategory,
    required this.listingPictureUrl,
    required this.listingStartTime,
    required this.listingEndTime,
    required this.farmerFName,
    required this.farmerLname,
    required this.farmerMuncipality,
    required this.farmerBaranggay,
    required this.farmerUserName,
    required this.promoted,
    required this.listingStatus,
  });

/*Properties*/
  String listingName;
  String listingStatus;
  String listingDiscription;
  double listingQuantityKg;
  double listingPircePerKilo;
  String listingCategory;
  String listingPictureUrl;
  DateTime listingStartTime;
  DateTime listingEndTime;
  String farmerFName;
  String farmerLname;
  String farmerMuncipality;
  String farmerBaranggay;
  String farmerUserName;
  bool promoted;

  Map<String, dynamic> toMap() {
    return {
      'listingName': listingName,
      'listingstatus': listingStatus,
      'listingdiscription': listingDiscription,
      'listingQuantity': listingQuantityKg,
      'listingprice': listingPircePerKilo,
      'listingcategory': listingCategory,
      'listingpictureUrl': listingPictureUrl,
      'listingStartTime': listingStartTime,
      'listingEndTime': listingEndTime,
      'farmerFname': farmerFName,
      'farmerLname': farmerLname,
      'farmerMunicipality': farmerMuncipality,
      'farmerBaranggay': farmerBaranggay,
      'farmerUserName': farmerUserName,
      'promoted': promoted,
    };
  }
}
