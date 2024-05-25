import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/foods_by_restaurant.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/views/home/widgets/food_tile.dart';

class RestaurantMenuWidget extends HookWidget {
  const RestaurantMenuWidget({Key? key, required this.restaurantId}) : super(key: key);
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurantFoods(restaurantId);
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kGrayLight,
      body: isLoading
          ? const FoodsListShimmer()
          : foods is List<FoodsModel> // Vérification que foods est une liste
          ? SizedBox(
            height: height * 0.7,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final FoodsModel food = foods[index]; // Utilisation de ! pour accéder à la liste
                return FoodTile(food: food);
          },
                  ),
                )
          : const Center(
        child: Text('No data available'),
      ),
    );
  }

}
