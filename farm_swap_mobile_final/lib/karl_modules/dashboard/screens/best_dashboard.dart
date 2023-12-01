import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_best_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestDealsDashboard extends StatefulWidget {
  const BestDealsDashboard({super.key});

  @override
  State<BestDealsDashboard> createState() => _BestDealsDashboardState();
}

class _BestDealsDashboardState extends State<BestDealsDashboard> {
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
              child: const DashBoardGetAllBestListings(),
            ),
          ),
        ),
      ],
    );
  }
}
