import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/farmer_dispute_page.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/farmer_done_reports.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/main%20dispute%20page/main_dispute_resol_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmerBarterDisputesNavBar extends StatelessWidget {
  const FarmerBarterDisputesNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Row(
        children: [
          SizedBox(
            width: 112.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const FarmerDisputePage();
                    },
                  ),
                );
              },
              child: poppinsText("Transactions", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 95.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const FarmerDoneReports();
                    },
                  ),
                );
              },
              child: poppinsText("Disputes", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const FarmerBarterSaleResolutionDisplay();
                    },
                  ),
                );
              },
              child: poppinsText("Resolution", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
