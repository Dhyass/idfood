// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/views/entrypoint.dart';

class VerificationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String _code ="";
  //146244: otp
  //fati2021lome@gmail.com
  //password127
  String get code => _code;
  set setCode(String value){
    _code=value;
  }

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void verificationFunction() async {
    setLoading = true;
    String accessToken = box.read('token');

    Uri url = Uri.parse("$appBaseUrl/api/users/verify/$code");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    // print("url : $url");
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      //print("response statusCode : ${response.statusCode}");
      if (response.statusCode == 200) {
        LoginResponseModel data = loginResponseModelFromJson(response.body);

        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData);
        box.write("token", data.userToken);
        box.write("userId", data.id);
        box.write("verification", data.verification);

        setLoading = false;

        Get.snackbar(
          "You are successfully Verified",
          "Enjoy your awesome expertise",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
        Get.offAll(()=>const MainScreen());
      } else {
        var error = apiErrorFromJson(response.body);

        Get.snackbar(
          "Failed to Verify",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(MaterialIcons.error_outline),
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
