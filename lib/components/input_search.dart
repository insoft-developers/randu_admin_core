// ignore: must_be_immutable
import 'package:buzz/cogs_manufactur/bahan_baku/bahan_baku_controller.dart';
import 'package:buzz/cogs_manufactur/barang_setengah_jadi/inter_product_controller.dart';
import 'package:buzz/manajemen_produk/category/product_category_controller.dart';
import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
import 'package:buzz/manajemen_produk/product_list/product_list_controller.dart';
import 'package:buzz/pembelian/beli_produk_jadi/beli_produk_jadi_controller.dart';
import 'package:buzz/pembelian/manufacture/product_manufacture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputSearch extends StatelessWidget {
  String hint;
  TextInputType textInputType;
  IconData iconData;
  TextEditingController textEditingController;
  String code;

  InputSearch(
      {Key? key,
      required this.hint,
      required this.textInputType,
      required this.iconData,
      required this.textEditingController,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey, width: 0.5),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 50, color: Colors.white),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {
          if (code == 'product-category') {
            ProductCategoryController _productCategory =
                Get.put(ProductCategoryController());
            _productCategory.cariKategori(value.toString());
          } else if (code == 'cari-produk') {
            ProductListController _productListController =
                Get.put(ProductListController());
            _productListController.cariProduct(value.toString());
          } else if (code == 'cari-kategori-produk') {
            ProductAddController _controller = Get.put(ProductAddController());
            _controller.categorySearch(value.toString());
          } else if (code == 'cari-satuan-produk') {
            ProductAddController _controller = Get.put(ProductAddController());
            _controller.unitSearch(value.toString());
          } else if (code == 'cari-material') {
            BahanBakuController _controller = Get.put(BahanBakuController());
            _controller.materialSearch(value.toString());
          } else if (code == 'cari-inter-product') {
            InterProductController _controller =
                Get.put(InterProductController());
            _controller.materialSearch(value.toString());
          } else if (code == 'cari-product-manufacture') {
            ProductManufactureController _controller =
                Get.put(ProductManufactureController());
            _controller.productSearch(value.toString());
          } else if (code == 'cari-product-purchase') {
            BeliProdukJadiController _controller =
                Get.put(BeliProdukJadiController());
            _controller.productPurchaseFilter(value.toString());
          }
        },
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Icon(iconData),
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
