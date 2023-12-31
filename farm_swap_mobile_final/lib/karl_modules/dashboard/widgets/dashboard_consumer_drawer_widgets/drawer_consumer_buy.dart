import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_options_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumerBuyTransactionBtn extends StatelessWidget {
  const ConsumerBuyTransactionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.sp),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 3.w,
            ),
            const BuyGreen(),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyOrders();
                    },
                  ),
                );
              },
              child: DashBoardTxt(
                myText: "Buy Transactions",
                myColor: const Color(0xFF09041B),
                mySize: 15.sp,
                myFont: GoogleFonts.poppins().fontFamily,
                myWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyGreen extends StatelessWidget {
  const BuyGreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Color(0xFF53E78B), Color(0xFF14BE77)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: const Icon(
        Icons.money_rounded,
        color: Colors.white,
      ),
    );
  }
}
