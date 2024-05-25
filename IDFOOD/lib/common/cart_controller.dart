import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  final box = GetStorage();
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> addToCart(String cart) async {
    setLoading = true;

    String? accessToken = box.read("token");

    if (accessToken == null) {
      setLoading = false;
      return;
    }

    var url = Uri.parse("$appBaseUrl/api/cart");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers, body: cart);

      debugPrint("response code cart controller : ${response.statusCode}");

      if (response.statusCode == 200) {
        setLoading = false;

        Get.snackbar(
          "Added to cart",
          "Enjoy your awesome expertise",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(
            Icons.check_circle_outline,
            color: kLightWhite,
          ),
        );
        //Get.offAll(()=>const MainScreen());
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Error",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(
            Icons.error_outline,
            color: kLightWhite,
          ),
        );
      }
    } catch (e) {
      debugPrint("catch error : ${e.toString()}");
      Get.snackbar(
        "Error",
        "Failed to add to cart",
        colorText: kLightWhite,
        backgroundColor: kRed,
        icon: const Icon(
          Icons.error_outline,
          color: kLightWhite,
        ),
      );
    } finally {
      setLoading = false;
    }
  }

  Future<void> removeFromCart(String productId,  Function() refetch) async {
    setLoading = true;

    String? accessToken = box.read("token");

    if (accessToken == null) {
      setLoading = false;
      return;
    }

    var url = Uri.parse("$appBaseUrl/api/cart/$productId");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        setLoading = false;
        refetch();

        Get.snackbar(
          "Product removed successfully",
          "Enjoy your awesome expertise",
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(
            Icons.check_circle_outline,
            color: kLightWhite,
          ),
        );
        //Get.offAll(()=>const MainScreen());
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Error",
          error.message,
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(
            Icons.error_outline,
            color: kLightWhite,
          ),
        );
      }
    } catch (e) {
      debugPrint("catch error : ${e.toString()}");
      Get.snackbar(
        "Error",
        "Failed to remove product",
        colorText: kLightWhite,
        backgroundColor: kRed,
        icon: const Icon(
          Icons.error_outline,
          color: kLightWhite,
        ),
      );
    } finally {
      setLoading = false;
    }
  }
}
