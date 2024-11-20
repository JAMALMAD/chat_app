import 'package:cheating_app/view/screen/auth/login_screen.dart';
import 'package:cheating_app/view/screen/auth/signup.dart';
import 'package:cheating_app/view/screen/home_screen.dart';
import 'package:cheating_app/view/screen/profile_Screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../view/screen/auth/controller/user_controller.dart';

class AppRoute{
  
  static const String homeScreen = "/homeScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String loginScreen = "/loginScreen";
  static const String profileScreen = "/ profileScreen";
  static List<GetPage> routes = [
    
  GetPage(name: loginScreen, page:()=> LoginScreen()),
  GetPage(name: homeScreen, page:()=> HomeScreen()),
  GetPage(name: signUpScreen, page:()=> SignUpScreen()),
  // GetPage(name: profileScreen, page:()=> Profile_screen(myUser: UserController.me)),
  GetPage(name: profileScreen, page:()=> ProfileScreen(myUser: UserController.me)),
  // GetPage(name: loginScreen, page:()=> SignUpScreen()),
  ];
}