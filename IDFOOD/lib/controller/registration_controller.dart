import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/success_model.dart';

class RegistrationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  Future<void> registrationFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/register");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    print("url : $url");

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      print("response statusCode : ${response.statusCode}");

      if (response.statusCode == 201) {
        var successData = successModelFromJson(response.body);
        setLoading = false;
        Get.back();
        Get.snackbar(
          "Registration Successful",
          successData.message,
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      } else {
         var errorData = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to Register",
          errorData.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(MaterialIcons.error_outline),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to connect to server",
        colorText: kLightWhite,
        backgroundColor: kRed,
        icon: const Icon(MaterialIcons.error_outline),
      );
    } finally {
      setLoading = false;
    }
  }
}
