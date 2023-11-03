import 'package:flutter/material.dart';

class AllListingTypeProvider extends ChangeNotifier {
  String listingType = "";

  void setListingType(String type) {
    listingType = type;
    notifyListeners();
  }

  String get getListingType {
    return listingType;
  }
}
