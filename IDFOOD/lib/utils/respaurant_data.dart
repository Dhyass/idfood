// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/foods_hook.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';

FetchFoods useFetchRestaurantTESTFoods(String id) {
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/foods/restaurant_foods/$id');
      final response = await http.get(url);
      //  log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        foods.value = foodsModelFromJson(response.body);
        error.value = null; // Resetting error if successful
      } else {
        final apiError = apiErrorFromJson(response.body);
        throw Exception(
            apiError.message); // Throw an exception for non-200 responses
      }
    } catch (e) {
      error.value = Exception('Error fetching data: $e');
      log('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    error.value = null; // Reset error before refetching
    isLoading.value = true;
    fetchData();
  }

  return FetchFoods(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
