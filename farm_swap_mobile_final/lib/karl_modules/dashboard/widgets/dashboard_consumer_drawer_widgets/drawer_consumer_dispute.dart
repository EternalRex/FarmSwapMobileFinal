import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_options_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/*Kani na class is button ni siya  drawer na kung e click mo redirect ni siya sa desired page */

class ConsumerDisputeManagementBtn extends StatelessWidget {
  const ConsumerDisputeManagementBtn({super.key});

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
            const DisGreen(),
            SizedBox(
              width: 10.w,
            ),
            TextButton(
              onPressed: () {},
              child: DashBoardTxt(
                myText: "Disputes",
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

class DisGreen extends StatelessWidget {
  const DisGreen({
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
        Icons.report_rounded,
        color: Colors.white,
      ),
    );
  }
}
