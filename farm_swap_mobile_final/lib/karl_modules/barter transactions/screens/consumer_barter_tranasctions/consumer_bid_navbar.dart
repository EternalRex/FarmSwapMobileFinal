import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/consumer_barter_tranasctions/consumer_accepted_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/consumer_barter_tranasctions/consumer_unaccepted_bid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/poppins_text.dart';

class ConsumerBarterBidsNavbar extends StatefulWidget {
  const ConsumerBarterBidsNavbar({super.key});

  @override
  State<ConsumerBarterBidsNavbar> createState() => _ConsumerBarterBidsNavbarState();
}

class _ConsumerBarterBidsNavbarState extends State<ConsumerBarterBidsNavbar> {
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
                      return const ConsumerSelectedBid();
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
                    return const ConsumerUnacceptedBid();
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
