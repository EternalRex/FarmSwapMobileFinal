import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileSearchBar extends StatelessWidget {
  const MobileSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: const Color(0xFFDA6317), height: 1.5),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),
        filled: true,
        fillColor: const Color(0xFFF9A84D).withOpacity(0.10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        hintText: 'Search',
        //prefixIcon: const Icon(Icons.search_rounded),
        //prefixIconColor: const Color(0xFFDA6317),
      ),
    );
  }
}
