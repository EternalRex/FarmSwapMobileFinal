import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/screens/farmer_admin_chat.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/screens/farmer_consumer_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPageBottomNavBar extends StatefulWidget {
  const ChatPageBottomNavBar({super.key});

  @override
  State<ChatPageBottomNavBar> createState() => _ChatPageBottomNavBarState();
}

class _ChatPageBottomNavBarState extends State<ChatPageBottomNavBar> {
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
                      return const FarmerConsumerChat();
                    },
                  ),
                );
              },
              child: poppinsText("Consumer", Colors.white, 20.sp, FontWeight.bold),
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
                    return const FarmerAdminChat();
                  },
                ));
              },
              child: poppinsText("Admin", Colors.white, 20.sp, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
