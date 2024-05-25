import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/shimmers/categories_shimmer.dart';
import 'package:idfood/hooks/fetch_categories.dart';
import 'package:idfood/models/hooks_models/categories.dart';
import 'package:idfood/views/home/widgets/category_widget.dart';

class CategoryList extends HookWidget {
   const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoryModel>? categoriesList =hookResult.data??[];
    final isLoading = hookResult.isLoading;
   // final error = hookResult.error;

    return  isLoading
        ? const CatergoriesShimmer()
        :Container(
        height: 80.h,
        padding: EdgeInsets.only(left: 12.w, top: 10.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categoriesList!.length,
                (index) {
              CategoryModel category = categoriesList[index];
              return Padding(
                padding: EdgeInsets.only(right: 8.w), // Adjust spacing between categories
                child: CategoryWidget(category: category),
              );
            },
          ),
        ),
      ),
    );
  }
}
