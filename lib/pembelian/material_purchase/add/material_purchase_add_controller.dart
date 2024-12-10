import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MaterialPurchaseAddController extends GetxController {
  var loading = false.obs;
  var selectedPaymentType = "0".obs;
  var bayarPakaiLoading = false.obs;
  var accountIdList = List.empty().obs;
  var selectedAccountId = "".obs;
  var materialList = List.empty().obs;
  var materialLoading = false.obs;
  var supplierList = List.empty().obs;
  var supplierLoading = false.obs;
  var selectedSupplier = "".obs;

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<void> resetPicker() async {
    _pickedFile = null;
    update();
  }

  Future<bool> upload(String ids) async {
    update();
    bool success = false;
    http.StreamedResponse response = await updateImage(_pickedFile, ids);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;
      _imagePath = message;
      print(message);
    } else {}
    update();
    Get.back();
    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            Constant.UPLOAD_IMAGE_URL + '/core/material-purchase-upload'));

    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    Map<String, String> _fields = {};
    _fields.addAll(<String, String>{'ids': ids});
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  void getMaterialData() async {
    materialLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/material-purchase-product');
      var body = jsonDecode(res.body);
      if (body['success']) {
        materialLoading(false);
        materialList.value = body['data'];
      }
    }
  }

  void getMaterialPurchaseType(String paymentType) async {
    bayarPakaiLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId, "payment_type": paymentType};
      var res = await Network().post(data, '/core/material-purchase-type');
      var body = jsonDecode(res.body);
      if (body['success']) {
        accountIdList.value = body['data'];
        bayarPakaiLoading(false);
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownPaymentType {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Tunai"), value: "0"));
    menuItems.add(const DropdownMenuItem(child: Text("Utang"), value: "1"));
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownPayment {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < accountIdList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: SizedBox(
                width: MediaQuery.of(Get.context!).size.width - 88,
                child: Text(accountIdList[i]['name'].toString())),
            value: accountIdList[i]['id'].toString() +
                "_" +
                accountIdList[i]['account_code_id'].toString()),
      );
    }

    return menuItems;
  }

  void onChangePaymentType(String paymentType) {
    getMaterialPurchaseType(paymentType);
    selectedAccountId.value = "";
  }

  void onChangeAccoundId(String accoungId) {
    selectedAccountId.value = accoungId;
    print(selectedAccountId);
  }

  List<String> get dropdownProduct {
    List<String> menuItems = [];

    for (var i = 0; i < materialList.length; i++) {
      menuItems.add(materialList[i]['material_name'] +
          ' - ' +
          materialList[i]['unit'].toString());
    }
    menuItems.add("");
    return menuItems;
  }

  void materialPurchaseStore(
      String transactionDate,
      String productCount,
      String totalPurchase,
      List<String> productId,
      List<String> purchaseAmount,
      List<String> purchaseQuantity,
      List<String> unitPrice,
      String tax,
      String discount,
      String other,
      String ref) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "userid": userId,
        "transaction_date": transactionDate,
        "account_id": selectedAccountId.value,
        "product_count": productCount,
        "total_purchase": totalPurchase,
        "product_id": productId,
        "purchase_amount": purchaseAmount,
        "quantity": purchaseQuantity,
        "unit_price": unitPrice,
        "payment_type": selectedPaymentType.value,
        "tax": tax,
        "discount": discount,
        "other_expense": other,
        "supplier_id": selectedSupplier.value,
        "reference": ref
      };
      var res = await Network().post(data, '/core/material-purchase-store');
      var body = jsonDecode(res.body);
      if (body['success']) {
        if (_pickedFile != null) {
          upload(body['id'].toString());
        }
        Get.back();
        loading(false);
      } else {
        showError(body['message'].toString());
        loading(false);
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownSupplier {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));
    for (var i = 0; i < supplierList.length; i++) {
      menuItems.add(DropdownMenuItem(
          child: Text(supplierList[i]['name'].toString()),
          value: supplierList[i]['id'].toString()));
    }

    return menuItems;
  }

  void getSupplierData() async {
    supplierLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/product-purchase-supplier');
      var body = jsonDecode(res.body);
      if (body['success']) {
        supplierLoading(false);
        supplierList.value = body['data'];
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
