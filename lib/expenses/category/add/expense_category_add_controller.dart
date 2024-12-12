import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:buzz/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseCategoryAddController extends GetxController {
  var loading = false.obs;

  var productList = List.empty().obs;
  var productLoading = false.obs;

  final AppConst controller = Get.put(AppConst());

  void getProductData() async {
    productLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/adjustment-product');
      var body = jsonDecode(res.body);
      if (body['success']) {
        productList.value = body['data'];
        productLoading(false);
        print(productList);
      }
    }
  }

  List<String> get dropdownProduct {
    List<String> menuItems = [];

    for (var i = 0; i < productList.length; i++) {
      menuItems.add(
          productList[i]['name'] + ' - ' + productList[i]['unit'].toString());
    }
    menuItems.add("");
    return menuItems;
  }

  void categoryStore(
    _name,
    List<String> _productsId,
  ) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "name": _name, "product_id": _productsId};
      var res = await Network().post(data, '/core/expense-category-store');
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
