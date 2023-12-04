import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/consumer_dispute_page.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer/consumer_done_reports_barter.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_barter_resolutions/consumer_dispute_barter_resol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumerDisputePageNavBar extends StatelessWidget {
  const ConsumerDisputePageNavBar({super.key});

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
                      return const ConsumerDisputePage();
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
                      return const ConsumerDoneReportBarter();
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
                      return const ConsumerBarterResolutions();
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
