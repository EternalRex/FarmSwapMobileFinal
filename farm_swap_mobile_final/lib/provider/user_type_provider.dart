import 'package:flutter/material.dart';

/*Kini is ginagmit ni nato sa signup na part, so pinaagi ani ma code nato ang para sa 
kang farmer og consumer na UI og functionality in the same class */

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
