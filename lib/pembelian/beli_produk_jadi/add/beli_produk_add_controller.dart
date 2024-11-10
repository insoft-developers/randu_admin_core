import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeliProdukAddController extends GetxController {
  var loading = false.obs;
  var selectedPaymentType = "0".obs;
  var bayarPakaiLoading = false.obs;
  var accountIdList = List.empty().obs;
  var selectedAccountId = "".obs;
  var productList = List.empty().obs;
  var productLoading = false.obs;

  void getProductData() async {
    productLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/product-purchase-product');
      var body = jsonDecode(res.body);
      if (body['success']) {
        productLoading(false);
        productList.value = body['data'];
      }
    }
  }

  void getProductPurchaseType(String paymentType) async {
    bayarPakaiLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "payment_type": paymentType};
      var res = await Network().post(data, '/core/product-purchase-type');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountIdList.value = body['data'];
        bayarPakaiLoading(false);
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownPaymentType {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Tunai"), value: "0"));
    menuItems.add(const DropdownMenuItem(child: Text("Utang"), value: "1"));
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownPayment {
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

  void onChangePaymentType(String paymentType) {
    getProductPurchaseType(paymentType);
    selectedAccountId.value = "";
  }

  void onChangeAccoundId(String accoungId) {
    selectedAccountId.value = accoungId;
    print(selectedAccountId);
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
}
