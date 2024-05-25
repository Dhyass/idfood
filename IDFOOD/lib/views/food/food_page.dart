// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/cart_controller.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/customer_text_field.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/food_controller.dart';
import 'package:idfood/controller/login_controller.dart';
import 'package:idfood/hooks/fetch_restaurant.dart';
import 'package:idfood/models/cart_request_model.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';
import 'package:idfood/views/auth/login_page.dart';
import 'package:idfood/views/auth/phone_verification_page.dart';
import 'package:idfood/views/orders/order_parge.dart';
import 'package:idfood/views/restaurant/restaurant_page.dart';

import '../../models/hooks_models/order_request_model.dart';

class FoodPage extends StatefulHookWidget {
  FoodPage({Key? key, required this.food}) : super(key: key);

  final FoodsModel food;
  final TextEditingController _preferences = TextEditingController();
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final TextEditingController _preferences = TextEditingController();
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurant(widget.food.restaurant);
    RestaurantModel? restaurant = hookResult.data;
    final controller = Get.put(FoodController());
    controller.loadAdditives(widget.food.additives);

    final cartController = Get.put(CartController());

    LoginResponseModel? user;
    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();



    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              //physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 230.h,
                        child: PageView.builder(
                          controller: PageController(),
                          onPageChanged: (index) {
                            controller.changePage(index);
                          },
                          itemCount: widget.food.imageUrl.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 230.h,
                              color: kLightWhite,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.food.imageUrl[index],
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.food.imageUrl.length,
                                (index) {
                                  return Container(
                                    margin: EdgeInsets.all(6.h),
                                    width: 14.w,
                                    height: 14.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          controller.currentPage.value == index
                                              ? Colors.white
                                              : kGray,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 12.w,
                        child: GestureDetector(
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
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 12.w,
                        child: CustomButton(
                          onTap: () {
                            // log(hookResult.data as num);
                            Get.to(() => RestaurantPage(
                                  restaurant: hookResult.data,
                                ));
                          },
                          btnWidth: 140.w,
                          text: "Visite Restaurant",
                          color: kSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                              text: widget.food.title,
                              style: appStyle(18, kDark, FontWeight.w600),
                            ),
                            Obx(
                              () => ReusableText(
                                text:
                                    "\$${((widget.food.price + controller.additivePrice) * controller.count.value).toStringAsFixed(2)}",
                                style: appStyle(18, kGray, FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          widget.food.description,
                          textAlign: TextAlign.justify,
                          style: appStyle(14, kGray, FontWeight.w400),
                          maxLines: 8,
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 20.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(widget.food.foodTags.length,
                                (index) {
                              final tag = widget.food.foodTags[index];
                              return Container(
                                height: 30,
                                width: 50.w,
                                margin: EdgeInsets.only(right: 5.w, bottom: 4),
                                decoration: BoxDecoration(
                                  color: kPrimary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.r)),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.w),
                                  child: ReusableText(
                                    text: tag,
                                    style:
                                        appStyle(11, kWhite, FontWeight.w600),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ReusableText(
                          text: "Additives And Toppings",
                          style: appStyle(18, kDark, FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => Column(
                            children: List.generate(
                                controller.additivesList.length, (index) {
                              final additive = controller.additivesList[index];

                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                activeColor: kSecondary,
                                tristate: false,
                                value: additive.isChecked
                                    .value, // Valeur de la case à cocher, à remplacer par une valeur réelle
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: additive.title,
                                      style:
                                          appStyle(12, kDark, FontWeight.w600),
                                    ),
                                    SizedBox(width: 5.w),
                                    ReusableText(
                                      text: "\$ ${additive.price}",
                                      style:
                                          appStyle(12, kGray, FontWeight.w400),
                                    ),
                                  ],
                                ),

                                onChanged: (bool? value) {
                                  additive.toggleChecked();
                                  controller.getTotalPrice();
                                  controller.getCartAdditive();
                                  //print("get cart result : ${controller.getCartAdditive()}");
                                },
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ReusableText(
                          text: "Preferences",
                          style: appStyle(18, kDark, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 60.h,
                          child: CustomerTextWidget(
                            controller: widget._preferences,
                            maxLines: 2,
                            hintText: "Add a note with your preferences",
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: "Quantity",
                          style: appStyle(
                            18,
                            kDark,
                            FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.increment();
                              },
                              child: const Icon(AntDesign.pluscircleo),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Obx(
                                  () => ReusableText(
                                      text: "${controller.count.value}",
                                      style:
                                          appStyle(14, kDark, FontWeight.w600)),
                                )),
                            GestureDetector(
                              onTap: () {
                                controller.decrement();
                              },
                              child: const Icon(
                                AntDesign.minuscircleo,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (user==null){ // if null go to login page
                              Get.to(()=> const LoginPage());
                            }else if(user.phoneVerification==false){
                              showVerificationSheet(context);
                            } else {
                              double price =(widget.food.price
                                  + controller.additivePrice)
                                  *controller.count.value;
                              OrderItem item = OrderItem(
                                  foodId: widget.food.id,
                                  quantity: controller.count.value,
                                  price: price,
                                  additives: controller.getCartAdditive(),
                                  instructions: _preferences.text );
                              // create orderItem
                              Get.to(()=> OrderPage(restaurant: restaurant, food: widget.food, item: item,),
                              transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 900),
                              );
                            }

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ReusableText(
                              text: "Place Order",
                              style: appStyle(18, kLightWhite, FontWeight.w600),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            double price =(widget.food.price
                                + controller.additivePrice)
                                *controller.count.value;
                            var data = CartRequestModel(
                                productId: widget.food.id,
                                additives: controller.getCartAdditive(),
                                quantity: controller.count.value,
                                totalPrice: price,
                            );
                            String cart = cartRequestModelToJson(data);
                            cartController.addToCart(cart);
                            //Get.to(() =>const CartPage());
                          },
                          child: CircleAvatar(
                            backgroundColor: kSecondary,
                            radius: 20.r,
                            child: const Icon(
                              Ionicons.cart,
                              color: kLightWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: 500.h,
          width: width,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/food.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma(),
              opacity: 0.1,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              topLeft: Radius.circular(12.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                ReusableText(
                  text: "Verify Your Phone Number",
                  style: appStyle(20, kDark, FontWeight.w600),
                ),
                SizedBox(height: 5.h),
                const Divider(thickness: 2, color: Colors.black),
                SizedBox(height: 5.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: verificationReasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(
                          verificationReasons[index],
                          textAlign: TextAlign.justify,
                          style: appStyle(13, kGray, FontWeight.normal),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  text: "Verify Phone Number",
                  bntHeight: 35.h,
                  color: kSecondary,
                  onTap: () {
                    Get.to(() => const PhoneVerificationPage());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
