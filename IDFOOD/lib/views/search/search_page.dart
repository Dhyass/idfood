
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/customer_text_field.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/search_controller.dart';
import 'package:idfood/views/search/loading_widget.dart';
import 'package:idfood/views/search/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
/*
class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());
    return Obx(()=>Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        toolbarHeight: 110.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade100,
        title: Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 18.h, left: 6.w),
          child: CustomerTextWidget(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: "Search For Foods",
              suffixIcon: GestureDetector(
                onTap: () {
                  if(controller.isTriggered==true){
                    controller.searchFoods(_searchController.text);
                    controller.isTriggered==false;
                  }else{
                    controller.searchResults=null;
                    controller.isTriggered==true;
                    _searchController.clear();
                  }

                },
                child: controller.isTriggered==true
                    ?Icon(Ionicons.search_circle, size: 40.h, color: kPrimary)
                    :Icon(Ionicons.close_circle, size: 40.h, color: kRed),
              )
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: Colors.white,
          containerContent: controller.isLoading
              ?const FoodsListShimmer()
              : controller.searchResults== null? const LoadingWidget()
              : const SearchResults(),
        ),
      ),
    )
    );
  }
}
*/
class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());

    return Obx(() => Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        toolbarHeight: 110.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade100,
        title: Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 18.h, left: 6.w),
          child: CustomerTextWidget(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: "Search For Foods",
            suffixIcon: GestureDetector(
              onTap: () {
                if (controller.isTriggered == false) {
                  controller.searchFoods(_searchController.text);
                  controller.isTriggered == true;
                } else {
                  controller.searchResults = null;
                  controller.isTriggered == false;
                  _searchController.clear();
                }
                // In either case, toggle isTriggered
                controller.isTriggered = !controller.isTriggered;
              },
              child: controller.isTriggered == true
                  ? Icon(
                Ionicons.close_circle,
                size: 40.h,
                color: kRed,
              )
                  : Icon(
                Ionicons.search_circle,
                size: 40.h,
                color: kPrimary,

              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: Colors.white,
          containerContent: controller.isLoading
              ? const FoodsListShimmer()
              : controller.searchResults == null
              ? const LoadingWidget()
              : const SearchResults(),
        ),
      ),
    ));
  }
}
