import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kRed,
        title: ReusableText(
            text: "Payment", style: appStyle(16, kOffWhite, FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Card Form",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20.h),
            CardFormField(controller: CardFormEditController()),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Pay",
              bntHeight: 45.h,
              onTap: () {
                //Get.to(()=> const PaymentPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
