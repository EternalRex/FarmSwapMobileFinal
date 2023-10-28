import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/database/update_onlinestatus.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drawer_options_text.dart';

class Signout extends StatelessWidget {
  Signout({super.key});

/*Instance of the class that will update the value of online status*/
  final UpdateOnlineStatus updateOnlineStatus = UpdateOnlineStatus();

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;

    return Padding(
      padding: EdgeInsets.only(left: 4.sp),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 3.w,
            ),
            Icon(
              Icons.logout,
              color: farmSwapTitlegreen,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              onPressed: () {
                /*Updating the online status to false depende kung kinsay ni login, farmer ba
                or consumer so agad rajud tas value nga naa sa atong LoginUserTypeProvider*/
                (userRole == "FARMER")
                    ? updateOnlineStatus.updateOnlineStatus(
                        FirebaseAuth.instance.currentUser!.uid,
                        false,
                        "FARMER",
                      )
                    : updateOnlineStatus.updateOnlineStatus(
                        FirebaseAuth.instance.currentUser!.uid,
                        false,
                        "CONSUMER",
                      );
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed(RouteManager.userloginselection);
              },
              child: DashBoardTxt(
                myText: "Sign Out",
                myColor: const Color(0xFF09041B),
                mySize: 15.sp,
                myFont: GoogleFonts.poppins().fontFamily,
                myWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
