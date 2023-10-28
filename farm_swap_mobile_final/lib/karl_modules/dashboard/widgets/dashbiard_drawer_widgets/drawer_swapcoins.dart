import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drawer_options_text.dart';

class MySwapCoinsManagement extends StatelessWidget {
  const MySwapCoinsManagement({super.key});

  @override
  Widget build(BuildContext context) {
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
              Icons.attach_money_rounded,
              color: farmSwapTitlegreen,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              onPressed: () {},
              child: DashBoardTxt(
                myText: "Swap Coins",
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
