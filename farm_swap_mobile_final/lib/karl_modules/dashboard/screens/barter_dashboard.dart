import "package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_listings.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class BarterDashboard extends StatefulWidget {
  const BarterDashboard({super.key});

  @override
  State<BarterDashboard> createState() => _BarterDashboardState();
}

class _BarterDashboardState extends State<BarterDashboard> {
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
              height: 460.h,
              child: const DashBoardGetAllBarterListings(),
            ),
          ),
        ),
      ],
    );
  }
}
