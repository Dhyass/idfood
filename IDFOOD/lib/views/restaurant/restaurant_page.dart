// ignore_for_file: prefer_final_fields


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';
import 'package:idfood/views/restaurant/widget/directions_page.dart';
import 'package:idfood/views/restaurant/widget/restaurant_menu.dart';
import 'package:idfood/views/restaurant/widget/xplore_widget.dart';

import 'widget/restaurant_bottom_bar.dart';
import 'widget/row_text.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    // Uncomment this line if you want to log restaurant information when the widget is initialized
    // logRestaurantInfo();
  }

  /* void logRestaurantInfo() {
    if (widget.restaurant != null) {
      final restaurant = widget.restaurant!;

      // Display all restaurant information using log
      log('ID: ${restaurant.id}');
      log('Title: ${restaurant.title}');
      log('Delivery Time: ${restaurant.time}');
      log('Image URL: ${restaurant.imageUrl}');
      log('Foods: ${restaurant.foods}');
      log('Pickup: ${restaurant.pickup}');
      log('Delivery: ${restaurant.delivery}');
      log('Available: ${restaurant.isAvailable}');
      log('Owner: ${restaurant.owner}');
      log('Code: ${restaurant.code}');
      log('Logo URL: ${restaurant.logoUrl}');
      log('Rating: ${restaurant.rating}');
      log('Rating Count: ${restaurant.ratingCount}');
      log('Verification: ${restaurant.verification}');
      log('Verification Message: ${restaurant.verificationMessage}');
      log('Coords: ${restaurant.coords}');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kLightWhite,
        body: Column(
         // padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 230.h,
                  width: width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.restaurant!.imageUrl,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: RestaurantBottomBar(widget: widget),
                ),
                Positioned(
                  top: 40.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: kLightWhite,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: CupertinoColors.systemBlue,
                              size: 28,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: kPrimary.withOpacity(0.4), //
                              borderRadius: BorderRadius.circular(2.r), //
                            ),
                            child: Text(
                              widget.restaurant!.title,
                              style: appStyle(18, kDark, FontWeight.bold),
                              maxLines:
                                  2, // Maximum number of lines before overflow
                              overflow: TextOverflow
                                  .ellipsis, // Display '...' when text overflows
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const DirectionsPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: kLightWhite,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: const Icon(
                              Ionicons.location,
                              size: 28,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  const RowText(
                    first: "Distance to restaunrant",
                    second: "2.7 km",
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const RowText(
                    first: "Estimated Price",
                    second: "\$ 2.7",
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const RowText(
                    first: "Estimated Time",
                    second: "30 min",
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const Divider(
                    thickness: 0.8,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  8.w),
              child: Container(
                height: 25.h,
                width: width,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(25.r),
                ) ,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  labelPadding: EdgeInsets.zero,
                  labelColor: kLightWhite,
                  labelStyle: appStyle(12, kLightWhite, FontWeight.w500),
                  unselectedLabelColor: kGrayLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: width/2,
                        height:25 ,
                        child: const Center(
                          child: Text("Menu"),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: width/2,
                        height:25 ,
                        child: const Center(
                          child: Text("Explore"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            Expanded(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      RestaurantMenuWidget(restaurantId: widget.restaurant!.id,),
                      ExploreWidget(code: widget.restaurant!.code,),
              
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
