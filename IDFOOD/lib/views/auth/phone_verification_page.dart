import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/phone_verification_controller.dart';
import 'package:idfood/services/verification_service.dart';
import 'package:phone_otp_verification/phone_verification.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {

  final VerificationServices _verificationServices=VerificationServices();

  String _verificationId = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneVerificationController());

    return Obx(() => controller.isLoading==false ? PhoneVerification(
      isFirstPage: false,
      enableLogo: true,
      logoPath:"assets/images/food.png",
      themeColor: Colors.blueAccent,
      backgroundColor: kLightWhite,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
      textColor: kDark,
      onSend: (String value) {
        controller.setPhoneNumber=value;
        //log('Phone number verification page: $value');
        _verifyPhoneNumber(value);
      },
      onVerification: (String value) {
        _submitVerificationService(value);
        log('OTP: $value');
      },
      ): Container(
       color:  kLightWhite,
        width: width,
        height: height,
        child: const Center(child: CircularProgressIndicator(),
            ),
      )
    );
  }
  void _verifyPhoneNumber(String phoneNumber) async{
    final controller = Get.put(PhoneVerificationController());

    await _verificationServices.verifyPhoneNumber(controller.phone,
        codeSent:(String verificationId, int? resendToken) {
      setState(() {
        _verificationId = verificationId;
      });
        });
  }

  void _submitVerificationService(String code) async {
    await _verificationServices.verifySmsCode(_verificationId, code);
  }
}

//https://pub.dev/packages/phone_otp_verification/install

//EQiMgiZCorSfTwRDxQHepkwGIC53
