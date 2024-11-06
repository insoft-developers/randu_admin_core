import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BahanBakuController extends GetxController {
  var loading = false.obs;
  var materialList = List.empty().obs;

  void getMaterialList(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};
      var res = await Network().post(data, '/core/material-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        materialList.value = body['data'];
        print(materialList);
      }
    }
  }

  void materialSearch(String value) {
    getMaterialList(value);
  }

  void bahanBakuDelete(String id) async {
    var data = {"id": id};
    var res = await Network().post(data, '/core/material-delete');
    var body = jsonDecode(res.body);
    if (body['success']) {
      Get.back();
      getMaterialList("");
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
