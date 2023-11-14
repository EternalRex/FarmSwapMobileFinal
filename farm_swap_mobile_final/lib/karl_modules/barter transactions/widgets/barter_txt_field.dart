import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BarterTextField extends StatelessWidget {
  const BarterTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.input,
    required this.prefixIcon,
  });

  final TextEditingController controller;
  final Widget label;
  final TextInputType input;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: normalGreen,
      keyboardType: input,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: label,
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: farmSwapSmoothGreen,
            fontSize: 10.sp,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.50.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.50, color: FarmSwapGreen.darkGreen),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.50, color: Color.fromARGB(255, 50, 202, 108)),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.50, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.50, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
