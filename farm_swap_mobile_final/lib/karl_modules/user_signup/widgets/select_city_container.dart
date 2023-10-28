import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCityDropDownBtn extends StatelessWidget {
  const SelectCityDropDownBtn({super.key, required this.botton});
  final Widget botton;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.sp,
        width: 330.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 5,
              offset: const Offset(1, 5),
            ),
          ],
        ),
        child: botton);
  }
}
