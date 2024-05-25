import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:idfood/controller/phone_verification_controller.dart';

class VerificationServices{
  final controller = Get.put(PhoneVerificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future <void> verifyPhoneNumber(
      String phoneNumber,
  {required Null Function(String verificationId, int? resendToken) codeSent}

      ) async{
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credentials) async{
          controller.verifyPhoneFunction();
        },
        verificationFailed: (FirebaseAuthException e){
          debugPrint(e.message);
        },
        //timeout: const Duration(seconds: 90),

        codeSent: (String verificationId, int? resendToken){
          codeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId){
        },
    );

  }

  Future <void> verifySmsCode(String verificationId , String smsCode) async{
    PhoneAuthCredential credential  = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await _auth.signInWithCredential(credential).then((value) {
      controller.verifyPhoneFunction();
    });


  }

}