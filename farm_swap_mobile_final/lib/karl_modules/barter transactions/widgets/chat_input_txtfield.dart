import "package:farm_swap_mobile_final/common/colors.dart";
import "package:flutter/material.dart";

class ChatInputTxtField extends StatelessWidget {
  const ChatInputTxtField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: farmSwapTitlegreen),
        ),
      ),
    );
  }
}
