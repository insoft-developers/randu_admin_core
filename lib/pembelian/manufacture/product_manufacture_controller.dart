import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductManufactureController extends GetxController {
  var loading = false.obs;
  var productManufactureList = List.empty().obs;

  void getProductManufactureData(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};

      var res = await Network().post(data, '/core/product-manufacture-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        productManufactureList.value = body['data'];
        loading(false);
        print(productManufactureList);
      }
    }
  }

  void sync(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"id": id, "userid": userId};
      var res = await Network().post(data, '/core/product-manufacture-sync');
      var body = jsonDecode(res.body);
      if (body['success']) {
        getProductManufactureData("");
      } else {
        showError(body['message'].toString());
      }
    }
  }

  void destroy(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"id": id, "userid": userId};
      var res = await Network().post(data, '/core/product-manufacture-delete');
      var body = jsonDecode(res.body);
      if (body['success']) {
        getProductManufactureData("");
      } else {
        showError(body['message'].toString());
      }
    }
  }

  void productSearch(String kataCari) {
    getProductManufactureData(kataCari);
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
