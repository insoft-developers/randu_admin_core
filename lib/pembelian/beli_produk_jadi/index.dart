import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add.dart';
import 'package:buzz/pembelian/beli_produk_jadi/beli_produk_jadi_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeliProduk extends StatefulWidget {
  const BeliProduk({super.key});

  @override
  State<BeliProduk> createState() => _BeliProdukState();
}

class _BeliProdukState extends State<BeliProduk> {
  final TextEditingController _search = TextEditingController();
  final BeliProdukJadiController _controller =
      Get.put(BeliProdukJadiController());

  @override
  void initState() {
    _controller.getProductPurchaseList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ComunTitle(
              title: 'Transaksi Beli \nProduk', path: "Pembelian & Produksi"),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InputSearch(
                    hint: "Cari nama barang setengah jadi",
                    textInputType: TextInputType.text,
                    iconData: Icons.search,
                    textEditingController: _search,
                    code: "cari-inter-product"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => BeliProdukAdd())
                      ?.then((value) => _controller.getProductPurchaseList(""));
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
                        itemCount: _controller.productPurchaseList.length,
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
                                                .productPurchaseList[index]
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
                                          Text("Total Price"),
                                          Text(
                                            Helper.formatAngka(_controller
                                                .productPurchaseList[index]
                                                    ['total_purchase']
                                                .toString()),
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
                                          Text("Tax"),
                                          Text(
                                            _controller.productPurchaseList[
                                                        index]['tax'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productPurchaseList[index]
                                                        ['tax']
                                                    .toString()),
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
                                          Text("Discount"),
                                          Text(
                                            _controller.productPurchaseList[
                                                        index]['discount'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productPurchaseList[index]
                                                        ['discount']
                                                    .toString()),
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
                                          Text("Other Expense"),
                                          Text(
                                            _controller.productPurchaseList[
                                                            index]
                                                        ['other_expense'] ==
                                                    null
                                                ? "0"
                                                : Helper.formatAngka(_controller
                                                    .productPurchaseList[index]
                                                        ['other_expense']
                                                    .toString()),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: ExpansionTile(
                                          title: Text("Produk Detail",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      82,
                                                  child: ListView.builder(
                                                      physics:
                                                          const ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _controller
                                                          .productPurchaseList[
                                                              index][
                                                              'product_purchase_item']
                                                          .length,
                                                      itemBuilder:
                                                          (context, index2) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Text(
                                                                  _controller
                                                                      .productPurchaseList[
                                                                          index]
                                                                          [
                                                                          'product_purchase_item']
                                                                          [
                                                                          index2]
                                                                          [
                                                                          'product']
                                                                          [
                                                                          'name']
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Jarak(tinggi: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Spasi(
                                                                      lebar: 8),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context).size.width *
                                                                            2 /
                                                                            8 -
                                                                        10,
                                                                    child: Text(
                                                                      _controller
                                                                              .productPurchaseList[index]['product_purchase_item'][index2]['quantity']
                                                                              .toString() +
                                                                          ' x ',
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        2 /
                                                                        8,
                                                                    child: Text(
                                                                      Helper.formatAngka(_controller
                                                                          .productPurchaseList[
                                                                              index]
                                                                              [
                                                                              'product_purchase_item']
                                                                              [
                                                                              index2]
                                                                              [
                                                                              'unit_price']
                                                                          .toString()),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        2 /
                                                                        8,
                                                                    child: Text(
                                                                      Helper.formatAngka(_controller
                                                                          .productPurchaseList[
                                                                              index]
                                                                              [
                                                                              'product_purchase_item']
                                                                              [
                                                                              index2]
                                                                              [
                                                                              'purchase_amount']
                                                                          .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                color: Colors
                                                                    .grey[400],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Jarak(tinggi: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _controller.productPurchaseList[index]
                                                  ['sync_status'] ==
                                              1
                                          ? Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.grey.shade200),
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
                                                        .productPurchaseList[
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
                                                    color:
                                                        Colors.green.shade200),
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
                                                  .productPurchaseList[index]
                                                      ['id']
                                                  .toString());
                                        },
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
              BeliProdukJadiController _controller =
                  Get.put(BeliProdukJadiController());
              _controller.productPurchaseDelete(id);
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
              BeliProdukJadiController _controller =
                  Get.put(BeliProdukJadiController());
              _controller.sync(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
