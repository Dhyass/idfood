import 'dart:convert';
import 'dart:developer'; // Import de dart:developer

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/constants/constants.dart';
//import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/foods_hook.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';

FetchFoods useFetchRestaurantFoods(String? id) {
  final foods = useState<List<FoodsModel>?>([]); // Initialisation à null
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  // final apiError = useState<ApiError?>(null);
  // final controller = Get.put(CategoryController());

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      if (id == null) return;

      Uri url = Uri.parse('$appBaseUrl/api/foods/restaurant_foods/$id');
      final response = await http.get(url);
      //log('Response Status Code: ${response.statusCode}');
      //log('Url category code: $url');

      final dynamic jsonData = json.decode(response.body);

      //log('Url category code: $jsonData');

      if (jsonData is List) { // Vérification que les données sont sous forme de liste
        foods.value = jsonData.map((json) => FoodsModel.fromJson(json)).toList();
        error.value = null; // Resetting error if successful
      } else {
        throw Exception('Invalid data format'); // Throw an exception for invalid data format
      }
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
  }, [id]); // Ajout de id comme dépendance

  void refetch() {
    error.value = null; // Reset error before refetching
    fetchData();
  }

  return FetchFoods(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
