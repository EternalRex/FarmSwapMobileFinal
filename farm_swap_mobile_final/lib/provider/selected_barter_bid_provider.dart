import 'package:flutter/material.dart';

class SelectedBarterBidProvider extends ChangeNotifier {
  bool selected = false;

  void setSelectedItem(bool select) {
    selected = select;
    notifyListeners();
  }

  bool get getSelectedItem {
    return selected;
  }
}
