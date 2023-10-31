import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddListingTexField extends StatelessWidget {
  AddListingTexField({
    super.key,
    required this.text,
    required this.controller,
    required this.size,
    required this.icon,
    this.maxLines,
    this.keyboard,
  });

  final Widget text;
  final Widget icon;
  final TextEditingController controller;
  final double size;
  final Color color = FarmSwapGreen.darkGreen;
  final int? maxLines;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.black,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontSize: size,
        decoration: TextDecoration.none,
      ),
      keyboardType: keyboard,
      cursorColor: normalGreen,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        filled: true,
        fillColor: Colors.white,
        label: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.50, color: farmSwapSmoothGreen),
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
        prefixIcon: icon,
      ),
    );
  }
}
