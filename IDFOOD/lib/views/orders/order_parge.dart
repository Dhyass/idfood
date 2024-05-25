import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/addresses_response_model.dart';
import 'package:idfood/models/hooks_models/foods_model.dart';
import 'package:idfood/models/hooks_models/restaurant_model.dart';
import 'package:idfood/views/orders/widget/order_tile.dart';
import 'package:idfood/views/payment/payment_page.dart';
import 'package:idfood/views/restaurant/widget/row_text.dart';

import '../../hooks/fetch_default.dart';
import '../../models/distance_time.dart';
import '../../models/hooks_models/order_request_model.dart';
import '../../services/distance.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, this.restaurant, required this.food, required this.item, this.user}) : super(key: key);

  final RestaurantModel? restaurant;
  final FoodsModel food;
  final OrderItem item;
  final AddressResponseModel? user ;

  @override
  State<OrderPage> createState() => _OrderPageState();

}

class _OrderPageState extends State<OrderPage> {
  double? distance;
  double? deliveryPrice;
  //final hookResult = useFetchDefault();


  @override
  void initState() {
    super.initState();
    calculateDistance();
  }

  void calculateDistance() {
    double userLat = 34.00787856011395; //
    double userLon = -6.8473722332201925; //

    Distance distanceCalculator = Distance();
    DistanceTime distanceTime = distanceCalculator.calculateDistanceTimePrice(
      userLat,
      userLon,
      widget.restaurant!.coords.latitude,
      widget.restaurant!.coords.longitude,
      60.0, // Speed in km/hr, assuming 60 km/hr
      0.5, // Price per km, replace with your actual price 34.00787856011395, -6.8473722332201925
    );

    setState(() {
      distance = distanceTime.distance;
      // Calculate delivery price based on distance and price per kilometer
      deliveryPrice = distance != null ? distance! * 0.5 : null; // Assuming $0.5 per kilometer
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRed,
        title: ReusableText(
          text: "Complete Ordering",
          style: appStyle(16, kWhite, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              OrderTile(food: widget.food),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: width,
                height: height / 3.25,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: widget.restaurant!.title,
                          style: appStyle(18, Colors.blue, FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kOffWhite,
                          backgroundImage: NetworkImage(widget.restaurant!.logoUrl),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(first: "Business Hours", second: widget.restaurant!.time),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(first: "Distance from Restaurant", second: distance != null ? "${distance?.toStringAsFixed(2)} km" : "Calculating..."),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(first: "Delivery Price", second: deliveryPrice != null ? "\$${deliveryPrice!.toStringAsFixed(2)}" : "Calculating..."),

                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(first: "Order Total", second: "\$${widget.item.price.toStringAsFixed(2)}"),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(first: "Global Total", second: "\$${(widget.item.price+deliveryPrice!).toStringAsFixed(2)}"),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                      text: "Additives",
                      style: appStyle(18, Colors.blue, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: width, // Adjust width as needed
                      height: 15.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.item.additives.length,
                        itemBuilder: (context, index) {
                          String additive = widget.item.additives[index];
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
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                text: "Proceed to payment",
                bntHeight: 45.h,
                onTap: () {
                  Get.to(()=> const PaymentPage());
                },
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}