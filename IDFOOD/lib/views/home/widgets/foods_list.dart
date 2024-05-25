import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/shimmers/nearby_shimmer.dart';
import 'package:idfood/hooks/fetch_foods.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/views/food/food_page.dart';
import 'package:idfood/views/home/widgets/foods_widget.dart';

class FoodsList extends HookWidget {
  const FoodsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods("41007428");
    List<FoodsModel> foods = hookResults.data ?? []; // Null check and provide default value
    final isLoading = hookResults.isLoading;

    return isLoading
        ? const NearbyShimmer()
        : Container(
      height: 184.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(foods.length, (index) {
          FoodsModel food = foods[index];
          return FoodWidget(
            onTap: () {
              Get.to(() => FoodPage(food: food));
            },
            image: food.imageUrl[0],
            title: food.title,
            time: food.time,
            price: food.price.toStringAsFixed(2),
          );
        }),
      ),
    );
  }
}
