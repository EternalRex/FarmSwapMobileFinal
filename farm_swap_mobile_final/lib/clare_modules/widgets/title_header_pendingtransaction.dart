import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleHeaderPendingTransact extends StatelessWidget {
  const TitleHeaderPendingTransact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadows: const [
          BoxShadow(
            color: Color(0x21000000),
            blurRadius: 20,
            offset: Offset(6, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Text(
            'Transactions',
            style: TextStyle(
              color: Colors.green,
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: 0.50,
            ),
          ),
        ],
      ),
    );
  }
}
