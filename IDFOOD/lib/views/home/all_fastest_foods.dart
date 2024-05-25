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

class AllFastestFoods extends HookWidget {
  const AllFastestFoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllFoods(["41007428", "47896"]); // Pass multiple food codes here
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kRed,
      appBar: AppBar(
        backgroundColor: kRed,
        elevation: 0,
        title: ReusableText(
          text: "Fastest Foods",
          style: appStyle(20, kOffWhite, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
            child: isLoading
                ? const FoodsListShimmer()
                : BackGroundContainer(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(foods!.length, (index) {
                          FoodsModel food = foods[index];
                      return FoodTile(food: food);
                    }),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
