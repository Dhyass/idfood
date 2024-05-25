import 'dart:developer';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/models/hooks_models/hook_result.dart';

FetchHook useFetchAllFoods(List<String> codes) {
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      List<FoodsModel> allFoods = [];

      for (String code in codes) {
        Uri url = Uri.parse('$appBaseUrl/api/foods/byCode/$code');
        final response = await http.get(url);
        //log('Response Status Code for $code: ${response.statusCode}');

        if (response.statusCode == 200) {
          List<FoodsModel> foodsForCode = foodsModelFromJson(response.body);
          allFoods.addAll(foodsForCode);
        } else {
          final apiError = apiErrorFromJson(response.body);
          throw Exception(apiError.message); // Throw an exception for non-200 responses
        }
      }

      foods.value = allFoods;
      error.value = null; // Resetting error if successful
    } catch (e) {
      error.value = Exception('Error fetching data: $e');
      log('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    error.value = null; // Reset error before refetching
    fetchData();
  }

  return FetchHook(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
