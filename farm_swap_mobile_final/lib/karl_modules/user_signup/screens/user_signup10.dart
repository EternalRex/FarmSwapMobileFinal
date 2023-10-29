import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UserRegisterEndPage extends StatelessWidget {
  const UserRegisterEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<UserTypeProvider>(context, listen: false).getUserType;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /*background of the screen */
            Positioned.fill(
              top: -450.sp,
              bottom: 0.sp,
              child: SvgPicture.asset(
                "assets/karl_assets/icons/Pattern.svg",
                height: 100,
                width: 400,
              ),
            ),
            /*Condition to display some customize screen content if user registering is farmer
            or consumer */
            (userRole == "Farmer")
                ? Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*Congratulatins icon */
                          SizedBox(
                            width: 200.sp,
                            height: 200.sp,
                            child: Image.asset(
                              "assets/karl_assets/images/illustration.png",
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Congratulations title */
                          poppinsText(
                            "Congratulations",
                            farmSwapTitlegreen,
                            25,
                            FontWeight.bold,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Subtitle indicatino account is under review */
                          SizedBox(
                            width: 250.sp,
                            height: 100.sp,
                            child: poppinsText(
                              "Farmer account application is being reveiwed, Please wait for 1-2 days. Thank you for joining FarmSwap",
                              Colors.black,
                              12.sp,
                              FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteManager.userloginselection);
                            },
                            child: const FarmSwapGreenBtn(text: "Finish"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*Congratulatins icon */
                          SizedBox(
                            width: 200.sp,
                            height: 200.sp,
                            child: Image.asset(
                              "assets/karl_assets/images/illustration.png",
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Congratulations title */
                          poppinsText(
                            "Congratulations",
                            farmSwapTitlegreen,
                            25,
                            FontWeight.bold,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Subtitle indicatino account is under review */
                          SizedBox(
                            width: 250.sp,
                            height: 100.sp,
                            child: poppinsText(
                              "Consumer account registration is successfull!. Thank you for joining FarmSwap",
                              Colors.black,
                              12.sp,
                              FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(RouteManager.userloginselection);
                            },
                            child: const FarmSwapGreenBtn(text: "Finish"),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
