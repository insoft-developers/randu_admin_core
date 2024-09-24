import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
