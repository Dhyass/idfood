
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({super.key, required this.image, required this.title, required this.time, required this.price, this.onTap});

  final String image; // food image
  final String title; // food name
  final String time; // time it took for cooking the dish
  final String price; // food price
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Padding(
        padding: EdgeInsets.only(right: 12.r),
        child: Container(
          height: 184.h ,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    height:112.h ,
                    width: width*0.8 ,
                    child: Image.network(image, fit: BoxFit.fitWidth,),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: title,
                            style: appStyle(12, kDark, FontWeight.w500)),

                        ReusableText(text: "\$ $price",
                            style: appStyle(12, Colors.blue, FontWeight.w500)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: 'Heures de Livraison',
                            style: appStyle(10, kGray, FontWeight.w400)),

                        ReusableText(text: time,
                            style: appStyle(10, kSecondary, FontWeight.w400)),
                      ],
                    ),

                  ],

                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
