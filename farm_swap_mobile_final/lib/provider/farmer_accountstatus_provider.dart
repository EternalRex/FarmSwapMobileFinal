import 'package:flutter/material.dart';

/*Kani na provider is atong gamiton para mahibal an nato ig login ni farmer kong 
approve, pending or denied ba iyang account, to be implemented pa ni siya by clare
and rollaine */

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
