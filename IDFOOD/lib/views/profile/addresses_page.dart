import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/hooks/fetch_address.dart';
import 'package:idfood/views/profile/shipping_address.dart';
import 'package:idfood/views/profile/widget/address_list.dart';

import '../../models/hooks_models/addresses_response_model.dart';

class AddressesPage extends HookWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAddresses();
    final List<AddressResponseModel> addresses = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    //print("addresses: $addresses");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ReusableText(
          text: "Addresses",
          style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        color: kOffWhite,
        child: Stack(
          children: [
            isLoading
                ? const FoodsListShimmer()
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal:5.w, vertical: 20.h),
                  child: AddressListWidget(addresses: addresses),
                ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h),
                child: CustomButton(
                  onTap: () {
                    Get.to(() => const ShippingAddress());
                  },
                  text: "ADD ADDRESS",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
