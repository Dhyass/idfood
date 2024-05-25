import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/custom_container.dart';
import 'package:idfood/common/profile_appbar.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/login_controller.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';
import 'package:idfood/views/auth/login_directions.dart';
import 'package:idfood/views/auth/widget/verification_page.dart';
import 'package:idfood/views/profile/addresses_page.dart';
import 'package:idfood/views/profile/shipping_address.dart';
import 'package:idfood/views/profile/widget/profile_tile_widget.dart';
import 'widget/user_info_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    LoginResponseModel? user;
    final controller = Get.put(LoginController());
    final box= GetStorage();

    String? token = box.read("token");

    if(token!=null){
     user= controller.getUserInfo();
    // print(user!.email);
    }

    if(token==null){
      return const LoginDirections();
    }

    if(user!=null && user.verification==false){
      return const VerificationPage();
    }


    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const ProfileAppBar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              UserInfoWidget(user: user),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 210.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      onTap: () {
                        /*
                        Get.to(() => const LoginDirections(),
                          transition : Transition.cupertinoDialog,
                          duration : const Duration(microseconds: 900
                          ),
                        );
                        */
                      },
                      title: "My Orders",
                      icon: Ionicons.ios_fast_food_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "My Favorite Places",
                      icon: Ionicons.heart_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Reviews",
                      icon: Ionicons.chatbubbles_outline,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Coupons",
                      icon: MaterialCommunityIcons.tag_outline,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 210.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                 physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      onTap: () {
                        //Get.to(()=>const ShippingAddress(),
                        Get.to(()=>const AddressesPage(),
                        transition: Transition.rightToLeft ,
                          duration:  const Duration(milliseconds: 900)
                        );

                      },
                      title: "Shipping Address",
                      icon: SimpleLineIcons.location_pin,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Service Center",
                      icon: AntDesign.customerservice,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "App FeedBack",
                      icon: MaterialIcons.rss_feed,
                    ),
                    ProfileTileWidget(
                      onTap: () {},
                      title: "Settings",
                      icon: AntDesign.setting,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                onTap: () {
                  controller.logout();
                },
                text: "Logout",
                radius: 0,
                color: kRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
