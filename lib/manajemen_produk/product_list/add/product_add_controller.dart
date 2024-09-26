import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAddController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;
  var selectedCategory = "".obs;
  var selectedProductType = "1".obs;

  void onChangeProductType(String value) {
    selectedProductType.value = value;
    print(selectedProductType);
  }

  List<String> get categoryDropdown {
    List<String> items = [];
    items.add("");
    for (var i = 0; i < categoryList.length; i++) {
      items.add(categoryList[i]['name'].toString());
    }

    return items;
  }

  List<DropdownMenuItem<String>> get productTypeDropdown {
    List<DropdownMenuItem<String>> menuItems = [];

    menuItems.add(const DropdownMenuItem(
        child: Text("Single Produk (Tanpa varian)"), value: "1"));
    menuItems.add(const DropdownMenuItem(
        child: Text("Varian Produk (Dengan varian)"), value: "2"));
    return menuItems;
  }
}
