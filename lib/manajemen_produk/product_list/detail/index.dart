import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/manajemen_produk/product_list/detail/product_detail_controller.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  int id;
  ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductDetailController _controller =
      Get.put(ProductDetailController());

  @override
  void initState() {
    _controller.getProductDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewAppBar(),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Jarak(tinggi: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nama Produk"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['name'].toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kategori"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['category_id']
                            .toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Code"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['code'].toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SKU"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['sku'].toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Harga Jual"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(
                            _controller.productDetail['price'].toString())))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Harga Jual (Delivery)"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(
                            _controller.productDetail['price'].toString())))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Harga Jual (Marketplace)"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(
                            _controller.productDetail['price'].toString())))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Harga Jual (Custom Price)"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(
                            _controller.productDetail['price'].toString())))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("HPP (COGS)"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(
                            _controller.productDetail['cost'].toString())))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Satuan"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['unit'].toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Stok"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(Helper.formatAngka(_controller
                                .productDetail['quantity']
                                .toString()) +
                            ' ' +
                            _controller.productDetail['unit'].toString()))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jenis Produk"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['is_variant'] == 2
                            ? "Varian Produk"
                            : "Single Prouk"))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Model Produk"),
                    Obx(() => _controller.loading.value
                        ? ShimmerText(
                            lebar:
                                MediaQuery.of(context).size.width * 1 / 2 - 30,
                            tinggi: 20)
                        : Text(_controller.productDetail['is_manufactured'] == 2
                            ? "Produk Manufaktur"
                            : "Produk Beli Jadi"))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
