import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/manajemen_produk/product_list/detail/product_detail_controller.dart';
import 'package:buzz/manajemen_produk/product_list/detail/slider.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:buzz/utils/helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: Column(
              children: [
                Jarak(tinggi: 30),
                Obx(
                  () => _controller.loading.value
                      ? ShimmerText(
                          lebar: MediaQuery.of(context).size.width - 40,
                          tinggi: 35)
                      : SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                              _controller.productDetail['name'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                ),
                Jarak(tinggi: 20),
                Obx(
                  () => _controller.imageList.isEmpty
                      ? const SizedBox()
                      : CarouselSlider(
                          options: CarouselOptions(height: 120.0),
                          items: _controller.imageList.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2.0),
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          Constant.PRODUCT_IMAGE + i,
                                          fit: BoxFit.cover),
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                ),
                Jarak(tinggi: 20),
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
                        : Text(_controller.categoryName.value))
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
                ),
                Jarak(tinggi: 20),
                Text("Varian", style: TextStyle(fontWeight: FontWeight.bold)),
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6,
                        child: Text("Group"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6,
                        child: Text("Nama"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6,
                        child: Text("SKU"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6,
                        child: Text("Qty"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6 - 15,
                        child: Text("S.Pick"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 6 - 15,
                        child: Text("Max"),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Obx(
                  () => _controller.productVarian.isEmpty
                      ? Text("Tidak ada varian")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _controller.productVarian.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 6,
                                  child: Text(_controller.productVarian[index]
                                          ['varian_group']
                                      .toString()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 6,
                                  child: Text(_controller.productVarian[index]
                                          ['varian_name']
                                      .toString()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 6,
                                  child: Text(_controller.productVarian[index]
                                              ['sku'] ==
                                          null
                                      ? '-'
                                      : _controller.productVarian[index]['sku']
                                          .toString()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 6,
                                  child: Text(Helper.formatAngka(_controller
                                      .productVarian[index]['varian_price']
                                      .toString())),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          6 -
                                      15,
                                  child: Text(_controller.productVarian[index]
                                          ['single_pick']
                                      .toString()),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          6 -
                                      15,
                                  child: Text(_controller.productVarian[index]
                                          ['max_quantity']
                                      .toString()),
                                ),
                              ],
                            );
                          }),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Jarak(tinggi: 20),
                Text("Komposisi Bahan Baku",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 4 - 30,
                        child: Text("Nama bahan"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 4,
                        child: Text("Satuan"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 4,
                        child: Text("Qty"),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Obx(
                  () => _controller.productComposition.isEmpty
                      ? Text("Produk beli jadi tidak menggunakan komposisi")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _controller.productComposition.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                          2 /
                                          4 -
                                      30,
                                  child: Text(_controller
                                      .productComposition[index]
                                          ['material_name']
                                      .toString()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 4,
                                  child: Text(_controller
                                      .productComposition[index]['unit']
                                      .toString()),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 4,
                                  child: Text(_controller
                                      .productComposition[index]['quantity']
                                      .toString()),
                                ),
                              ],
                            );
                          }),
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ));
  }
}
