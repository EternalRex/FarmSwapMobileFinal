import 'package:flutter/material.dart';

class BartertingItemDetailsProvider extends ChangeNotifier {
  /*Details we need from item */
  String itemName = "";
  String itemDisc = "";
  double itemVal = 0;
  double itemQuan = 0;
  String itemCondition = "";
  String itemUrl = "";
  bool alreadyBartered = false;

  /*Details we need from listing */
  String listingid = "";
  String listingname = "";
  String listingdisc = "";
  String listingprice = "";
  String listingquan = "";
  String listingstatus = "";

  /*Details we need from farmer */
  String farmername = "";
  String farmerid = "";
  String farmerlname = "";
  String farmerUname = "";
  String farmerbarangay = "";
  String farmermunicipal = "";

  /*Details we need from consumer */

  String consumerid = "";
  String consumerfname = "";
  String consumerlname = "";
  String consumeruname = "";
  String consumerbarangay = "";
  String consumermunicipality = "";

  /*Setter and getter for item details */
  void setItemName(String name) {
    itemName = name;
    notifyListeners();
  }

  String get getItemName {
    return itemName;
  }

  void setItemDisc(String discription) {
    itemDisc = discription;
    notifyListeners();
  }

  String get getItemDisc {
    return itemDisc;
  }

  void setitemValue(double value) {
    itemVal = value;
    notifyListeners();
  }

  double get getItemValue {
    return itemVal;
  }

  void setItemQuantity(double quantity) {
    itemQuan = quantity;
    notifyListeners();
  }

  double get getItemQuantity {
    return itemQuan;
  }

  void setItemCondition(String condition) {
    itemCondition = condition;
    notifyListeners();
  }

  String get getItemCondition {
    return itemCondition;
  }

  void setItemUrl(String url) {
    itemUrl = url;
    notifyListeners();
  }

  String get getItemUrl {
    return itemUrl;
  }

/*Setter and getters for the listing details */

  void setListingId(String listid) {
    listingid = listid;
    notifyListeners();
  }

  String get getListingId {
    return listingid;
  }

  void setListingName(String listname) {
    listingname = listname;
    notifyListeners();
  }

  String get getListingName {
    return listingname;
  }

  void setListingDisc(String listdisc) {
    listingdisc = listdisc;
    notifyListeners();
  }

  String get getListDisc {
    return listingdisc;
  }

  void setListingPrice(String listprice) {
    listingprice = listprice;
    notifyListeners();
  }

  String get getListingPrice {
    return listingprice;
  }

  void setListingQuan(String listQuan) {
    listingquan = listQuan;
    notifyListeners();
  }

  String get getListingQuan {
    return listingquan;
  }

  void setListingStatus(String liststatus) {
    listingstatus = liststatus;
    notifyListeners();
  }

  String get getListingStatus {
    return listingstatus;
  }

  /*setter and getter for farmer details*/
  void setFarmerFname(String fname) {
    farmername = fname;
    notifyListeners();
  }

  String get getFarmerFname {
    return farmername;
  }

  void setFarmerLname(String flname) {
    farmerlname = flname;
    notifyListeners();
  }

  String get getFarmerLname {
    return farmerlname;
  }

  void setFarmerId(String fid) {
    farmerid = fid;
    notifyListeners();
  }

  String get getFarmerId {
    return farmerid;
  }

  void setFarmerUname(String funame) {
    farmerUname = funame;
    notifyListeners();
  }

  String get getFarmerUname {
    return farmerUname;
  }

  void setFarmerBaranggay(String fbaranggay) {
    farmerbarangay = fbaranggay;
    notifyListeners();
  }

  String get getFarmerBrgy {
    return farmerbarangay;
  }

  void setFarmerMunisipyo(String fmunisipyo) {
    farmermunicipal = fmunisipyo;
    notifyListeners();
  }

  String get getFarmerMunisipyo {
    return farmermunicipal;
  }

/*setters and getters for the consumer details */
  void setConsumerId(String cid) {
    consumerid = cid;
    notifyListeners();
  }

  String get getConsumerId {
    return consumerid;
  }

  void setConsumerFname(String cfname) {
    consumerfname = cfname;
    notifyListeners();
  }

  String get getConsumerFname {
    return consumerfname;
  }

  void setConsumerLname(String clname) {
    consumerlname = clname;
    notifyListeners();
  }

  String get getConsumerLname {
    return consumerlname;
  }

  void setCOnsumerUname(String cuname) {
    consumeruname = cuname;
    notifyListeners();
  }

  String get getConsumerUname {
    return consumeruname;
  }

  void setConsumerBaranggay(String cbaranggay) {
    consumerbarangay = cbaranggay;
    notifyListeners();
  }

  String get getConsumerBaranggay {
    return consumerbarangay;
  }

  void setConsumerMunisipyo(String cmunisipyo) {
    consumermunicipality = cmunisipyo;
    notifyListeners();
  }

  String get getConsumerMunisipyo {
    return consumermunicipality;
  }
}
