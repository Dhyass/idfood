import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:idfood/common/app_style.dart';
import 'package:idfood/common/back_ground_container.dart';
import 'package:idfood/common/custom_button.dart';
import 'package:idfood/common/reusable_text.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/controller/login_controller.dart';
import 'package:idfood/models/hooks_models/login_model.dart';
import 'package:idfood/views/auth/widget/email_text_field.dart';
import 'package:idfood/views/auth/widget/password_textfield.dart';
import 'package:idfood/views/auth/widget/registration_page.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _emailController= TextEditingController();
  late final TextEditingController _passWordController= TextEditingController();

  final FocusNode _passwordFocusNode= FocusNode();

  @override
  void dispose(){
    _emailController.dispose();
    _passWordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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

                      hintText: "Enter Your Email" ,
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

                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(()=> const RegistrationPage(),
                                transition : Transition.circularReveal,
                                duration : const Duration(microseconds: 1200),
                              );
                            },
                            child: ReusableText(
                              text: "Register",
                              style: appStyle(14, Colors.blue, FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 30.h,
                    ),

                    CustomButton(
                      text: "L O G I N",
                      radius: 10.r,
                      color: kRed,
                      btnWidth: width,
                      bntHeight: 35.h,
                        // Print the data from the registration form
                      onTap: () {
                       // print("Email: ${_emailController.text}");
                       // print("Password: ${_passWordController.text}");
                        if(_emailController.text.isNotEmpty
                            && _passWordController.text.length>=8){
                          LoginModel model = LoginModel(email: _emailController.text,
                              password: _passWordController.text);

                          String data = loginModelToJson(model);
                          // login function
                          controller.loginFunction(data);
                        }// fin if
                      },
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
