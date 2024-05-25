import 'dart:developer';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/hook_result.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';

FetchHook useFetchRestaurants(String code) {
  final restaurants= useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/$code');
      final response = await http.get(url);
      //log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        restaurants.value =  restaurantModelFromJson(response.body);
        error.value = null; // Resetting error if successful
      } else {
        final apiError = apiErrorFromJson(response.body);
        throw Exception(apiError.message); // Throw an exception for non-200 responses
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
  }, []);

  void refetch() {
    error.value = null; // Reset error before refetching
    fetchData();
  }

  return FetchHook(
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
