import 'dart:async';
import 'dart:convert';

import 'package:buzz/database/db_helper.dart';
import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAddController extends GetxController {
  var storeLoading = false.obs;
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
  var selectedMaterial = "".obs;
  var materialList = List.empty().obs;
  var materialLoading = false.obs;
  var komposisiDbList = List.empty().obs;
  var selectedMapMaterial = <String, dynamic>{}.obs;
  var radioGroupValue = 0.obs;

  void productStore(
      String code,
      String sku,
      String barcode,
      String name,
      int price,
      int cost,
      int stockAlert,
      int weight,
      String description,
      int priceTa,
      int priceMp,
      int priceCus) async {
    storeLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      int userId = int.parse(user['id'].toString());
      var data = {
        "category_id": selectedCategoryId.value,
        "code": code,
        "sku": sku,
        "barcode": barcode,
        "name": name,
        "price": price,
        "cost": cost,
        "unit": selectedUnitName.value,
        "stock_alert": stockAlert,
        "user_id": userId,
        "is_variant": selectedProductType.value,
        "is_manufactured": selectedProductMadeOf.value,
        "buffered_stock": selectedBufferedStock.value,
        "weight": weight,
        "description": description,
        "created_by": radioGroupValue.value,
        "price_ta": priceTa,
        "price_mp": priceMp,
        "price_cus": priceCus
      };
      var res = await Network().post(data, '/core/product-store');
      var body = jsonDecode(res.body);
      if (body['success']) {
        storeLoading(false);
        Get.back();
      } else {
        showError(body['message'].toString());
        storeLoading(false);
      }
    }
  }

  void onChangeRadio(int value) {
    radioGroupValue.value = value;
  }

  void onChangeComposition(String value) {
    selectedMaterial.value = value;
    int inof = materialProduct.indexOf(value);
    selectedMapMaterial.value = materialList[inof];
  }

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

  List<String> get materialProduct {
    List<String> menuItems = [];

    for (var i = 0; i < materialList.length; i++) {
      menuItems.add(materialList[i]['material_name']);
    }
    menuItems.add("");
    return menuItems;
  }

  void getCompositionProduct() async {
    materialLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/product-composition');
      var body = jsonDecode(res.body);
      if (body['success']) {
        materialLoading(false);
        materialList.value = body['data'];
      }
    }
  }

  void tambahKomposisi(int quantity) async {
    await SQLHelper.tambahProduk(
        selectedMapMaterial['id'],
        selectedMapMaterial['material_name'],
        selectedMapMaterial['unit'],
        selectedMapMaterial['product_type'],
        quantity);
    refreshKomposisi();
    Get.back();
  }

  void refreshKomposisi() async {
    final data = await SQLHelper.getProducts();
    komposisiDbList.value = data;
  }

  void clearKomposisi() async {
    await SQLHelper.clearProduct();
  }

  void deleteKomposisi(int id) async {
    SQLHelper.deleteProduct(id);
    refreshKomposisi();
  }

  void updateKomposisi(int id, int quantity) async {
    await SQLHelper.updateProduct(
        id,
        selectedMapMaterial['id'],
        selectedMapMaterial['material_name'],
        selectedMapMaterial['unit'],
        selectedMapMaterial['product_type'],
        quantity);
    refreshKomposisi();
    Get.back();
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
