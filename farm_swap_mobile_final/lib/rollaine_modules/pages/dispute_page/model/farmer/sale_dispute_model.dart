import 'dart:collection';

class SaleDisputeModel {
  SaleDisputeModel({
    /*Require farmer details */
    required this.farmerUrl,
    required this.farmerName,
    required this.farmerLName,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerMuniciplaity,
    required this.farmerBarangay,
    /*Require consumer details */
    required this.consumerUrl,
    required this.consumerName,
    required this.consumerLName,
    required this.consumerUname,
    required this.consumerId,
    required this.consumerMuniciplaity,
    required this.consumerBarangay,
    /*Require listing details */
    required this.listingUrl,
    required this.listingId,
    required this.listingName,
    required this.listingQuan,
    required this.listingPrice,
    /*require purchase details*/
    required this.purchasePrice,
    required this.purchaseQuantity,
    required this.purchaseSwapCoinsPay,
    /*Transaction details*/
    required this.isDisputed,
    required this.transactionDate,
    /*Dispute Details */
    required this.disputeStatus,
    required this.disputeUrl,
    required this.disputeText,
    required this.disputeDate,
  });

  /*Farmer details*/
  String farmerUrl;
  String farmerName;
  String farmerLName;
  String farmerUname;
  String farmerId;
  String farmerMuniciplaity;
  String farmerBarangay;

  /*Consumer Details*/
  String consumerUrl;
  String consumerName;
  String consumerLName;
  String consumerUname;
  String consumerId;
  String consumerMuniciplaity;
  String consumerBarangay;

  /*listing details */
  String listingId;
  String listingUrl;
  String listingName;
  double listingPrice;
  double listingQuan;

  /*Purchase details*/
  double purchaseQuantity;
  double purchasePrice;
  double purchaseSwapCoinsPay;

  /*Transaction details*/
  bool isDisputed;
  DateTime transactionDate;

/*Dispute details */
  String disputeStatus;
  String disputeUrl;
  String disputeText;
  DateTime disputeDate;

  Map<String, dynamic> toMap() {
    return {
      'farmerUrl': farmerUrl,
      'farmerName': farmerName,
      'farmerLName': farmerLName,
      'farmerUname': farmerUname,
      'farmerId': farmerId,
      'farmerMuniciplaity': farmerMuniciplaity,
      'farmerBarangay': farmerBarangay,
      'consumerUrl': consumerUrl,
      'consumerName': consumerName,
      'consumerLName': consumerLName,
      'consumerUname': consumerUname,
      'consumerId': consumerId,
      'consumerMuniciplaity': consumerMuniciplaity,
      'consumerBarangay': consumerBarangay,
      'listingId': listingId,
      'listingUrl': listingUrl,
      'listingName': listingName,
      'listingPrice': listingPrice,
      'listingQuan': listingQuan,
      'purchaseQuantity': purchaseQuantity,
      'purchasePrice': purchasePrice,
      'purchaseSwapCoinsPay': purchaseSwapCoinsPay,
      'isDisputed': isDisputed,
      'transactionDate': transactionDate,
      'disputeStatus': disputeStatus,
      'disputeUrl': disputeUrl,
      'disputeText': disputeText,
      'disputeDate': disputeDate,
    };
  }
}
