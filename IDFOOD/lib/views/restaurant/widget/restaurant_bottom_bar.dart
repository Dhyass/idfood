import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/views/restaurant/rating_page.dart';
import 'package:idfood/views/restaurant/restaurant_page.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.widget,
  }) ;

  final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: width,
      height: 40.h,
      decoration: BoxDecoration(
        color: kPrimary.withOpacity(0.4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBarIndicator(
            itemCount: 5,
            rating: widget.restaurant?.rating.toDouble() ?? 0.0,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
          CustomButton(
            onTap: () {
              Get.to(() => const RatingPage());
            },
            color: kSecondary,
            btnWidth: width / 3,
            text: "Rate Restaurant",
          ),
        ],
      ),
    );
  }
}
