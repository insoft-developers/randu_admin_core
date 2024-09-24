// ignore_for_file: deprecated_member_use

import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/manajemen_produk/product_list/detail/index.dart';
import 'package:buzz/manajemen_produk/product_list/product_list_controller.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductListController _controller = Get.put(ProductListController());

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    _controller.getProductList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ComunTitle(title: 'Daftar Produk', path: "Manajemen Produk"),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: InputSearch(
                  hint: "Cari produk",
                  textInputType: TextInputType.text,
                  iconData: Icons.search,
                  textEditingController: _search,
                  code: "cari-produk"),
            ),
            Jarak(tinggi: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => _controller.loading.value
                    ? ShimmerList(tinggi: 280, jumlah: 4, pad: 0)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _controller.productList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      _controller.productList[index]['foto'] !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                Constant.PRODUCT_IMAGE +
                                                    _controller
                                                        .productList[index]
                                                            ['foto']
                                                        .toString(),
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                  "assets/product_placeholder.png",
                                                  width: 90,
                                                  height: 90),
                                            ),
                                      Spasi(lebar: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                160,
                                            child: Text(
                                                _controller.productList[index]
                                                        ['name']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Jarak(tinggi: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.code, size: 15),
                                              Spasi(lebar: 5),
                                              Text(_controller
                                                  .productList[index]['code']
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.category, size: 15),
                                              Spasi(lebar: 5),
                                              Text(_controller
                                                  .productList[index]
                                                      ['category_name']
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.check_box_sharp,
                                                  size: 15),
                                              Spasi(lebar: 5),
                                              Text(_controller
                                                  .productList[index]['unit']
                                                  .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Jarak(tinggi: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Stok"),
                                      Text(_controller.productList[index]
                                                  ['quantity'] !=
                                              null
                                          ? _controller.productList[index]
                                                      ['quantity'] >
                                                  0
                                              ? Helper.formatAngka(_controller
                                                      .productList[index]
                                                          ['quantity']
                                                      .toString()) +
                                                  ' ' +
                                                  _controller.productList[index]
                                                          ['unit']
                                                      .toString()
                                              : 'Stok habis'
                                          : "Tidak ada stok"),
                                    ],
                                  ),
                                  Jarak(tinggi: 5),
                                  const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Harga Jual"),
                                      Text(Helper.formatAngka(_controller
                                          .productList[index]['price']
                                          .toString())),
                                    ],
                                  ),
                                  Jarak(tinggi: 5),
                                  const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Harga Pokok Penjualan (HPP)"),
                                      Text(Helper.formatAngka(_controller
                                          .productList[index]['cost']
                                          .round()
                                          .toString())),
                                    ],
                                  ),
                                  Jarak(tinggi: 5),
                                  const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nilai Barang"),
                                      Text(_controller.productList[index]
                                                  ['quantity'] !=
                                              null
                                          ? Helper.formatAngka((_controller
                                                      .productList[index]
                                                          ['cost']
                                                      .round() *
                                                  _controller.productList[index]
                                                      ['quantity'])
                                              .toString())
                                          : ''),
                                    ],
                                  ),
                                  Jarak(tinggi: 5),
                                  const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Margin"),
                                      Text(Helper.formatAngka((_controller
                                                  .productList[index]['price'] -
                                              _controller.productList[index]
                                                  ['cost'])
                                          .toString())),
                                    ],
                                  ),
                                  Jarak(tinggi: 5),
                                  const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  Jarak(tinggi: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("% Margin"),
                                      Text(_controller.productList[index]
                                                      ['cost'] !=
                                                  null &&
                                              _controller.productList[index]
                                                      ['cost'] !=
                                                  0
                                          ? Helper.roundNumber(
                                                      ((_controller.productList[
                                                                      index]
                                                                  ['price'] -
                                                              _controller
                                                                      .productList[index]
                                                                  ['cost']) /
                                                          _controller.productList[
                                                              index]['cost'] *
                                                          100),
                                                      2)
                                                  .toString() +
                                              "%"
                                          : ""),
                                    ],
                                  ),
                                  Jarak(tinggi: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetail(
                                                id: _controller
                                                    .productList[index]['id'],
                                              ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.green.shade200),
                                          child: Icon(
                                            Icons.list,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Spasi(lebar: 15),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.orange),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.orange.shade200),
                                          child: Icon(
                                            Icons.edit,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Spasi(lebar: 15),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border:
                                                  Border.all(color: Colors.red),
                                              color: Colors.red.shade200),
                                          child: Icon(
                                            Icons.delete,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Spasi(lebar: 5),
                                    ],
                                  ),
                                ],
                              ));
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
