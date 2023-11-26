import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_options_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/display_farmer_reviews/display_farmer_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFarmerReviewAndRAting extends StatelessWidget {
  const MyFarmerReviewAndRAting({super.key});

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
              Icons.wallet,
              color: farmSwapTitlegreen,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const DisplayFarmerReviews();
                  },
                ));
              },
              child: DashBoardTxt(
                myText: "My Reviews",
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
