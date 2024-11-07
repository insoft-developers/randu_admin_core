import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterProductAddController extends GetxController {
  var loading = false.obs;
  var selectedCategory = "".obs;
  var selectedCategoryId = "".obs;
  var categoryLoading = false.obs;
  var categoryList = List.empty().obs;
  var satuanLoading = false.obs;
  var satuanList = List.empty().obs;
  var selectedSatuan = "".obs;
  var supplierLoading = false.obs;
  var selectedSupplier = "".obs;
  var selectedSupplierId = "".obs;
  var supplierList = List.empty().obs;

  void onChangeCategory(String categoryId, String categoryName) {
    selectedCategoryId.value = categoryId;
    selectedCategory.value = categoryName;
  }

  void onChangeSatuan(String value) {
    selectedSatuan.value = value;
  }

  void onChangeSupplier(String supplierId, String supplierName) {
    selectedSupplier.value = supplierName;
    selectedSupplierId.value = supplierId;
    print(selectedSupplier);
  }

  void getCategoryData() async {
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

  List<String> get dropdownSupplier {
    List<String> menuItems = [];

    for (var i = 0; i < supplierList.length; i++) {
      menuItems.add(supplierList[i]['name']);
    }
    menuItems.add("");
    return menuItems;
  }

  void getUnitData() async {
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

  void bahanBakuStore(String materialName, String sku, String minStock,
      String idealStock, String description) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "material_name": materialName,
        "sku": sku,
        "unit": selectedSatuan.value,
        "supplier_id": selectedSupplierId.value,
        "category_id": selectedCategoryId.value,
        "min_stock": minStock,
        "ideal_stock": idealStock,
        "description": description
      };
      var res = await Network().post(data, '/core/material-store');
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
