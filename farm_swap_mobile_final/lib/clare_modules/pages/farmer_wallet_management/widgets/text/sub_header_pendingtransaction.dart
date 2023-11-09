import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//subheader for wALLET
class SubHeaderPendingTransaction extends StatelessWidget {
  const SubHeaderPendingTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Text(
            'Type',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
          SizedBox(
            width: 45.w,
          ),
          Text(
            'Amount',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
          SizedBox(
            width: 35.w,
          ),
          Text(
            'Date',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
          SizedBox(
            width: 40.w,
          ),
          Text(
            'Status',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
    );
  }
}

//subheader for swapcoins
class SubHeaderPendingTransaction1 extends StatelessWidget {
  const SubHeaderPendingTransaction1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Date',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Amount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Status',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
    );
  }
}
