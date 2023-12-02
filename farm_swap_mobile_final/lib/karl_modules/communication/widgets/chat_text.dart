import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAllDisplayUserTexts extends StatelessWidget {
  const ChatAllDisplayUserTexts({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    );
  }
}
