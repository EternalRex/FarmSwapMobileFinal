import 'package:flutter/material.dart';

class DashBoardTxt extends StatelessWidget {
  const DashBoardTxt({
    super.key,
    required this.myText,
    required this.myColor,
    required this.mySize,
    required this.myFont,
    required this.myWeight,
  });

  final String myText;
  final Color myColor;
  final double mySize;
  final String? myFont;
  final FontWeight myWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      myText,
      style: TextStyle(
        color: myColor,
        fontSize: mySize,
        fontFamily: myFont,
        fontWeight: myWeight,
      ),
    );
  }
}
