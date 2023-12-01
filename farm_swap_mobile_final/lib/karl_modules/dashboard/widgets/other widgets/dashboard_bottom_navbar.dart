import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/provider/dashboard_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/*Mao ni class na nag oontain sa buttons sa bottom navbar, nya naa pd diri ang
kung unsay mahitabo ig press sa botton */

class DashboardButtomNavBar extends StatelessWidget {
  const DashboardButtomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {
                /* Set nato ang value sa provider to barter kung kani na text button ang e click*/
                Provider.of<DashboardTypeProvider>(context, listen: false)
                    .setDashboardType("BARTER");
                Navigator.of(context).pushNamed(RouteManager.activeDashboard);
              },
              child:
                  poppinsText("Barter", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {
                /* Set nato ang value sa provider to SALE kung kani na text button ang e click*/
                Provider.of<DashboardTypeProvider>(context, listen: false)
                    .setDashboardType("SALE");
                Navigator.of(context).pushNamed(RouteManager.activeDashboard);
              },
              child: poppinsText("Sell", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
          /*
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {
                /* Set nato ang value sa provider to BEST kung kani na text button ang e click*/
                Provider.of<DashboardTypeProvider>(context, listen: false)
                    .setDashboardType("BEST");
                Navigator.of(context).pushNamed(RouteManager.activeDashboard);
              },
              child: poppinsText("Best", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
          */
        ],
      ),
    );
  }
}
