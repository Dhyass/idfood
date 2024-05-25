import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idfood/common/shimmers/shimmer_widget.dart';

class CatergoriesShimmer extends StatelessWidget {
  const CatergoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(left: 12, top: 10),
        height: 80.h,
        child: Row(
          children: List.generate(
            6,
                (index) => Padding(
              padding: EdgeInsets.only(right: 8.w), // Adjust spacing between shimmer items
              child: ShimmerWidget(
                shimmerWidth: 70.w,
                shimmerHieght: 60.h,
                shimmerRadius: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
