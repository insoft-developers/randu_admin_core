import 'dart:convert';
import 'package:buzz/network/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCategoryController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;

  void getCategoryList(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};
      var request = await Network().post(data, '/core/product-category-list');
      var response = jsonDecode(request.body);
      if (response['success']) {
        loading(false);
        categoryList.value = response['data'];
        print(categoryList);
      }
    }
  }

  void categoryDelete(int id) async {
    var data = {"id": id};
    var res = await Network().post(data, '/core/product-category-delete');
    var body = jsonDecode(res.body);
    if (body['success']) {
      getCategoryList("");
    }
  }

  void cariKategori(String value) {
    getCategoryList(value);
  }
}
