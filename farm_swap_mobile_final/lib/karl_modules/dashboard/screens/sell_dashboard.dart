import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellDashboard extends StatefulWidget {
  const SellDashboard({super.key});

  @override
  State<SellDashboard> createState() => _SellDashboardState();
}

class _SellDashboardState extends State<SellDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 440.h,
              child: const DashBoardGetAllSellListings(),
            ),
          ),
        ),
      ],
    );
  }
}
