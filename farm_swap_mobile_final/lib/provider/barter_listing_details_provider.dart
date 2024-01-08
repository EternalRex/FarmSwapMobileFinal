import 'package:flutter/material.dart';

class BarterListingDetailsProvider extends ChangeNotifier {
  String listingname = "";
  String listingdisc = "";
  String prefferedItem = "";
  double quantity = 0;
  double price = 0;
  String pictureUrl = "";
  String listingCategory = "";
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

/*Setter and getter for listing name */
  void setListingName(String name) {
    listingname = name;
    notifyListeners();
  }

  String get getListingName {
    return listingname;
  }

  /*Setter and getter for the discription */
  void setListingDisc(String disc) {
    listingdisc = disc;
    notifyListeners();
  }

  String get getListingDisc {
    return listingdisc;
  }

  /*Getter and setter for prod quantity */
  void setquantitiy(double quan) {
    quantity = quan;
    notifyListeners();
  }

  double get getquantity {
    return quantity;
  }

/*Setter and getter for price */
  void setPrice(double myprice) {
    price = myprice;
    notifyListeners();
  }

  double get getPrice {
    return price;
  }

  /*Getter and setter for photo url */
  void setPhotoUrl(String photourl) {
    pictureUrl = photourl;
    notifyListeners();
  }

  String get getPhoto {
    return pictureUrl;
  }

  /*Getter and setter for the start time*/
  void setStartDate(DateTime now) {
    startTime = now;
    notifyListeners();
  }

  DateTime get getStartDate {
    return startTime;
  }

  /*Getter and setter for the end time*/
  void setEndDate(DateTime end) {
    endTime = end;
    notifyListeners();
  }

  DateTime get getEndDate {
    return endTime;
  }

  /*Getter and setter for preferred item */
  void setPrefferedItem(String preffered) {
    prefferedItem = preffered;
    notifyListeners();
  }

  String get getPrefferedItem {
    return prefferedItem;
  }

  /*Getter and setter for listing category*/
  void setListingCategoru(String category) {
    listingCategory = category;
    notifyListeners();
  }

  String get getCategory {
    return listingCategory;
  }
}
