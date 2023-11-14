import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/colors.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
    Key? key,
    required this.controller,
    required this.enabled,
    this.label,
    this.prefixIcon,
  }) : super(key: key);

  TextEditingController controller;
  Widget? label;
  final bool enabled;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: lightGreenHover,
        ),
      ),
      child: SizedBox(
        width: 150.w, // Set the desired width
        child: SizedBox(
          height: 35.h, // Set the desired height
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabled: enabled,
              label: label,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      ),
    );
  }
}
