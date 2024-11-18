import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add.dart';
import 'package:buzz/pembelian/beli_produk_jadi/beli_produk_jadi_controller.dart';
import 'package:buzz/pembelian/manufacture/add/product_manufacture_add.dart';
import 'package:buzz/pembelian/manufacture/product_manufacture_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductManufacture extends StatefulWidget {
  const ProductManufacture({super.key});

  @override
  State<ProductManufacture> createState() => _ProductManufactureState();
}

class _ProductManufactureState extends State<ProductManufacture> {
  final TextEditingController _search = TextEditingController();
  final ProductManufactureController _controller =
      Get.put(ProductManufactureController());

  @override
  void initState() {
    _controller.getProductManufactureData("");
    super.initState();
  }

  Future<void> _pullRefresh() async {
    _controller.getProductManufactureData("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(
          children: [
            ComunTitle(
                title: 'Transaksi Buat \nProduk', path: "Pembelian & Produksi"),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InputSearch(
                      hint: "Cari nama Produk Manufaktur",
                      textInputType: TextInputType.text,
                      iconData: Icons.search,
                      textEditingController: _search,
                      code: "cari-product-manufacture"),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ProductManufactureAdd())?.then(
                        (value) => _controller.getProductManufactureData(""));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.green),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Jarak(tinggi: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Obx(
                  () => _controller.loading.value
                      ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _controller.productManufactureList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spasi(lebar: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Jarak(tinggi: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Transaction Date"),
                                            Text(
                                              _controller
                                                  .productManufactureList[index]
                                                      ['transaction_date']
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Product Name"),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  2,
                                              child: Text(
                                                  _controller
                                                      .productManufactureList[
                                                          index]['product']
                                                          ['name']
                                                      .toString(),
                                                  textAlign: TextAlign.right),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Price"),
                                            Text(Helper.formatAngka(_controller
                                                .productManufactureList[index]
                                                    ['total_purchase']
                                                .toString())),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Tax"),
                                            Text(_controller.productManufactureList[
                                                        index]['tax'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productManufactureList[
                                                        index]['tax']
                                                    .toString())),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Discount"),
                                            Text(_controller.productManufactureList[
                                                        index]['discount'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productManufactureList[
                                                        index]['discount']
                                                    .toString())),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[400],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Other Expense"),
                                            Text(_controller.productManufactureList[
                                                            index]
                                                        ['other_expense'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productManufactureList[
                                                        index]['other_expense']
                                                    .toString())),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Jarak(tinggi: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _controller.productManufactureList[
                                                    index]['sync_status'] ==
                                                1
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        Colors.grey.shade200),
                                                child: Icon(
                                                  Icons.check,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  _showSynctDialog(
                                                      context,
                                                      _controller
                                                          .productManufactureList[
                                                              index]['id']
                                                          .toString());
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.green),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colors
                                                          .green.shade200),
                                                  child: Icon(
                                                    Icons.sync,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                        Spasi(lebar: 15),
                                        GestureDetector(
                                          onTap: () {
                                            _showAlertDialog(
                                                context,
                                                _controller
                                                    .productManufactureList[
                                                        index]['id']
                                                    .toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: Colors.red),
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
                                    Divider(
                                      color: Colors.grey[400],
                                    )
                                  ],
                                ));
                          }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Data'),
        content:
            Text("Are your sure, do your want to delete this transaction..?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes, Delete it'),
            onPressed: () {
              ProductManufactureController _controller =
                  Get.put(ProductManufactureController());
              _controller.destroy(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}

void _showSynctDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are your sure?'),
        content:
            Text("You will syncronize this transaction into journal account ?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes, Syncronize it'),
            onPressed: () {
              ProductManufactureController _controller =
                  Get.put(ProductManufactureController());
              _controller.sync(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}