import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentSettingController extends GetxController {
  var loading = false.obs;
  var selected = "".obs;
  var settingData = List.empty().obs;
  var onLoading = false.obs;
  var selectedCash = 0.obs;
  var selectedPaymentGateway = 0.obs;
  var selectedTransfer = 0.obs;
  var selectedCOD = 0.obs;
  var selectedMarketplace = 0.obs;
  var selectedPiutang = 0.obs;
  var selectedQRIS = 0.obs;

  Future getPaymentData() async {
    onLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/payment-setting');
      var body = jsonDecode(res.body);
      if (body['success']) {
        onLoading(false);
        settingData.value = body['data'];
        selectedCash.value = settingData[0]['selected'] == "true" ? 0 : 1;
        selectedPaymentGateway.value =
            settingData[1]['selected'] == "true" ? 0 : 1;
        selectedTransfer.value = settingData[2]['selected'] == "true" ? 0 : 1;
        selectedCOD.value = settingData[3]['selected'] == "true" ? 0 : 1;
        selectedMarketplace.value =
            settingData[4]['selected'] == "true" ? 0 : 1;
        selectedPiutang.value = settingData[5]['selected'] == "true" ? 0 : 1;
        selectedQRIS.value = settingData[6]['selected'] == "true" ? 0 : 1;
      }
    }
  }

  void pettyCashUpdate() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "petty_cash": selected.value};
      var res = await Network().post(data, '/core/petty-cash-update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        showSuccess(body['message'].toString());
      } else {
        loading(false);
        showError(body['message'].toString());
      }
    }
  }

  List<DropdownMenuItem<String>> get pettyDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));
    menuItems.add(const DropdownMenuItem(child: Text("ON"), value: "1"));
    menuItems.add(const DropdownMenuItem(child: Text("OFF"), value: "2"));

    return menuItems;
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }

  void showSuccess(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
