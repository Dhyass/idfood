import 'package:flutter/cupertino.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class RowText extends StatelessWidget {
  const RowText({super.key, required this.first, required this.second});
  final String first;
  final String second;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(
          text: first,
          style: appStyle(13, kGray, FontWeight.w500),
        ),
        ReusableText(
          text: second,
          style: appStyle(13, kGray, FontWeight.w500),
        )
      ],
    );
  }
}
