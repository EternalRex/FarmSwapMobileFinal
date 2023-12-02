import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/consumer%20profile%20reports/consumer_profile_reports.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/goods/consumer_goods_report.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/transaction%20reports/consumer_transactions_reporting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerReportNavbar extends StatelessWidget {
  const CustomerReportNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var sp;
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
                      return const ConsumerProfileReports();
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
            /*For total number of Goods */
            SizedBox(
              width: 50.w,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ConsumerGoodsReport();
                    },
                  ));
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ConsumerAllTransactionsReporting();
                    },
                  ));
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
