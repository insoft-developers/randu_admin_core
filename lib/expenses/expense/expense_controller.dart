import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz/network/network.dart';

class ExpenseController extends GetxController {
  var loading = false.obs;
  var expenseList = List.empty().obs;
  var selectedMonth = "".obs;
  var selectedYear = "".obs;
  var tahunSekarang = "".obs;
  var categoryLoading = false.obs;
  var categoryList = List.empty().obs;
  var selectedCategory = "".obs;

  var now = DateTime.now();
  var formatter = DateFormat('MM');
  var formatterYear = DateFormat('yyyy');

  @override
  void onInit() {
    String formattedDate = formatter.format(now);
    selectedMonth.value = formattedDate.toString();
    String formattedYear = formatterYear.format(now);
    selectedYear.value = formattedYear.toString();
    tahunSekarang.value = formattedYear.toString();
    super.onInit();
  }

  void onchangeMonth(String value) {
    selectedMonth.value = value;
    getExpenseData(value);
  }

  void onchangeYear(String value) {
    selectedYear.value = value;
    getExpenseData(value);
  }

  void onchangeCategory(String value) {
    selectedCategory.value = value;
    getExpenseData(value);
  }

  void getCategoryData() async {
    categoryLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "kata_cari": ""};
      var res = await Network().post(data, '/core/expense-category-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        categoryList.value = body['data'];
        categoryLoading(false);
      }
    }
  }

  void getExpenseData(String kataCari) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "month": selectedMonth.value,
        "year": selectedYear.value,
        "category": selectedCategory.value,
        "cari": kataCari
      };

      var res = await Network().post(data, '/core/expense-list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        expenseList.value = body['data'];
      }
    }
  }

  List<DropdownMenuItem<String>> get monthDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems
        .add(const DropdownMenuItem(child: Text("Pilih Bulan"), value: ""));

    menuItems.add(
      const DropdownMenuItem(child: Text("Januari"), value: "01"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Febuari"), value: "02"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Maret"), value: "03"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("April"), value: "04"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Mei"), value: "05"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Juni"), value: "06"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Juli"), value: "07"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Agustus"), value: "08"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("September"), value: "09"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Oktober"), value: "10"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("November"), value: "11"),
    );
    menuItems.add(
      const DropdownMenuItem(child: Text("Desember"), value: "12"),
    );

    return menuItems;
  }

  List<DropdownMenuItem<String>> get yearDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems
        .add(const DropdownMenuItem(child: Text("Pilih Tahun"), value: ""));
    int tahunIni = int.parse(tahunSekarang.value);
    for (var i = 0; i < 5; i++) {
      int tahunPilih = tahunIni - i;
      menuItems.add(
        DropdownMenuItem(
            child: Text(tahunPilih.toString()), value: tahunPilih.toString()),
      );
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get categoryDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems
        .add(const DropdownMenuItem(child: Text("Pilih Kategori"), value: ""));

    for (var i = 0; i < categoryList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(categoryList[i]['name'].toString()),
            value: categoryList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  void sync(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "id": id};
      var res = await Network().post(data, '/core/expense-sync');
      var body = jsonDecode(res.body);
      if (body['success']) {
        getExpenseData("");
      } else {
        showError(body['message'].toString());
      }
    }
  }

  void expenseDelete(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "id": id};
      var res = await Network().post(data, '/core/expense-delete');
      var body = jsonDecode(res.body);
      if (body['success']) {
        getExpenseData("");
      } else {
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
