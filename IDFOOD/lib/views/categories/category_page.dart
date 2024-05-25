
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/category_controller.dart';
import 'package:idfood/hooks/fetch_gategory_food.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/views/home/widgets/food_tile.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    final hookResults = useFetchFoodsByCategory("41007428"); // Pass multiple food codes here
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        leading: IconButton(
          onPressed: (){
            controller.updateCategory="";
            controller.updateTitle="";
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: kGray,
        ),
        title: ReusableText(text: "${controller.titleValue} Category",style: appStyle(18, kGrayLight, FontWeight.w600),
        ),
        backgroundColor: kOffWhite,
      ),
      body:  BackGroundContainer(
        color: kOffWhite,
        child: SizedBox(
          height: height,
          //padding: EdgeInsets.only(left: 12.w, top: 10.h),
          child: isLoading
              ?const FoodsListShimmer()
              : Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: foods!.length,
              itemBuilder: (context, index) {
                FoodsModel food = foods[index];
                return FoodTile(
                   // color: Colors.white,
                    food: food);
              },
            ),
          ),
        ),
      ),
    );
  }
}
