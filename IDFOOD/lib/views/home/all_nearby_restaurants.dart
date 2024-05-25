
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/fetch_all_restaurants.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';
import 'package:idfood/views/home/widgets/restaurant_tile.dart';

class AllNearbyRestaurants extends HookWidget {
  const AllNearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllRestaurants("41007428");
    List<RestaurantModel>?restaurants = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        backgroundColor: kRed,
        appBar: AppBar(
          backgroundColor: kRed,
          elevation: 0,
          title: ReusableText(
            text: "Nearby Restaurants",
            style:appStyle(20, kOffWhite, FontWeight.w600) ,
          ),

      ),
      body: SingleChildScrollView(
          child: isLoading
              ? const FoodsListShimmer()
              :BackGroundContainer(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                  child:  SingleChildScrollView(
                    child: Column(
                    // scrollDirection: Axis.vertical,
                      children: List.generate (restaurants!.length, (index){
                        RestaurantModel restaurant = restaurants[index];
                        return RestaurantTile(restaurant: restaurant);
                      },
                      ),
                                  ),
                  ),
            )
        ),
      )
    );
  }
}
