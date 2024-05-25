
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/fetch_gategory_food.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/views/home/widgets/food_tile.dart';

class CategoryFoodsList extends HookWidget{
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoodsByCategory("41007428"); // Pass multiple food codes here
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return SizedBox(
      width: width ,
      height: height,
      child:  isLoading
          ? const FoodsListShimmer()
          : BackGroundContainer(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: foods!.length,
                itemBuilder: (context, index) {
                  FoodsModel food = foods[index];
                  return FoodTile(
                    color: Colors.white,
                      food: food);
            },
          ),
        ),
      ),

    );
  }
}
