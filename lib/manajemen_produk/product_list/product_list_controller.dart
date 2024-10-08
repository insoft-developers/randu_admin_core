import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProductListController extends GetxController {
  var loading = false.obs;
  var productList = List.empty().obs;

  void getProductList(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};
      var res = await Network().post(data, '/core/product-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        productList.value = body['data'];
        print(productList);
      }
    }
  }

  void cariProduct(String value) {
    getProductList(value);
  }

  void productDelete(int id) async {
    var data = {"id": id};
    var res = await Network().post(data, '/core/product-delete');
    var body = jsonDecode(res.body);
    if (body['success']) {
      Get.snackbar("Sukses", "Hapus Data Berhasil",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.back();
      getProductList("");
    } else {
      Get.snackbar("Gagal", body['message'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }
}
