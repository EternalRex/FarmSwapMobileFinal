import 'package:farm_swap_mobile_final/authentication/user_authentication.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/controllers/login_txt_controller.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/database/update_onlinestatus.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
/*Instance  of the text editing controller class */
  LoginTextControllers controllers = LoginTextControllers();

  bool _isPasswordVisible = true; // Initialize it as false initially.

/*Function for showing and hding password using an icon */
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

/*disposing controllers */
  @override
  void dispose() {
    controllers.emailController.dispose();
    controllers.passwordController.dispose();
    super.dispose();
  }

  String? userType;

  @override
  Widget build(BuildContext context) {
/*Akon gi pull out ang value nga naa sa login usertype na provider kay akong e pasa didto sa login
na function */

    String userRole =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType.toUpperCase();
    setState(() {
      userType = userRole;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                top: -450.sp,
                bottom: 0.sp,
                child: SvgPicture.asset(
                  "assets/karl_assets/icons/Pattern.svg",
                  height: 100,
                  width: 400,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Logo */
                    Image(
                      image: const AssetImage("assets/karl_assets/images/logo3.png"),
                      height: 120.h,
                    ),
                    /*FarmSwap Title */
                    Text(
                      "FarmSwap",
                      style: GoogleFonts.viga(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.50,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color(0xFF53E78B),
                              Color(0xFF14BE77),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                      ),
                    ),
                    /*FARM SWAP DESCRIPTION */
                    Text(
                      "Modern Barter Solution",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF09051C),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: <Widget>[
                          /*SIZED BOX THAT GIVES SPACE BETWEEN THE DESCRIPTION AND THE
                  LOGIN TITLE */
                          SizedBox(
                            height: 30.h,
                          ),
                          /*LOG IN ACCOUNT TITLE */
                          Text(
                            "Login To Your Account",
                            style: TextStyle(
                              color: const Color(0xFF09041B),
                              fontSize: 18.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          /*GIVES A 20 HEIGHT SPACE BETWEEN THE LOGIN TITLE AND THE EMAIL TEXT BOX */
                          SizedBox(
                            height: 20.h,
                          ),

                          //a container for the email textfield
                          FarmSwapTextField(
                            controller: controllers.emailController,
                            label: const Text("Enter Email"),
                            isPassword: false,
                            prefixIcon: Icon(
                              Icons.email,
                              color: farmSwapSmoothGreen,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          //a container for the password textfield
                          FarmSwapTextField(
                            controller: controllers.passwordController,
                            label: const Text("Enter password"),
                            isPassword: _isPasswordVisible,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: farmSwapSmoothGreen,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: const Color.fromARGB(255, 46, 184, 76),
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          /*Start of google option for login */
                          Text(
                            "Or continue with",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          /*Actual google options */
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 65.sp),
                                child: Column(
                                  children: [
                                    /*The google icon and words inside a button */
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        "assets/karl_assets/images/google.svg",
                                      ),
                                      label: const Text('Google'),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(10),
                                        fixedSize: Size(250.sp, 60.sp),
                                        textStyle:
                                            TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color.fromARGB(255, 85, 84, 84),
                                        elevation: 15.sp,
                                        shadowColor: shadow,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    /*The text sign up and register with Email */
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(RouteManager.usersignup);
                                            },
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: GoogleFonts.poppins().fontFamily,
                                                color: FarmSwapGreen.darkGreenActive,
                                                fontWeight: FontWeight.w700,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.sp,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed("");
                                            },
                                            child: Text(
                                              "Forgot Password",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: GoogleFonts.poppins().fontFamily,
                                                color: FarmSwapGreen.darkGreenActive,
                                                fontWeight: FontWeight.w700,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    /*Login button and container */
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.sp, top: 20.sp),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 50,
                              width: 141,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF53E78B), Color(0xFF14BE77)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: shadow,
                                    blurRadius: 5,
                                    offset: const Offset(1, 5),
                                  ),
                                ],
                              ),
                              /*Actual login text */
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    login();
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Instance of the authentication class */
  UserAuthentication auth = UserAuthentication();

  /*Instance sa class na mo update sa database field */
  UpdateOnlineStatus onlineStatus = UpdateOnlineStatus();

  void login() async {
    String email = controllers.emailController.text;
    String password = controllers.passwordController.text;
    User? user = await auth.signInUser(email, password);
    if (user != null) {
      /*Passing the necessary value ngadto sa class na mo update sa user online status */
      onlineStatus.updateOnlineStatus(
          FirebaseAuth.instance.currentUser!.uid, true, userType.toString());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(RouteManager.activeDashboard);
    }
  }
}
