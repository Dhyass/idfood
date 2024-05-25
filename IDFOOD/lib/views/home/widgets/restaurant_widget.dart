
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({super.key,
    required this.image, required this.logo, required this.title,required this.time, required this.rating,
    this.onTap

  });

  final String image;
  final String title;
  final String logo;
  final String time;
  final String rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Padding(
        padding: EdgeInsets.only(right: 12.r),
        child: Container(
          height: 192.h ,
          width: width*.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: kLightWhite,
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height:112.h ,
                        width: width*0.8 ,
                        child: Image.network(image, fit: BoxFit.fitWidth,),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Container(
                          color: kLightWhite,
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.network(logo, fit: BoxFit.cover, width: 20.w, height: 20.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(text: title,
                      style: appStyle(12, kDark, FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(text: 'Heures de Livraison',
                          style: appStyle(9, kGray, FontWeight.w400)),

                      ReusableText(text: time,
                          style: appStyle(9, kSecondary, FontWeight.w400)),
                    ],
                  ),

                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: double.parse(rating), // Convert rating to double
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color:Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.h,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 10.w),
                      ReusableText(text: "+ $rating reviews and ratings",
                          style: appStyle(9, kGray, FontWeight.w500)),
                    ],
                  )

                ],

              ),

            )
            ],
          ),
        ),
      ),
    )
    ;
  }
}
