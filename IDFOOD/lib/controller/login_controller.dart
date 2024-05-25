
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';
import 'package:idfood/views/auth/widget/verification_page.dart';
import 'package:idfood/views/entrypoint.dart';

class LoginController extends GetxController{

  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState){
    _isLoading.value = newState;
  }

  void loginFunction(String data) async {
    setLoading = true;

    Uri url= Uri.parse("$appBaseUrl/login");
    Map<String, String> headers = {'Content-Type': 'application/json'};
   // print("url : $url");
    try{
      var response = await http.post(
          url,
          headers: headers,
          body: data
      );
      //print("response statusCode : ${response.statusCode}");
      if (response.statusCode==200){
        LoginResponseModel data =loginResponseModelFromJson(response.body);

        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData );
        box.write("token", data.userToken);
        box.write("userId", data.id);
        box.write("verification", data.verification);

        setLoading= false;

        Get.snackbar("You are successfully logged in", "Enjoy your awesome expertise",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );

        if(data.verification==false){
          Get.offAll(()=> const VerificationPage(),
              transition: Transition.fade,
              duration:  const Duration(milliseconds: 900)
          );
        }

        if(data.verification==true){
          Get.offAll(()=> const MainScreen(),
              transition: Transition.fade,
              duration:  const Duration(milliseconds: 900)
          );
        }



      }else {
        var error = apiErrorFromJson(response.body);

        Get.snackbar("Failed to login", error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(MaterialIcons.error_outline),
        );

      }
    }catch(error){
      print(error.toString() );
    }

  }

  void logout(){
    box.erase();
    Get.offAll(()=> const MainScreen(),
        transition: Transition.fade,
        duration:  const Duration(milliseconds: 900)
    );
  }

   LoginResponseModel? getUserInfo(){
    String? userId=box.read("userId");
    String? data;

    if(userId!=null){
     data = box.read(userId.toString());
    }

    if(data!=null){
      return loginResponseModelFromJson(data);
    }
    return null;
  }
}