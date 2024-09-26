import 'package:buzz/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VarianController extends GetxController {
  var singlePickValue = false.obs;
  var loading = false.obs;
  var varianList = List.empty().obs;

  void onClickSinglePick(bool value) {
    singlePickValue.value = value;
  }

  void tambahVarian(String varianGroup, String varianName, String sku,
      int harga, int maxQuantity) async {
    if (varianGroup.isEmpty) {
      showError("Varian Group tidak boleh kosong");
    } else if (varianName.isEmpty) {
      showError("Varian Name tidak boleh kosong");
    } else {
      await SQLHelper.tambahVarian(varianGroup, varianName, sku, harga,
          singlePickValue.value ? 1 : 0, maxQuantity);
      refreshVarians();
      singlePickValue(false);
      Get.back();
    }
  }

  void updateVarian(int id, String varianGroup, String varianName, String sku,
      int harga, int maxQuantity) async {
    if (varianGroup.isEmpty) {
      showError("Varian Group tidak boleh kosong");
    } else if (varianName.isEmpty) {
      showError("Varian Name tidak boleh kosong");
    } else {
      await SQLHelper.updateVarian(id, varianGroup, varianName, sku, harga,
          singlePickValue.value ? 1 : 0, maxQuantity);
      refreshVarians();
      singlePickValue(false);
      Get.back();
    }
  }

  Future<void> refreshVarians() async {
    loading(true);
    final data = await SQLHelper.getVarians();
    varianList.value = data;

    loading(false);
  }

  void clearVarians() async {
    await SQLHelper.clearVarian();
  }

  void deleteVarian(int id) async {
    await SQLHelper.deleteVarian(id);
    refreshVarians();
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
