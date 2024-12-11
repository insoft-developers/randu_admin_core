import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdjustmentCategoryAddController extends GetxController {
  var loading = false.obs;

  void AdjustmentCategoryStore(String _name, String _code) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"account_id": userId, "code": _code, "name": _name};

      var res = await Network().post(data, '/core/adjustment-category-store');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        Get.back();
      } else {
        loading(false);
        showError(body['message'].toString());
      }
    }
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
