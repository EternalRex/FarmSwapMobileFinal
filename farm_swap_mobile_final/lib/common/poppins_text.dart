import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

Text poppinsText(String text, Color color, double size, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: weight,
    ),
  );
}
