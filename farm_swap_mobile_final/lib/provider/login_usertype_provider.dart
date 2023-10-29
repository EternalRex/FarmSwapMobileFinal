import 'package:flutter/material.dart';

/*Kani na na provider kay mao ni mag karga sa value nga mag determine kong
ang ni login kay farmer or consumer, unya sa pag construct sa mga upcoming pages
ato gamiton iya value para ma separate ang code sa kang farmer og consumer bisan
nara sa the same na class */

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
