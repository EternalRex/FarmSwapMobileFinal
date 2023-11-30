import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/controllers/login_txt_controller.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
/*Instance  of the text editing controller class */
  LoginTextControllers controllers = LoginTextControllers();

/*disposing controllers */
  @override
  void dispose() {
    controllers.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFDA6317),
                      ),
                      splashColor: const Color(0xFFF9A84D),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteManager.userloginselection);
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    /*Logo */
                    Image(
                      image: const AssetImage(
                          "assets/karl_assets/images/logo3.png"),
                      height: 120.h,
                    ),

                    /*FARM SWAP DESCRIPTION */
                    Text(
                      "Forgot Password",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF09051C),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
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
                            "Enter your email to reset password.",
                            style: TextStyle(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600,
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
                                  colors: [
                                    Color(0xFF53E78B),
                                    Color(0xFF14BE77)
                                  ],
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
                                    //if the user role is farmer then this funtion will perform
                                    if (userRole == "FARMER") {
                                      checkEmailFarmer();
                                    }
                                    //else if then this function will perform
                                    else if (userRole == "CONSUMER") {
                                      checkEmailConsumer();
                                    }
                                    //it will navigate to usrr login selection
                                    else {
                                      Navigator.of(context).pushNamed(
                                          RouteManager.userloginselection);
                                    }
                                  },
                                  child: Text(
                                    "Check Email",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
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

  //function checks if a given email address exists in the 'sample_FarmerUsers' Firestore collection
  //by querying the collection and returning true if a matching document is found
  //and false if no matching document is found.
  Future<bool> doesEmailExistFarmer(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('sample_FarmerUsers')
        .where('email', isEqualTo: email)
        .get();

    return result.docs.isNotEmpty;
  }

  //function checks if a given email address exists in the 'sample_ConsumerUsers' Firestore collection
  //by querying the collection and returning true if a matching document is found
  //and false if no matching document is found.
  Future<bool> doesEmailExistConsumer(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('sample_ConsumerUsers')
        .where('email', isEqualTo: email)
        .get();

    return result.docs.isNotEmpty;
  }

  final email = FirebaseAuth.instance.currentUser?.email ?? '';

  //this calls the function doesEmailExist
  //and if email exist it shows the dialog box
  void checkEmailFarmer() async {
    final enteredEmail = controllers.emailController.text.trim();
    final emailExists = await doesEmailExistFarmer(enteredEmail);

    if (emailExists) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: enteredEmail,
        );

        // Show success message or navigate to the next screen.
        showSuccessDialog();
      } catch (e) {
        print("Error sending password reset email: $e");
        showErrorDialog(
            "Error sending password reset email. Please try again.");
      }
    } else {
      showErrorDialog("Email not found. Please enter a valid email address.");
    }
  }

  void checkEmailConsumer() async {
    final enteredEmail = controllers.emailController.text.trim();
    final emailExists = await doesEmailExistConsumer(enteredEmail);

    if (emailExists) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: enteredEmail,
        );

        showSuccessDialog();
      } catch (e) {
        print("Error sending password reset email: $e");
        showErrorDialog(
            "Error sending password reset email. Please try again.");
      }
    } else {
      showErrorDialog("Email not found. Please enter a valid email address.");
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Found!'),
          content:
              const Text("The entered email exists. Please check your email."
                  "Click 'OK' to proceed with resetting the password."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteManager.userloginselection);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
