import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/user_location_controller.dart';
import 'package:idfood/hooks/fetch_default.dart';
import 'package:idfood/models/hooks_models/addresses_response_model.dart';

import '../controller/login_controller.dart';
import '../models/hooks_models/login_response_model.dart';

class CustomAppBar extends StatefulHookWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLocationController());
    final hookResult = useFetchDefault();
    final defaultAddress = hookResult.data?.addressLine1 ?? "Your address"; // Access the correct property

    LoginResponseModel? user;
    final userController = Get.put(LoginController());
    final box = GetStorage();

    String? token = box.read("token");

    if (token != null) {
      user = userController.getUserInfo();
    } else {
      user = null;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 110.h,
      width: MediaQuery.of(context).size.width, // Use MediaQuery to get the width
      color: kRed,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: kSecondary,
              backgroundImage: user != null
                  ? NetworkImage(user.profile)
                  : const NetworkImage(
                  "https://as1.ftcdn.net/v2/jpg/02/41/30/72/1000_F_241307210_MjjaJC3SJy2zJZ6B7bKGMRsKQbdwRSze.jpg"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: ReusableText(
                          text: "Delivery to",
                          style: appStyle(18, kOffWhite, FontWeight.w600)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        hookResult.isLoading
                            ? "Loading..."
                            : hookResult.error != null
                            ? "Error: ${hookResult.error.toString()}"
                            : defaultAddress,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(14, kOffWhite, FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text(getTimeOfDay(), style: const TextStyle(fontSize: 35)),
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour > 5 && hour < 12) {
      return '☀️';
    } else if (hour >= 12 && hour < 17) {
      return "⛅";
    } else {
      return "🌙";
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final controller = Get.put(UserLocationController());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    controller.setPosition(currentLocation);
    controller.getUserAddress(currentLocation);
  }
}
