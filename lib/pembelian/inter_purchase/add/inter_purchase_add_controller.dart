import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterPurchaseAddController extends GetxController {
  var loading = false.obs;
  var bayarPakaiLoading = false.obs;
  var accountIdList = List.empty().obs;
  var selectedAccountId = "".obs;
  var productList = List.empty().obs;
  var productLoading = false.obs;
  var materialLoading = false.obs;
  var materialList = List.empty().obs;

  void getProductData() async {
    productLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/inter-purchase-product');
      var body = jsonDecode(res.body);
      if (body['success']) {
        productLoading(false);
        productList.value = body['data'];
      }
    }
  }

  void getInterPurchaseAccount() async {
    bayarPakaiLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/inter-purchase-account');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountIdList.value = body['data'];
        bayarPakaiLoading(false);
      }
    }
  }

  Future getMaterialData(String productId, String orderQty) async {
    materialLoading(true);
    var data = {"id": productId, "product_count": orderQty};

    var res = await Network().post(data, '/core/inter-purchase-change');
    var body = jsonDecode(res.body);
    if (body['success']) {
      materialLoading(false);
      materialList.value = body['data'];
      print(materialList);
    } else {
      materialLoading(false);
      showError(body['message'].toString());
    }
  }

  List<DropdownMenuItem<String>> get dropdownAccount {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < accountIdList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: SizedBox(
                width: MediaQuery.of(Get.context!).size.width - 88,
                child: Text(accountIdList[i]['name'].toString())),
            value: accountIdList[i]['id'].toString() +
                "_" +
                accountIdList[i]['account_code_id'].toString()),
      );
    }

    return menuItems;
  }

  void onChangeAccoundId(String accoungId) {
    selectedAccountId.value = accoungId;
    print(selectedAccountId);
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

  void interPurchaseStore(
      String transactionDate,
      String productId,
      String productCount,
      String tax,
      String discount,
      String other,
      String totalPurchase) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "transaction_date": transactionDate,
        "userid": userId,
        "product_id": productId,
        "account_id": selectedAccountId.value,
        "product_count": productCount,
        "tax": tax,
        "discount": discount,
        "other_expense": other,
        "total_purchase": totalPurchase
      };
      var res = await Network().post(data, '/core/inter-purchase-store');
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
