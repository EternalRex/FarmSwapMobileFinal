import 'dart:ui';

import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingTxtField extends StatelessWidget {
  const RatingTxtField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final Widget label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: lightGreenHover,
        ),
      ),
      child: SizedBox(
        width: 300,
        child: TextField(
          maxLines: 10,
          onChanged: onChanged,
          controller: controller,
          textCapitalization: TextCapitalization.words,
          cursorColor: normalGreen,
          keyboardType: TextInputType.text,
          selectionHeightStyle: BoxHeightStyle.includeLineSpacingBottom,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            filled: true,
            fillColor: Colors.white,
            label: label,
            labelStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFF3B3B3B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.50,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.50, color: Colors.black),
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
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
