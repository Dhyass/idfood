import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/models/hooks_models/addresses_response_model.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.address});

  final AddressResponseModel address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      visualDensity: VisualDensity.compact,
      leading: Icon(
        SimpleLineIcons.location_pin,
        color: kPrimary,
        size: 28.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      title: ReusableText(text: address.addressLine1,
          style:appStyle(12, kDark, FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(text: address.postalCode,
             style:  appStyle(11, kGrayLight, FontWeight.w500),
          ),
          SizedBox(
            height: 5.h,
          ),
          ReusableText(text:"tap to Set address as default",
            style:  appStyle(8, kGrayLight, FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
