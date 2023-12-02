import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/screens/profile%20visits/view_profile_results.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/screens/revenue%20report/revenue_report.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/screens/total%20products/view_total_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportsNavBar extends StatelessWidget {
  const ReportsNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*For profile visits */
            SizedBox(
              width: 50.w,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ViewProfileVisits();
                    },
                  ));
                },
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            /*For total number of products */
            SizedBox(
              width: 50.w,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const TotalNumberofProducts();
                      },
                    ),
                  );
                },
                child: Icon(
                  FontAwesomeIcons.productHunt,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            /*total revenue Report */
            SizedBox(
              width: 50.w,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const RevenueReport();
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
