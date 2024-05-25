import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/login_response_model.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key, this.user});

  final LoginResponseModel? user;

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width,
      color: kOffWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  //backgroundImage: const AssetImage("assets/images/musk.png"),
                  backgroundImage: NetworkImage(widget.user!.profile),
                ),
                SizedBox(width: 12.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text:widget.user!.username?? "UserName",
                      style: appStyle(14, kGray, FontWeight.bold),
                    ),
                    SizedBox(height: 2.h),
                    ReusableText(
                      text: widget.user!.email,
                      style: appStyle(12, kPrimary, FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Action à effectuer lors de l'appui sur l'icône de modification
              },
              icon: Icon(
                AntDesign.edit,
                size: 20.sp,
                color: kGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
