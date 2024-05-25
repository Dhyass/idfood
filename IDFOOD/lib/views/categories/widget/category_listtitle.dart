// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/category_controller.dart';
import 'package:idfood/models/hooks_models/categories.dart';
import 'package:idfood/views/categories/category_page.dart';

class CategoryListTile extends StatelessWidget {
  // final Map<String, dynamic> category;
  final controller = Get.put(CategoryController());
  CategoryListTile({super.key, required this.category});

  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        controller.updateCategory = category.id;
        controller.updateTitle = category.title;
        Get.to(
          () => const CategoryPage(),
          transition: Transition.fadeIn,
          duration: const Duration(microseconds: 900),
        );
      },
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child: Image.network(
          category.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
      title: ReusableText(
        text: category.title,
        style: appStyle(16, kGray, FontWeight.bold),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: kDark,
        size: 15.r,
      ),
    );
  }
}
