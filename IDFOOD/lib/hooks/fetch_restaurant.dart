import 'dart:convert';
import 'dart:developer';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/api_error.dart';
import 'package:idfood/models/hooks_models/restaurant_hook.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';

FetchRestaurant useFetchRestaurant(String code) {
  final restaurant = useState<RestaurantModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/byId/$code');
      final response = await http.get(url);
      //log('Url Status Code: $url');
     // log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var restaurantData = jsonDecode(response.body) as List;
        if (restaurantData.isNotEmpty) {
          // Prenez le premier élément de la liste
          var restaurantJson = restaurantData.first;
          restaurant.value = RestaurantModel.fromJson(restaurantJson);
          log('Restaurant value: ${restaurant.value}');
        } else {
          throw Exception('Aucun restaurant trouvé pour le code $code');
        }
        error.value = null; // Réinitialiser l'erreur en cas de succès
      } else {
        final apiError = apiErrorFromJson(response.body);
        throw Exception(apiError.message); // Lancer une exception pour les réponses non 200
      }
    } catch (e) {
      error.value = Exception('Error fetching data: $e');
     // log('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    error.value = null; // Réinitialiser l'erreur avant de recharger
    fetchData();
  }

  return FetchRestaurant(
    data: restaurant.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
