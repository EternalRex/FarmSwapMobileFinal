import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/confirmed_farmer_orders.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumerBuyingNavBar extends StatelessWidget {
  const ConsumerBuyingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyOrders();
                    },
                  ),
                );
              },
              child: poppinsText("Orders", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {},
              child: poppinsText("Confirmed", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 100.w,
            child: TextButton(
              onPressed: () {},
              child: poppinsText("Denied", Colors.white, 13.sp, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
