import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/cart_response_model.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/models/hooks_models/hook_result.dart';


FetchHook useFetchCart() {
  final box = GetStorage();

  final cartItems = useState<List<CartResponseModel>?>([]);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {

    String accessToken = box.read("token");


    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/cart');
      final response = await http.get(url, headers: headers);
     // log('cart fetch: ${response.statusCode}');
     // log('cart fetch body: ${response.body}');
      //log('url: $url');

      if (response.statusCode == 200) {
        final products = cartResponseModelFromJson(response.body);
        cartItems.value = products;
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
    isLoading.value=true;
    fetchData();
  }

  return FetchHook(
    data: cartItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
