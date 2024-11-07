import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterProductEditController extends GetxController {
  var loading = false.obs;
  var selectedCategory = "".obs;
  var selectedCategoryId = "".obs;
  var categoryLoading = false.obs;
  var categoryList = List.empty().obs;
  var satuanLoading = false.obs;
  var satuanList = List.empty().obs;
  var selectedSatuan = "".obs;
  var materialList = List.empty().obs;
  var materialLoading = false.obs;

  void onChangeCategory(String categoryId, String categoryName) {
    selectedCategoryId.value = categoryId;
    selectedCategory.value = categoryName;
  }

  void onChangeSatuan(String value) {
    selectedSatuan.value = value;
  }

  Future getCategoryData() async {
    categoryLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};

      var res = await Network().post(data, '/core/inter-product-category');
      var body = jsonDecode(res.body);
      if (body['success']) {
        categoryLoading(false);
        categoryList.value = body['data'];
      }
    }
  }

  List<String> get dropdownCategory {
    List<String> menuItems = [];

    for (var i = 0; i < categoryList.length; i++) {
      menuItems.add(categoryList[i]['inter_category']);
    }
    menuItems.add("");
    return menuItems;
  }

  List<String> get dropdownSatuan {
    List<String> menuItems = [];

    for (var i = 0; i < satuanList.length; i++) {
      menuItems.add(satuanList[i]['unit_name']);
    }
    menuItems.add("");
    return menuItems;
  }

  List<String> get dropdownMaterial {
    List<String> menuItems = [];

    for (var i = 0; i < materialList.length; i++) {
      menuItems.add(materialList[i]['material_name'] +
          ' - ' +
          materialList[i]['unit'].toString());
    }
    menuItems.add("");
    return menuItems;
  }

  Future getUnitData() async {
    satuanLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};

      var res = await Network().post(data, '/core/inter-product-unit');
      var body = jsonDecode(res.body);
      if (body['success']) {
        satuanLoading(false);
        satuanList.value = body['data'];
      }
    }
  }

  Future getMaterialData() async {
    materialLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};

      var res = await Network().post(data, '/core/inter-product-material');
      var body = jsonDecode(res.body);
      if (body['success']) {
        materialLoading(false);
        materialList.value = body['data'];
      }
    }
  }

  Future interProductStore(
      String id,
      String productName,
      String sku,
      String minStock,
      String idealStock,
      List<String> komposisi,
      List<String> quantity,
      String description) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "id": id,
        "userid": userId,
        "product_name": productName,
        "sku": sku,
        "unit": selectedSatuan.value,
        "category_id": selectedCategoryId.value,
        "min_stock": minStock,
        "ideal_stock": idealStock,
        "composition": komposisi,
        "quantity": quantity,
        "description": description
      };
      var res = await Network().post(data, '/core/inter-product-update');
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
