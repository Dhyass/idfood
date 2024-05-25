import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/constants/constants.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({Key? key, required this.child, this.color = kPrimary, this.image, this.opacity})
      : super(key: key);

  final Widget child;
  final Color color;
  final String? image;
  final double ? opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        image: DecorationImage(
          image: AssetImage(image ??"assets/images/foufou.png"),
          fit: BoxFit.cover,
          //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.srcOver),
          opacity: opacity ?? 0.2,
        ),
      ),
      child: child,
    );
  }
}
