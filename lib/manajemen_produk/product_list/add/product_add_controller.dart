import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAddController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;
  var selectedCategoryId = "".obs;
  var selectedCategoryName = "".obs;
  var selectedProductType = "1".obs;
  var categoryLoading = false.obs;
  var selectedUnitId = "".obs;
  var selectedUnitName = "".obs;
  var satuanList = List.empty().obs;
  var satuanLoading = false.obs;
  var selectedBufferedStock = "0".obs;
  var selectedProductMadeOf = "1".obs;

  void onCategorySelected(Map<String, dynamic> dataList) {
    selectedCategoryId.value = dataList['id'].toString();
    selectedCategoryName.value = dataList['name'].toString();
    Get.back();
  }

  void onUnitSelected(Map<String, dynamic> dataList) {
    selectedUnitId.value = dataList['id'].toString();
    selectedUnitName.value = dataList['unit_name'].toString();
    Get.back();
  }

  void getProductUnit(String cari) async {
    satuanLoading(true);
    var data = {"cari": cari};
    var res = await Network().post(data, '/core/product-unit');
    var body = jsonDecode(res.body);
    if (body['success']) {
      satuanLoading(false);
      satuanList.value = body['data'];
      print(satuanList);
    }
  }

  void getProductCategory(String kataCari) async {
    categoryLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": kataCari};
      var request = await Network().post(data, '/core/product-category-list');
      var response = jsonDecode(request.body);
      if (response['success']) {
        categoryLoading(false);
        categoryList.value = response['data'];
        print("product kategori printed");
      }
    }
  }

  void categorySearch(String value) {
    getProductCategory(value);
  }

  void unitSearch(String value) {
    getProductUnit(value);
  }

  void onChangeProductType(String value) {
    selectedProductType.value = value;
    print(selectedProductType);
  }

  List<DropdownMenuItem<String>> get productTypeDropdown {
    List<DropdownMenuItem<String>> menuItems = [];

    menuItems.add(const DropdownMenuItem(
        child: Text("Single Produk (Tanpa varian)"), value: "1"));
    menuItems.add(const DropdownMenuItem(
        child: Text("Varian Produk (Dengan varian)"), value: "2"));
    return menuItems;
  }

  List<DropdownMenuItem<String>> get bufferedStockDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(
        child: Text("No - Jangan Gunakan Stok"), value: "0"));
    menuItems.add(
        const DropdownMenuItem(child: Text("Yes - Gunakan Stok"), value: "1"));
    return menuItems;
  }

  List<DropdownMenuItem<String>> get productMadeOfDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Beli Jadi"), value: "1"));
    menuItems
        .add(const DropdownMenuItem(child: Text("Manufactured"), value: "2"));
    return menuItems;
  }
}
