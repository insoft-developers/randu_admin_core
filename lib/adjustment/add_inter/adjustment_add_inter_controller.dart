import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:buzz/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdjustmentAddInterProductController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;
  var selectedCategory = "".obs;
  var categoryLoading = false.obs;

  var accountList = List.empty().obs;
  var selectedAccount = "".obs;
  var accountLoading = false.obs;

  var productList = List.empty().obs;
  var productLoading = false.obs;

  final AppConst controller = Get.put(AppConst());

  void getCategoryData() async {
    categoryLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": ""};
      var res = await Network().post(data, '/core/adjustment-category-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        categoryList.value = body['data'];
        categoryLoading(false);
      }
    }
  }

  void getAccountData() async {
    accountLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/adjustment-account');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountList.value = body['data'];
        accountLoading(false);
      }
    }
  }

  void getProductData() async {
    productLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/adjustment-inter');
      var body = jsonDecode(res.body);
      if (body['success']) {
        productList.value = body['data'];
        productLoading(false);
        print(productList);
      }
    }
  }

  List<DropdownMenuItem<String>> get categoryDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems
        .add(const DropdownMenuItem(child: Text("Pilih Kategori"), value: ""));

    for (var i = 0; i < categoryList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(categoryList[i]['name'].toString()),
            value: categoryList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get accountDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < accountList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(accountList[i]['name'].toString()),
            value: accountList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  List<String> get dropdownProduct {
    List<String> menuItems = [];

    for (var i = 0; i < productList.length; i++) {
      menuItems.add(productList[i]['product_name'] +
          ' - ' +
          productList[i]['unit'].toString());
    }
    menuItems.add("");
    return menuItems;
  }

  List<DropdownMenuItem<String>> get typeDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(
        const DropdownMenuItem(child: Text("Penambahan"), value: "addition"));
    menuItems.add(const DropdownMenuItem(
        child: Text("Pengurangan"), value: "substraction"));
    return menuItems;
  }

  void adjustmentStore(String transactionDate, List<String> productsId,
      List<String> quantities, List<String> types) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "date": transactionDate,
        "category_adjustment_id": selectedCategory.value,
        "cost_good_sold_id": selectedAccount.value,
        "md_inter_product_id": productsId,
        "quantity": quantities,
        "type": types
      };
      var res = await Network().post(data, '/core/adjustment-inter-store');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        controller.changePage(11);
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
