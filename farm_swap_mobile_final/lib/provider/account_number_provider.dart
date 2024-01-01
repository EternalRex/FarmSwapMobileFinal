import 'package:flutter/material.dart';

class AccountNumberProvider extends ChangeNotifier {
  bool twoAccounts = false;

  void isManyAccountNumber(bool isTwo) {
    twoAccounts = isTwo;
    notifyListeners();
  }

  bool get isManyAccounts {
    return twoAccounts;
  }
}
