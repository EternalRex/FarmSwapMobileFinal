import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

class UpdateTextfield extends StatelessWidget {
  const UpdateTextfield(
      {super.key,
      required this.label,
      required this.textType,
      required this.updateControllerField});

  final Widget label;
  final bool textType;
  final TextEditingController updateControllerField;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: updateControllerField,
      obscureText: textType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: label,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14.sp,
          letterSpacing: 0.5,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
      ),
    );
  }
}
