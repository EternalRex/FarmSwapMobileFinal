import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/active_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/pending_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/screen/user_login_screen.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/screen/user_login_selection.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup10.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup2.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup3.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup4.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup5.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup6.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup7.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup8.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup9.dart';
import 'package:flutter/material.dart';

class RouteManager {
/*Properties of the route*/
  static const usersignup = "/";
  static const userlogin = "/userlogin";
  static const userDetailsRegister = "/userdetailsregister";
  static const userDetailsRegister2 = "/userdetailsregister2";
  static const userDetailsRegister3 = "/userdetailsregister3";
  static const userDetailsRegister4 = "/userDetailsRegister4";
  static const userDetailsRegister5 = "/userDetailsRegister5";
  static const userDetailsRegister6 = "/userDetailsRegister6";
  static const userDetailsRegister7 = "/userDetailsRegister7";
  static const userDetailsRegister8 = "/userDetailsRegister8";
  static const userDetailsRegisterEnd = "/userDetailsRegisterEnd";
  static const pendingAccountsDashboar = "/pendingAccountsDashboar";
  static const activeDashboard = "/activeDashboard";
  static const userloginselection = "/userloginselection";

/*Route method */
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case usersignup:
        return MaterialPageRoute(builder: (context) => const UserSignUpScreen());

      case userlogin:
        return MaterialPageRoute(builder: (context) => const UserLoginScreen());

      case userDetailsRegister:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration());

      case userDetailsRegister2:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration2());

      case userDetailsRegister3:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration3());

      case userDetailsRegister4:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration4());

      case userDetailsRegister5:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration5());

      case userDetailsRegister6:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration6());

      case userDetailsRegister7:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration7());

      case userDetailsRegister8:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration8());

      case userDetailsRegisterEnd:
        return MaterialPageRoute(builder: (context) => const UserRegisterEndPage());

      case pendingAccountsDashboar:
        return MaterialPageRoute(builder: (context) => const PendingDashBoard());

      case activeDashboard:
        return MaterialPageRoute(builder: (context) => ActiveDashboard());

      case userloginselection:
        return MaterialPageRoute(builder: (context) => const UserTypeLoginSelection());

      default:
        throw const FormatException("Warning!!! Page Routing Problem");
    }
  }
}