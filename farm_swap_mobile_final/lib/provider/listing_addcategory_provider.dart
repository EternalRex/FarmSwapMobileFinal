import 'package:flutter/material.dart';

class AddListingCategoryProvider extends ChangeNotifier {
  String category = "";

  void setListingCategory(String addCategory) {
    category = addCategory;
    notifyListeners();
  }

  String get getListingCategory {
    return category;
  }
}
