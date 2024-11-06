import 'dart:async';
import 'dart:convert';

import 'package:buzz/database/db_helper.dart';
import 'package:buzz/manajemen_produk/product_list/add/image_upload_provider.dart';
import 'package:buzz/network/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductEditController extends GetxController {
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

  var productDetail = <String, dynamic>{}.obs;
  var productVarian = List.empty().obs;
  var productComposition = List.empty().obs;
  var categoryName = "".obs;
  var imageList = List.empty().obs;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;

  void selectMultipleImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar('Fail', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    selectedFileCount.value = listImagePath.length;
  }

  void deleteImage(int index) {
    images?.removeAt(index);
    listImagePath.removeAt(index);
    selectedFileCount.value = listImagePath.length;
  }

  void uploadImage(String id) {
    if (selectedFileCount.value > 0) {
      Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false);
      ImageUploadProvider()
          .uploadImage(listImagePath, '/core/product-image-upload', id)
          .then((resp) {
        Get.back();
        if (resp == 'success') {
          Get.snackbar('Success', 'Images Uploaded',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          images = [];
          listImagePath = [];
          selectedFileCount.value = listImagePath.length;
        } else {}
      }).onError((error, stackTrace) {
        Get.back();
        Get.snackbar('Fail', 'Something went wrong!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } else {
      Get.snackbar('Fail', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void productStore(
      int id,
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
        "id": id,
        "category_id": selectedCategoryId.value,
        "code": code,
        "sku": sku,
        "barcode": barcode,
        "name": name,
        "price": price,
        "cost": cost,
        "unit": selectedUnitName.value,
        "stock_alert": selectedBufferedStock.value == "1" ? stockAlert : 0,
        "user_id": userId,
        "is_variant": selectedProductType.value,
        "is_manufactured": selectedProductMadeOf.value,
        "buffered_stock": selectedBufferedStock.value,
        "weight": weight,
        "description": description,
        "created_by":
            selectedProductMadeOf.value == "2" ? radioGroupValue.value : 0,
        "price_ta": priceTa,
        "price_mp": priceMp,
        "price_cus": priceCus
      };
      var res = await Network().post(data, '/core/product-update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        if (selectedProductType.value == "2") {
          varianItemStore(body['id']);
        }
        if (selectedProductMadeOf.value == "2") {
          productItemStore(body['id']);
        }
        if (selectedFileCount.value > 0) {
          uploadImage(body['id'].toString());
        }
        storeLoading(false);
        Get.back();
      } else {
        showError(body['message'].toString());
        storeLoading(false);
      }
    }
  }

  void onChangeRadio(int nilai) {
    radioGroupValue.value = nilai;
    if (nilai == 1) {
      selectedBufferedStock.value = "0";
    } else if (nilai == 0) {
      selectedBufferedStock.value = "1";
    }
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

  void varianItemStore(int transactionId) async {
    final data = await SQLHelper.getVarians();

    for (var i = 0; i < data.length; i++) {
      sendVarianTiem(
          transactionId,
          data[i]['varian_group'].toString(),
          data[i]['varian_name'].toString(),
          data[i]['sku'].toString(),
          data[i]['harga'],
          data[i]['single_pick'],
          data[i]['max_quantity']);
    }

    await SQLHelper.clearVarian();
    loading(false);
  }

  void sendVarianTiem(
      int id,
      String varianGroup,
      String varianName,
      String varianSku,
      int varianPrice,
      int singlePick,
      int maxQuantity) async {
    var data = {
      "id": id,
      "varian_group": varianGroup,
      "varian_name": varianName,
      "varian_sku": varianSku,
      "varian_price": varianPrice,
      "single_pick": singlePick,
      "max_quantity": maxQuantity
    };
    var res = await Network().post(data, '/core/product-varian-store');
    var body = jsonDecode(res.body);
    if (body['success']) {
      print("varian sent");
    }
  }

  void productItemStore(int transactionId) async {
    final data = await SQLHelper.getProducts();

    for (var i = 0; i < data.length; i++) {
      sendProductItem(transactionId, data[i]['product_id'], data[i]['quantity'],
          data[i]['product_type']);
    }

    await SQLHelper.clearProduct();
    loading(false);
  }

  void sendProductItem(
      int id, int productId, int quantity, int productType) async {
    var data = {
      "id": id,
      "product_id": productId,
      "quantity": quantity,
      "product_type": productType,
    };
    var res = await Network().post(data, '/core/product-composition-store');
    var body = jsonDecode(res.body);
    if (body['success']) {
      print("item product added");
    }
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }

  // ============================= INIT DATA ==============================

  Future getProductDetail(int id) async {
    loading(true);
    var data = {"id": id};
    var res = await Network().post(data, '/core/product-detail');
    var body = jsonDecode(res.body);
    if (body['success']) {
      loading(false);
      productDetail.value = body['data'];
      productVarian.value = body['varian'];
      productComposition.value = body['komposisi'];
      categoryName.value = body['category_name'];
      imageList.value = body['images'];
      if (productDetail['is_variant'] == 2) {
        clearVarian();
        varianInsert();
      }

      if (productDetail['is_manufactured'] == 2) {
        clearMaterial();
        compositionInsert();
      }

      print(productComposition);
    }
  }

  void clearVarian() async {
    await SQLHelper.clearVarian();
  }

  void clearMaterial() async {
    await SQLHelper.clearProduct();
  }

  void varianInsert() async {
    for (var i = 0; i < productVarian.length; i++) {
      tambahVarian(
          productVarian[i]['varian_group'],
          productVarian[i]['varian_name'],
          productVarian[i]['sku'] == null ? '-' : productVarian[i]['sku'],
          productVarian[i]['varian_price'],
          productVarian[i]['single_pick'] == null
              ? 0
              : productVarian[i]['single_pick'],
          productVarian[i]['max_quantity'] == null
              ? 0
              : productVarian[i]['max_quantity']);
    }
  }

  void compositionInsert() async {
    for (var i = 0; i < productComposition.length; i++) {
      attachComposition(
          productComposition[i]['material_id'],
          productComposition[i]['material_name'],
          productComposition[i]['unit'],
          productComposition[i]['product_type'],
          productComposition[i]['quantity']);
    }
  }

  void tambahVarian(String varianGroup, String varianName, String sku,
      int harga, int singlePick, int maxQuantity) async {
    await SQLHelper.tambahVarian(
        varianGroup, varianName, sku, harga, singlePick, maxQuantity);
  }

  void attachComposition(int productId, String productName, String satuan,
      int productType, int quantity) async {
    await SQLHelper.tambahProduk(
        productId, productName, satuan, productType, quantity);
  }
}
