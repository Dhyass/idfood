// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/verification_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());
    return Scaffold(
      backgroundColor: kRed,
      appBar: AppBar(
        title: ReusableText(
            text: "Please Verify your account",
            style: appStyle(14, kWhite, FontWeight.w600)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kRed,
      ),
      body: CustomContainer(
        color: kWhite,
        containerContent: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SizedBox(
            height: height,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Lottie.asset("assets/anime/delivery.json"),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: ReusableText(
                      text: "Verify your account",
                      style: appStyle(24, kPrimary, FontWeight.w600)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Text(
                    "Enter the 6-digit code sent to your email, if you don't see the code, please check your spam",
                    style: appStyle(12, kGray, FontWeight.normal),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: kPrimary,
                  fieldHeight: 50.h,
                  fieldWidth: 50.w,
                  //showFieldAsBox: true,
                  borderWidth: 3.w,
                  textStyle: appStyle(17, Colors.blue, FontWeight.w600),
                  onCodeChanged: (String code) {},
                  mainAxisAlignment: MainAxisAlignment.center,
                  onSubmit: (String verificationCode) {
                    print(verificationCode);
                    controller.setCode =verificationCode;
                  }, // end onSubmit
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onTap: () {
                    // Get.to(()=>const MainScreen());
                    controller.verificationFunction();
                  },
                  text: "V E R I F Y   A C C O U N T",
                  radius: 10.r,
                  color: kRed,
                  btnWidth: width,
                  bntHeight: 35.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
