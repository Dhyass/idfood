
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/custom_appbar.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/heading.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/category_controller.dart';
import 'package:idfood/views/home/all_fastest_foods.dart';
import 'package:idfood/views/home/all_nearby_restaurants.dart';
import 'package:idfood/views/home/recommandations.dart';
import 'package:idfood/views/home/widgets/category_foods_list.dart';
import 'package:idfood/views/home/widgets/category_list.dart';
import 'package:idfood/views/home/widgets/foods_list.dart';
import 'package:idfood/views/home/widgets/nearby_restaurants_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: kRed,
      appBar: PreferredSize(preferredSize: Size.fromHeight(140.h),
          child: const CustomAppBar(),
      ),
      body: SafeArea(
          child: CustomContainer(containerContent: Column(
            children: [
              const CategoryList(),

              Obx(() =>   controller.categoryValue=="" ?
                  Column(
                children: [
                  Heading(
                      text: 'Try Somethings new',
                      onTap :() {
                        Get.to(()=>const Recommendations(),
                            transition : Transition.cupertino,
                            duration : const Duration(microseconds: 900
                            ),
                        );
                      }
                  ),
                  const FoodsList(),
                  Heading(
                      text: 'Nearby Restaurants',
                      onTap :() {
                        Get.to(()=>const AllNearbyRestaurants(),
                            transition : Transition.cupertino,
                            duration : const Duration(microseconds: 900
                            )
                        );
                      }
                  ),
                  const NearbyRestaurants(),

                  Heading(
                      text: 'Food Closer To you',
                      onTap :() {
                        Get.to(()=>const AllFastestFoods(),
                            transition : Transition.cupertino,
                            duration : const Duration(microseconds: 900
                            )
                        );
                      }
                  ),

                  const FoodsList(),
                ],
              ):CustomContainer(
                containerContent: Column(
                  children: [
                    Heading(
                        more: true,
                        text: 'Explore ${controller.titleValue} Category',
                        onTap :() {
                          Get.to(()=>const Recommendations(),
                              transition : Transition.cupertino,
                              duration : const Duration(microseconds: 900
                              )
                          );
                        }
                    ),
                    const CategoryFoodsList(),
                  ],
                ),
              )
              )
            ],
          ))
      )
    );
  }
}