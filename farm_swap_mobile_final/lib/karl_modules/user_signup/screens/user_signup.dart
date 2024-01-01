import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/common/screen_util_sp_sizes.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/registration_2/registration2.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
/*Creating object of the screen util sizes class*/
  SPScreenUtilSizes sizes = SPScreenUtilSizes();
  final GlobalKey _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: SafeArea(
          child: SizedBox(
        /*Stacked so that i can put a content ontop of a background picture */
        child: Stack(
          children: [
            /*Background Picture */
            Positioned.fill(
              top: -450.sp,
              bottom: 0.sp,
              child: SvgPicture.asset(
                "assets/karl_assets/icons/Pattern.svg",
                height: 100,
                width: 400,
              ),
            ),
            /*Actual content */
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    poppinsText(
                      "What are you?",
                      farmSwapTitlegreen,
                      30.sp,
                      FontWeight.w500,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    /*Start of the farmer choice photo selection */
                    GestureDetector(
                      onTap: () {
                        /*Putting the value of Farmer inside a provider when this option is tapped to be used in another page */
                        Provider.of<UserTypeProvider>(context, listen: false).setUserType("Farmer");
                        // Navigator.of(context).pushNamed(RouteManager.userDetailsRegister);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const Registration2();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: farmSwapSmoothGreen,
                            radius: 80.sp,
                            child: Image.asset(
                              "assets/karl_assets/images/farmer.png",
                              width: 300.sp,
                              height: 300.sp,
                            ),
                          ),
                          poppinsText("Farmer", Colors.black, 20.sp, FontWeight.w500),
                        ],
                      ),
                    ),
                    /*End of the farmer choice photo selection */
                    SizedBox(
                      height: 30.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        /*Putting the value of Farmer inside a provider when this option is tapped to be used in another page */
                        Provider.of<UserTypeProvider>(context, listen: false)
                            .setUserType("Consumer");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const Registration2();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 80.sp,
                            backgroundColor: farmSwapSmoothGreen,
                            child: Image.asset("assets/karl_assets/images/consumer.png"),
                          ),
                          poppinsText("Consumer", Colors.black, 20.sp, FontWeight.w300),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteManager.userlogin);
                        },
                        child: Text(
                          "I already have an account",
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
              ),
            ),
          ],
        ),
      )),
    );
  }
}
