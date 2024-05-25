import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/cart_response_model.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';

import '../../../common/cart_controller.dart';


class CartTile extends StatelessWidget {
  const CartTile({Key? key, this.color, required this.cart, this.refetch}) : super(key: key);

  final CartResponseModel cart;
  final Color? color;
  final Function() ? refetch;


  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        //Get.to(() => FoodPage(food : food));
      }, // Redirect to restaurant page

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          height: 74.h, // Adjust height as needed
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color?? kOffWhite,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 70.w,
                            height: 70.h,
                            child: Image.network(
                              cart.productId.imageUrl[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                              height: 16.h,
                              width: 150.w, // Adjust width as needed
                              child: RatingBarIndicator(
                                rating: 5,
                                itemCount: 5,
                                itemBuilder: (context, index) =>
                                const Icon(
                                  Icons.star,
                                  color: kSecondary,
                                ),
                                itemSize: 15.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: cart.productId.title,
                          style: appStyle(11, kDark, FontWeight.w400),
                        ),
                        /*
                        ReusableText(
                          text: "Delivery Time : ${cart.time}",
                          style: appStyle(11, kDark, FontWeight.w400),
                        ),
                        */
                        SizedBox(
                          width: 150.w, // Adjust width as needed
                          height: 16.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cart.additives.length,
                            itemBuilder: (context, index) {
                              var additive = cart.additives[index];
                              return Container(
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(9.r),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: ReusableText(
                                      text: additive,
                                      style: appStyle(
                                        8,
                                        kGray,
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 5.w,
                top: 6.h,
                child: Container(
                  width: 60.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: ReusableText(
                      text: "\$${cart.totalPrice.toStringAsFixed(2)}",
                      style: appStyle(12, kLightWhite, FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 70.w,
                top: 6.h,
                child: GestureDetector(
                  onTap: () {
                    cartController.removeFromCart(cart.id, refetch! );
                  },
                  child: Container(
                    width: 19.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Icon(
                        MaterialCommunityIcons.trash_can_outline,
                        size: 15.h,
                        color: kLightWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
