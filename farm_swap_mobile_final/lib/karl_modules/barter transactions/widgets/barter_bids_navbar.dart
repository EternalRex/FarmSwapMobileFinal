import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/selected_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/unselected_bid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/poppins_text.dart';

class BarterBidsNavBar extends StatelessWidget {
  const BarterBidsNavBar({
    super.key,
    required this.farmerUname,
    required this.farmerId,
    required this.listingId,
    required this.listUrl,
  });

  final String farmerUname;
  final String farmerId;
  final String listingId;
  final String listUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Row(
        children: [
          SizedBox(
            width: 150.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectedBids(
                        farmerId: farmerId,
                        farmerUname: farmerUname,
                        listingId: listingId,
                        listingUrl: listUrl,
                      );
                    },
                  ),
                );
              },
              child: poppinsText("Selected", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 150.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return UnselectedBarterBids(
                      farmerId: farmerId,
                      farmerUname: farmerUname,
                      listingId: listingId,
                      listUrl: listUrl,
                    );
                  },
                ));
              },
              child: poppinsText("Unselected", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
