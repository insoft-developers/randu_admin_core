import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  var fullname = "".obs;
  var userEmail = "".obs;

  void checkLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      fullname.value = user['fullname'].toString();
      userEmail.value = user['email'].toString();
    }
  }
}
