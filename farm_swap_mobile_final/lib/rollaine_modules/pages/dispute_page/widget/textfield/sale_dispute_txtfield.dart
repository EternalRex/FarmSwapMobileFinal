import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaleDisputeTxtField extends StatelessWidget {
  SaleDisputeTxtField({
    super.key,
    required this.controller,
    required this.enabled,
    this.label,
  });

  TextEditingController controller;
  Widget? label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: lightGreenHover,
        ),
      ),
      child: SizedBox(
        width: 330.w,
        height: 70.h,
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration(
            enabled: enabled,
            label: label,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: farmSwapSmoothGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: farmSwapSmoothGreen),
            ),
          ),
          cursorColor: FarmSwapGreen.normalGreen,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
