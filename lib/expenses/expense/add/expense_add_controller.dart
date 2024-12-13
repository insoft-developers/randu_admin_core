import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:buzz/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseAddController extends GetxController {
  var loading = false.obs;
  var categoryList = List.empty().obs;
  var selectedCategory = "".obs;
  var categoryLoading = false.obs;

  var accountList = List.empty().obs;
  var selectedAccount = "".obs;
  var accountLoading = false.obs;

  var accountToList = List.empty().obs;
  var selectedAccountTo = "".obs;
  var accountToLoading = false.obs;

  final AppConst controller = Get.put(AppConst());

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

  void getAccountData() async {
    accountLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/expense-account-from');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountList.value = body['data'];
        accountLoading(false);
      }
    }
  }

  void getAccountToData() async {
    accountToLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/expense-account-to');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountToList.value = body['data'];
        accountToLoading(false);
      }
    }
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

  List<DropdownMenuItem<String>> get accountDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < accountList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(accountList[i]['name'].toString()),
            value: accountList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get accounTotDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < accountToList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(accountToList[i]['name'].toString()),
            value: accountToList[i]['id'].toString() +
                '_' +
                accountToList[i]['account_code_id'].toString()),
      );
    }

    return menuItems;
  }

  void expenseStore(
      String transactionDate, String jumlah, String keterangan) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "date": transactionDate,
        "expense_category_id": selectedCategory.value,
        "dari": selectedAccount.value,
        "untuk": selectedAccountTo.value,
        "amount": jumlah,
        "keterangan": keterangan
      };
      var res = await Network().post(data, '/core/expense-store');
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
