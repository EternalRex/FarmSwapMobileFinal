import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TitleHeaderText kay para sa header sa cash in form
class TitleHeaderText extends StatelessWidget {
  const TitleHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Fill out cash in information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TitleHeaderText1 kay para sa header sa cash out form
class TitleHeaderText1 extends StatelessWidget {
  const TitleHeaderText1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Fill out cash out information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
