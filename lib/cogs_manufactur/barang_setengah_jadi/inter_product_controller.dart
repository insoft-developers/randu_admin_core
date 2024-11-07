import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterProductController extends GetxController {
  var loading = false.obs;
  var interProductList = List.empty().obs;

  void getInterProductList(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};
      var res = await Network().post(data, '/core/inter-product-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        interProductList.value = body['data'];
        print(interProductList);
      }
    }
  }

  void materialSearch(String value) {
    getInterProductList(value);
  }

  void interProductDelete(String id) async {
    var data = {"id": id};
    var res = await Network().post(data, '/core/inter-product-delete');
    var body = jsonDecode(res.body);
    if (body['success']) {
      Get.back();
      getInterProductList("");
    } else {
      showError(body['message'].toString());
    }
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
