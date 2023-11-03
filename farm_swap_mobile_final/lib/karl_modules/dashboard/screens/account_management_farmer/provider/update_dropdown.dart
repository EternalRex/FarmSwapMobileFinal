import 'package:flutter/material.dart';

class UpdateDropDownHint extends ChangeNotifier {
  String newhint = "";

  void setHint(String hint) {
    newhint = hint;
    notifyListeners();
  }

  String getHint() {
    return newhint;
  }
}
