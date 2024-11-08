import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
import 'package:buzz/manajemen_produk/product_list/edit/product_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectData extends StatelessWidget {
  String defValue;
  String label;
  List<DropdownMenuItem<String>> menuItems;
  String code;
  SelectData(
      {Key? key,
      required this.defValue,
      required this.label,
      required this.menuItems,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          value: defValue,
          onChanged: label == "readonly"
              ? null
              : (String? newValue) {
                  if (code == 'tipe-produk') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.onChangeProductType(newValue.toString());
                  } else if (code == 'buffered-stock') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.selectedBufferedStock.value =
                        newValue.toString();
                  } else if (code == 'manufactured') {
                    ProductAddController _controller =
                        Get.put(ProductAddController());
                    _controller.selectedProductMadeOf.value =
                        newValue.toString();
                  } else if (code == 'tipe-produk-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.onChangeProductType(newValue.toString());
                  } else if (code == 'buffered-stock-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.selectedBufferedStock.value =
                        newValue.toString();
                  } else if (code == 'manufactured-edit') {
                    ProductEditController _controller =
                        Get.put(ProductEditController());
                    _controller.selectedProductMadeOf.value =
                        newValue.toString();
                  }
                },
          items: menuItems),
    );
  }
}
