import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/common/shimmers/foodlist_shimmer.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/login_controller.dart';
import 'package:idfood/hooks/fetch_cart.dart';
import 'package:idfood/models/cart_response_model.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';
import 'package:idfood/views/auth/login_directions.dart';
import 'package:idfood/views/auth/widget/verification_page.dart';
import 'package:idfood/views/cart/cart_widgets/cart_tile.dart';

class CartPage extends HookWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final hookResult = useFetchCart();
    final isLoading = hookResult.isLoading;
    final List<CartResponseModel> carts = hookResult.data ?? [];
    final refetch = hookResult.refetch;

    final controller = Get.put(LoginController());
    final String? token = box.read("token");
    LoginResponseModel? user;

    if (token != null) {
      user = controller.getUserInfo();
      //print("hook data: ${hookResult.data}");
    }

    if (token == null) {
      return const LoginDirections();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kRed,
        title: ReusableText(
          text: "Cart",
          style: appStyle(14, kWhite, FontWeight.w600),
        ),
      ),
      body: SafeArea(
       child: CustomContainer(
         containerContent: isLoading
             ? const FoodsListShimmer()
             : Padding(
           padding: const EdgeInsets.all(8.0),
           child: SizedBox(
             width: width,
             height: height,
             child: Expanded(
                 child: ListView.builder(
                   physics: const PageScrollPhysics(),
                   itemCount: carts.length,
                   itemBuilder: (context, index) {
                     var cart = carts[index];
                     return CartTile(
                       refetch: refetch,
                       color: kLightWhite,
                       cart: cart,
                   );
               },
                                 ),
             ),
           ),
         ),
       ),
              ),
    );
  }
}
