import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialPurchaseAddController extends GetxController {
  var loading = false.obs;
  var selectedPaymentType = "0".obs;
  var bayarPakaiLoading = false.obs;
  var accountIdList = List.empty().obs;
  var selectedAccountId = "".obs;
  var materialList = List.empty().obs;
  var materialLoading = false.obs;

  void getMaterialData() async {
    materialLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/material-purchase-product');
      var body = jsonDecode(res.body);
      if (body['success']) {
        materialLoading(false);
        materialList.value = body['data'];
      }
    }
  }

  void getMaterialPurchaseType(String paymentType) async {
    bayarPakaiLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "payment_type": paymentType};
      var res = await Network().post(data, '/core/material-purchase-type');
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
    getMaterialPurchaseType(paymentType);
    selectedAccountId.value = "";
  }

  void onChangeAccoundId(String accoungId) {
    selectedAccountId.value = accoungId;
    print(selectedAccountId);
  }

  List<String> get dropdownProduct {
    List<String> menuItems = [];

    for (var i = 0; i < materialList.length; i++) {
      menuItems.add(materialList[i]['material_name'] +
          ' - ' +
          materialList[i]['unit'].toString());
    }
    menuItems.add("");
    return menuItems;
  }

  void materialPurchaseStore(
      String transactionDate,
      String productCount,
      String totalPurchase,
      List<String> productId,
      List<String> purchaseAmount,
      List<String> purchaseQuantity,
      List<String> unitPrice,
      String tax,
      String discount,
      String other) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "transaction_date": transactionDate,
        "account_id": selectedAccountId.value,
        "product_count": productCount,
        "total_purchase": totalPurchase,
        "product_id": productId,
        "purchase_amount": purchaseAmount,
        "quantity": purchaseQuantity,
        "unit_price": unitPrice,
        "payment_type": selectedPaymentType.value,
        "tax": tax,
        "discount": discount,
        "other_expense": other
      };
      var res = await Network().post(data, '/core/material-purchase-store');
      var body = jsonDecode(res.body);
      if (body['success']) {
        Get.back();
        loading(false);
      } else {
        showError(body['message'].toString());
        loading(false);
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
