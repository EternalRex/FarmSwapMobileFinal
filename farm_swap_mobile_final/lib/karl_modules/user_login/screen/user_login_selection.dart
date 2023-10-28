import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/common/screen_util_sp_sizes.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

/*Ang purpose ngano need mo select si user nga farmer ba siya or consumer usa siya no login is
para mabutang nato sa provider kung unsa na type na user ang mi login. Then during sa login function
mag querry ta sa database para pull outon ang data sa ni login na user sama sa profile pic, og name,
karon, ang question, is asa man ta na collection mag querry? sa farmer ba or user? so diri na magamit
atong provider nga nag karga sa user type, so butang tag condition na if ang value ni provider kay
FARMER, then adto ta sa farmer collection mag querry, og kung user, aw adto ta mag querry sa user collection
ton naay sample na prefix */

class UserTypeLoginSelection extends StatefulWidget {
  const UserTypeLoginSelection({super.key});

  @override
  State<UserTypeLoginSelection> createState() => _UserTypeLoginSelectionState();
}

class _UserTypeLoginSelectionState extends State<UserTypeLoginSelection> {
/*Creating object of the screen util sizes class*/
  SPScreenUtilSizes sizes = SPScreenUtilSizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Log in As?",
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
                        Provider.of<LoginUserTypeProvider>(context, listen: false)
                            .setLoginUsertype("FARMER");
                        Navigator.of(context).pushNamed(RouteManager.userlogin);
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
                        Provider.of<LoginUserTypeProvider>(context, listen: false)
                            .setLoginUsertype("CONSUMER");
                        Navigator.of(context).pushNamed(RouteManager.userlogin);
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
