import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/fetch_all_foods.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/views/home/widgets/food_tile.dart';

class Recommendations extends HookWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllFoods(["41007428", "47896"]);
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      backgroundColor: kRed,
      appBar: AppBar(
        backgroundColor: kRed,
        elevation: 0,
        title: ReusableText(
          text: "Recommendations",
          style: appStyle(20, kOffWhite, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: isLoading
                ? const FoodsListShimmer()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                foods!.length,
                    (index) {
                  FoodsModel food = foods[index];
                  return FoodTile(food: food);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
