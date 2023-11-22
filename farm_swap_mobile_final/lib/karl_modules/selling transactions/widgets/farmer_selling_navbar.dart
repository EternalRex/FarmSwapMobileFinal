import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/confirmed_farmer_orders.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/farmer_orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmerSellingNavbar extends StatefulWidget {
  const FarmerSellingNavbar({super.key});

  @override
  State<FarmerSellingNavbar> createState() => _FarmerSellingNavbarState();
}

class _FarmerSellingNavbarState extends State<FarmerSellingNavbar> {
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
                      return const FarmerOrdersList();
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ConfirmedOrders();
                    },
                  ),
                );
              },
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
