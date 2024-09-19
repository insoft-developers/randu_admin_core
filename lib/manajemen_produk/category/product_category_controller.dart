import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCategoryController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;

  void getCategoryList() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var request = await Network().post(data, '/core/product-category-list');
      var response = jsonDecode(request.body);
      if (response['success']) {
        loading(false);
        categoryList.value = response['data'];
        print(categoryList);
      }
    }
  }
}
