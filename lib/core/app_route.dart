import 'package:cheating_app/view/screen/auth/signup.dart';
import 'package:cheating_app/view/screen/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute{
  static const String homeScreen = "/homeScreen =";
  static const String signUpScreen = "/signUpScreen";
  static const String loginScreen = "/loginScreen";
  static List<GetPage> routes = [
  GetPage(name: homeScreen, page:()=> HomeScreen()),
  GetPage(name: signUpScreen, page:()=> SignUpScreen()),
  // GetPage(name: loginScreen, page:()=> SignUpScreen()),
  ];
}