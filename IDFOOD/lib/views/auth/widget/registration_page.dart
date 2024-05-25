import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/registration_controller.dart';
import 'package:idfood/models/hooks_models/registration_model.dart';
import 'package:idfood/views/auth/widget/email_text_field.dart';
import 'package:idfood/views/auth/widget/password_textfield.dart';
import 'package:lottie/lottie.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  late final TextEditingController _emailController= TextEditingController();
  late final TextEditingController _passWordController= TextEditingController();
   final TextEditingController _userController= TextEditingController();

  final FocusNode _passwordFocusNode= FocusNode();

  @override
  void dispose(){
   _userController.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return Scaffold(
      backgroundColor: kRed,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  kRed,
        title: Center(
          child: ReusableText(
            text:"IDFOOD MON PLAT" ,
            style:appStyle(20, kLightWhite, FontWeight.bold),
          ),
        ),
      ),
      body: BackGroundContainer(
        color: kOffWhite,
        image: "assets/images/restaurant_bk.png",
        opacity: 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Lottie.asset("assets/anime/delivery.json"),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child:  Column(
                  children: [
                    EmailTextField(

                      hintText: "UserName" ,
                      prefixIcon: const Icon(MaterialIcons.person_outline,
                        size: 22, color: kGrayLight,
                      ),
                      controller: _userController,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),

                    EmailTextField(

                      hintText: "Your Email" ,
                      prefixIcon: const Icon(CupertinoIcons.mail,
                        size: 22, color: kGrayLight,
                      ),
                      controller: _emailController,
                    ),

                    SizedBox(
                      height: 25.h,
                    ),

                     PasswordTextField(
                       controller: _passWordController,
                     ),


                    SizedBox(
                      height: 30.h,
                    ),

                    CustomButton(
                      onTap: () {
                        // Print the data from the registration form
                       ///print("Username: ${_userController.text}");
                      //  print("Email: ${_emailController.text}");
                       /// print("Password: ${_passWordController.text}");

                        if (_userController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _passWordController.text.length >= 8) {
                          RegistrationModel model = RegistrationModel(
                              username: _userController.text,
                              email: _emailController.text,
                              password: _passWordController.text);

                          String data = registrationModelToJson(model);

                          // registration function
                          controller.registrationFunction(data);
                        }
                        // Get.to(()=>const MainScreen());
                      },
                      text: "R E G I S T E R",
                      radius: 10.r,
                      color: kRed,
                      btnWidth: width,
                      bntHeight: 35.h,
                    ),



                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
