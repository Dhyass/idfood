import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/addresses.dart';
import 'package:idfood/models/hooks_models/addresses_response_model.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;


FetchAddresses useFetchAddresses() {
  final box = GetStorage();

  final addressesItems = useState<List<AddressResponseModel>?>(null);
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
      Uri url = Uri.parse('$appBaseUrl/api/address/all');
      final response = await http.get(url, headers: headers);
      //log('Response Status Code: ${response.statusCode}');
     // log('Response body: ${response.body}');
      //log('url: $url');

      if (response.statusCode == 200) {
        final addresses = addressResponseModelFromJson(response.body);
        addressesItems.value = addresses;
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

  return FetchAddresses(
    data: addressesItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
