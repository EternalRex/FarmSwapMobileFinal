import 'package:flutter/material.dart';

class UserTypeProvider extends ChangeNotifier {
  String userType = "";

  void setUserType(String user) {
    userType = user;
    notifyListeners();
  }

  String get getUserType {
    return userType;
  }
}
