import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrinterSettingController extends GetxController {
  var loading = false.obs;
  var selected = "".obs;
  var settingData = <String, dynamic>{}.obs;
  var onLoading = false.obs;

  var radioPembulatan = 0.obs;
  var radioKoneksi = 0.obs;
  var radioUkuran = 0.obs;

  void onChangePembulatan(int value) {
    radioPembulatan.value = value;
  }

  void onChangeKoneksi(int value) {
    radioKoneksi.value = value;
  }

  void onChangeUkuran(int value) {
    radioUkuran.value = value;
  }

  Future getSettingData() async {
    onLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/printer-setting');
      var body = jsonDecode(res.body);
      if (body['success']) {
        onLoading(false);
        settingData.value = body['data'];
        print(settingData);
      }
    }
  }

  void printerSettingUpdate(String footer) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "printer_connection": radioKoneksi.value == 0 ? "bluetooth" : "usb",
        "printer_paper_size": radioUkuran.value == 0 ? 5.8 : 8.0,
        "printer_custom_footer": footer,
        "is_rounded": radioPembulatan.value == 0 ? 1 : 0
      };
      var res = await Network().post(data, '/core/printer-setting-update');
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
