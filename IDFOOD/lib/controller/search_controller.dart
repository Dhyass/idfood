// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:get/get.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:http/http.dart' as http;

class SearchFoodController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<FoodsModel>? searchResults;

  final RxBool _isTriggered = false.obs;

  bool get isTriggered => _isTriggered.value;
  set isTriggered(bool value) => _isTriggered.value = value;

  Future<void> searchFoods(String key) async {
    _isLoading.value = true;
    _isTriggered.value = false;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/foods/search/$key');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        searchResults = foodsModelFromJson(response.body);
      } else {
        var error = apiErrorFromJson(response.body);
        // Handle error response from API
        // You can display an error message or take appropriate action
        // For example: showSnackBar(error.message)
      }
    } catch (e) {
      log(e.toString());
      // Handle exception
      // You can display an error message or take appropriate action
      // For example: showSnackBar('An error occurred: $e')
    } finally {
      _isLoading.value = false;
      _isTriggered.value = true;
    }
  }
}
