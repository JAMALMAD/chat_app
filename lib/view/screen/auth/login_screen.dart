import 'package:cheating_app/core/app_route.dart';
import 'package:cheating_app/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/const.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import 'controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState>  formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),

              ///<===================== Title text =========================>

              const Center(
                  child: CustomText(
                text: AppString.createAccount,
                textAlign: TextAlign.center,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 44.h),
                          alignment: Alignment.center,
                          height: 100.r,
                          width: 100.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: FlutterLogo(
                            size: 70.r,
                          ),
                        ),
                      ],
                    ),


                 
                    ///<===========================Email section======================================>

                    CustomText(
                      text: AppString.email,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),
                    CustomTextField(
                      textEditingController: authController.emailController.value,
                      validator: (value) {
                        // if (value!.isEmpty) {
                        //   return AppString.enterValidEmail;
                        // } else if (!AppString.emailRegexp
                        //     .hasMatch(authController.signUPEmail.value.text)) {
                        //   return AppString.enterValidEmail;
                        // } else {
                        //   return null;
                        // }
                      },

                      textInputAction: TextInputAction.next,
                      // textEditingController: controller.emailSignUp,
                      hintText: AppString.email,
                    ),

                    ///<==============================Password section====================================>
                    CustomText(
                      text: AppString.password,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                      top: 8.h,
                    ),

                    CustomTextField(
                      textEditingController: authController.passwordController.value,
                      validator: (value) {
                        // if (value.isEmpty) {
                        //   return AppString.passWordMustBeAtLeast;
                        // } else if (value.length < 8 ||
                        //     !AppString.passRegexp.hasMatch(value)) {
                        //   return "Password must be at least 8 characters long";
                        // } else {
                        //   return null;
                        // }
                      },
                      textInputAction: TextInputAction.next,
                      //textEditingController: controller.passSignUp,
                      isPassword: true,
                      hintText: "password",
                    ),

                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),

              ///<==============================================login  Button==========================================>
              ElevatedButton(onPressed: (){authController.loginMethod();}, child: Text("Login")),
              
              // CustomButton(
              //   fillColor: Colors.blue,
              //   onTap: () {
              //      authController.loginMethod();
              //     if (formKey.currentState!.validate()) {
                    
                 
              //       print(
              //           "===============================user creat successfull");
                 
              //     }
              //   },
              //   title: "Login",
              // ),

              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "dont have an Account",

                    /// <==============================Sign in text==============================>
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoute.signUpScreen);
                    },
                    child: const CustomText(
                      color: Colors.blue,
                      text: "sign UP",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 18.h,
              ),
            ],
          ),
        ),
      );
    }));
  }
}
