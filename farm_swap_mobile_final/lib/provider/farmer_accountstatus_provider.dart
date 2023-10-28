import 'package:flutter/material.dart';

class FarmerAccounStatusProvider extends ChangeNotifier {
  String accountStatus = "";

  void setCounter(String status) {
    accountStatus = status;
    notifyListeners();
  }

  String get getAccountStatus {
    return accountStatus;
  }
}
