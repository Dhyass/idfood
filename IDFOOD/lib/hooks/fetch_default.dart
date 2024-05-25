import 'dart:convert';
import 'dart:developer';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/addresses_response_model.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/hook_result.dart';

FetchHook useFetchDefault() {
  final box = GetStorage();

  final addressesItems = useState<AddressResponseModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    String accessToken = box.read("token");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/address/default');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        final addresses = AddressResponseModel.fromJson(decodedData);
        addressesItems.value = addresses;
        error.value = null;
      } else {
        final apiError = apiErrorFromJson(response.body);
        throw Exception(apiError.message);
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
    error.value = null;
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: addressesItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
