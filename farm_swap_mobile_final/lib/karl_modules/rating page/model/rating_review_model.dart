class RatingReviewModel {
  RatingReviewModel({
    required this.farmerId,
    required this.farmerName,
    required this.farmerLname,
    required this.farmerUname,
    required this.farmerBarangay,
    required this.farmerMunicipal,
    required this.consumerId,
    required this.consumerName,
    required this.consumerLname,
    required this.consumerUname,
    required this.consBarangay,
    required this.consMunicipal,
    required this.review,
    required this.rate,
    required this.reviewDate,
  });
  /*Farmer Details*/
  String farmerId;
  String farmerName;
  String farmerLname;
  String farmerUname;
  String farmerBarangay;
  String farmerMunicipal;

  /*String*/
  String consumerId;
  String consumerName;
  String consumerLname;
  String consumerUname;
  String consBarangay;
  String consMunicipal;

  /*Review and rating*/
  String review;
  int rate;
  DateTime reviewDate;

  Map<String, dynamic> toMap() {
    return {
      'farmerid': farmerId,
      'farmerName': farmerName,
      'farmerLname': farmerLname,
      'farmerUname': farmerUname,
      'farmerBarangay': farmerBarangay,
      'farmerMunicipal': farmerMunicipal,
      'consumerId': consumerId,
      'consumerName': consumerName,
      'consumerLname': consumerLname,
      'consumerUname': consumerUname,
      'consumerBarangay': consBarangay,
      'consumerMunicipal': consMunicipal,
      'review': review,
      'rate': rate,
      'reviewDate': reviewDate,
    };
  }
}
