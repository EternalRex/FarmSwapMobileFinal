import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class PicturePicker extends StatelessWidget {
  const PicturePicker({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.title,
  });

  final double height;
  final double width;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.158,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        shadows: [
          BoxShadow(
            color: shadow,
            blurRadius: 50,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
          ),
          SizedBox(height: height * 0.024),
          poppinsText(title, Colors.black, 14, FontWeight.w200),
        ],
      ),
    );
  }
}
