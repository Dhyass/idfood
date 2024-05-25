import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kOffWhite,
      elevation: 0,
      /* leading: GestureDetector(
        onTap: () {
          // logout function
        },
        child: Icon(
          AntDesign.logout,
          size: 18.h,
        ),
      ),*/
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/usa.svg",
                  width: 15.w,
                  height: 15.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 1.w,
                  height: 15.h,
                  color: kGrayLight,
                ),
                SizedBox(
                  width: 5.w,
                ),
                ReusableText(
                  text: "USA",
                  style: appStyle(16, kRed, FontWeight.w500),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    // redirection to settings page
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      SimpleLineIcons.settings,
                      size: 16.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
