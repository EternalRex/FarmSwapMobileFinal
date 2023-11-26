import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class FarmSwapGreenBtn extends StatelessWidget {
  const FarmSwapGreenBtn({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 141,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF53E78B), Color(0xFF14BE77)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FarmSwapOrangeBtn extends StatelessWidget {
  const FarmSwapOrangeBtn({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 141,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 243, 215, 91),
            Color.fromARGB(255, 247, 174, 66),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
