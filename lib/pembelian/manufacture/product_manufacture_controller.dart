import 'dart:convert';

import 'package:buzz/network/network.dart';
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

  void productSearch(String kataCari) {
    getProductManufactureData(kataCari);
  }
}
