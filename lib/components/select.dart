import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
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
          onChanged: (String? newValue) {
            if (code == 'tipe-produk') {
              ProductAddController _controller =
                  Get.put(ProductAddController());
              _controller.onChangeProductType(newValue.toString());
            }
          },
          items: menuItems),
    );
  }
}
