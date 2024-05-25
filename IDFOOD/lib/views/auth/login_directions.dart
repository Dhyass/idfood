import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/views/auth/login_page.dart';
import 'package:lottie/lottie.dart';

class LoginDirections extends StatelessWidget {
  const LoginDirections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          color: kRed,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: kLightWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.blue,
                    size: 22,
                  ),
                ),
              ),
              ReusableText(
                text: "Please login to access this page!",
                style: appStyle(16, kWhite, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: kWhite,
          containerContent: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width,
                height: height/1.8,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Lottie.asset(
                    "assets/anime/delivery.json",
                    width: width,
                    height: height / 2,
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),

                child: CustomButton(
                  onTap: () {
                    Get.to(() => const LoginPage(),
                      transition : Transition.cupertinoDialog,
                      duration : const Duration(microseconds: 900
                      ),
                    );
                  },
                  text: "L O G I N",
                  radius: 10.r,
                  color: kRed,
                  btnWidth: width-20,
                  bntHeight: 40.h,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
