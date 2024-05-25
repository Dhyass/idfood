
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    this.onTap,
    this.btnWidth,
    this.bntHeight,
    this.color,
    this.radius, required this.text}) ;

  final void Function()? onTap;
  final double? btnWidth;
  final double? bntHeight;
  final Color? color;
  final double? radius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width, // Use double.infinity as a default width
        height: bntHeight ?? 28.h, // Use 28.h as a default height
        decoration: BoxDecoration(
          color: color??Colors.blue, // Example background color
          borderRadius: BorderRadius.circular(radius?? 9.r), // Example border radius
        ),
        child: Center(
            child: ReusableText(
              text: text,
              style: appStyle(14, kLightWhite, FontWeight.w500),)),
        // Add child widget here if needed
      ),
    );
  }
}
