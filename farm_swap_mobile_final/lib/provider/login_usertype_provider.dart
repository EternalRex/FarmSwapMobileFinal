import 'package:flutter/material.dart';

class LoginUserTypeProvider extends ChangeNotifier {
  String loginUserType = "";

  void setLoginUsertype(String userType) {
    loginUserType = userType;
    notifyListeners();
  }

  String get getUserType {
    return loginUserType;
  }
}
