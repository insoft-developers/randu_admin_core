// ignore_for_file: prefer_const_constructors

import 'package:buzz/homepage/homepage.dart';
import 'package:buzz/login/loginpage.dart';
import 'package:get/get.dart';

import '../login_signup/splash_screen.dart';

class Routes {
  static String initial = "/";
  static String homepage = "/homePage";
  static String login = "/loginPage";
}

final getPage = [
  GetPage(
    name: Routes.initial,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routes.homepage,
    page: () => HomePage(),
  ),
  GetPage(
    name: Routes.login,
    page: () => LoginPage(),
  )
];
