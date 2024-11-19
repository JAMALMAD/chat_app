import 'package:cheating_app/view/screen/auth/signup.dart';
import 'package:cheating_app/view/screen/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute{
  static const String loginScreen = "/loginScreen =";
  static const String signUpScreen = "/signUpScreen";
  static List<GetPage> routes = [
  GetPage(name: loginScreen, page:()=> LoginScreen()),
  GetPage(name: signUpScreen, page:()=> SignUpScreen()),
  ];
}