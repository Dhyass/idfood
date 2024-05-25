// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/fetch_all_categories.dart';
import 'package:idfood/models/hooks_models/categories.dart';
import 'package:idfood/views/categories/widget/category_listtitle.dart';

class AllCategories extends HookWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllCategories();
    List<CategoryModel>? categories = hookResults.data;
    final isLoading = hookResults.isLoading;
    final error = hookResults.error;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kRed,
        title: ReusableText(
          text: "All categories",
          style: appStyle(20, kOffWhite, FontWeight.bold),
        ),
      ),
      body: BackGroundContainer(
        color: kOffWhite,
        child: Container(
          height: height,
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          child: isLoading
              ? const FoodsListShimmer()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    categories!.length,
                    (index) {
                      CategoryModel category = categories[index];
                      return CategoryListTile(category: category);
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
