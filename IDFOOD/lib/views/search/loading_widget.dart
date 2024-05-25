import 'package:flutter/cupertino.dart';
import 'package:idfood/constants/constants.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:  Padding(
          padding: const EdgeInsets.only(bottom: 180),
        child:  LottieBuilder.asset(
          "assets/anime/delivery.json",
          width: width,
          height: height/2,
        ),
      ),
    );
  }
}
