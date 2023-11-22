import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/barter/farmer_barterlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisputeNavBar extends StatelessWidget {
  const DisputeNavBar({
    super.key,
    required this.farmerId,
    required this.listingId,
    required this.farmerUname,
    required this.listingUrl,
  });

  final String farmerId;
  final String listingId;
  final String farmerUname;
  final String listingUrl;

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
                    builder: (context) => FarmerBarterList(
                        farmerUname: farmerUname,
                        farmerId: farmerId,
                        farmerListingId: listingId,
                        listingUrl: listingUrl),
                  ),
                );
              },
              child:
                  poppinsText('Barter', Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 150.w,
            child: TextButton(
              onPressed: () {},
              child: poppinsText('Sell', Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
