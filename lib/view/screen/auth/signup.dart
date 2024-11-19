import 'package:cheating_app/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/const.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import 'controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

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

                    ///<===================================Name section============================>
                    SizedBox(
                      height: 31.h,
                    ),

                    CustomText(
                      text: AppString.fullName,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                    ),

                    CustomTextField(
                      textEditingController:
                          authController.nameController.value,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppString.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppString.enterAValidName;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      hintText: AppString.fullName,
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
                      textEditingController: authController.signUPEmail.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppString.enterValidEmail;
                        } else if (!AppString.emailRegexp
                            .hasMatch(authController.signUPEmail.value.text)) {
                          return AppString.enterValidEmail;
                        } else {
                          return null;
                        }
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
                      textEditingController: authController.signUPPass.value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppString.passWordMustBeAtLeast;
                        } else if (value.length < 8 ||
                            !AppString.passRegexp.hasMatch(value)) {
                          return "Password must be at least 8 characters long";
                        } else {
                          return null;
                        }
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

              ///<==============================================Sign Up Button==========================================>
              CustomButton(
                fillColor: Colors.blue,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    
                  authController.signUP();
                    print(
                        "===============================user creat successfull");
                        Get.to(LoginScreen());
                  }
                },
                title: "SignUP",
              ),

              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Already have an Account",

                    /// <==============================Sign in text==============================>
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(HomeScreen());
                    },
                    child: const CustomText(
                      color: Colors.blue,
                      text: "LogIn",
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
