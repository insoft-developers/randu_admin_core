import 'package:buzz/cogs_manufactur/bahan_baku/add/bahan_baku_add.dart';
import 'package:buzz/cogs_manufactur/bahan_baku/bahan_baku_controller.dart';
import 'package:buzz/cogs_manufactur/bahan_baku/edit/bahan_baku_edit.dart';
import 'package:buzz/cogs_manufactur/barang_setengah_jadi/add/inter_product_add.dart';
import 'package:buzz/cogs_manufactur/barang_setengah_jadi/edit/inter_product_edit.dart';
import 'package:buzz/cogs_manufactur/barang_setengah_jadi/inter_product_controller.dart';
import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';

import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterProduct extends StatefulWidget {
  const InterProduct({super.key});

  @override
  State<InterProduct> createState() => _InterProductState();
}

class _InterProductState extends State<InterProduct> {
  final TextEditingController _search = TextEditingController();
  final InterProductController _controller = Get.put(InterProductController());

  @override
  void initState() {
    _controller.getInterProductList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ComunTitle(
              title: 'Daftar Barang \nSetengah Jadi', path: "COGS Manufaktur"),
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
                  Get.to(() => InterProductAdd())
                      ?.then((value) => _controller.getInterProductList(""));
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
                        itemCount: _controller.interProductList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spasi(lebar: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Jarak(tinggi: 10),
                                      Text(
                                          _controller.interProductList[index]
                                                  ['product_name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Jarak(tinggi: 10),
                                      Divider(
                                        color: Colors.grey[400],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("SKU"),
                                          Text(
                                            _controller.interProductList[index]
                                                    ['sku']
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
                                          Text("Kategori"),
                                          Text(
                                            _controller.interProductList[index]
                                                    ['category_name']
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
                                          Text("Satuan"),
                                          Text(
                                            _controller.interProductList[index]
                                                    ['unit']
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
                                          Text("Stock"),
                                          Text(
                                            Helper.formatAngka(_controller
                                                .interProductList[index]
                                                    ['stock']
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
                                          Text("Cost"),
                                          Text(
                                            Helper.formatAngka(_controller
                                                .interProductList[index]['cost']
                                                .toString()),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Jarak(tinggi: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => InterProductEdit(
                                                  dataList: _controller
                                                          .interProductList[
                                                      index]))!
                                              .then((value) => _controller
                                                  .getInterProductList(""));
                                        },
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
                                        onTap: () {
                                          _showAlertDialog(
                                              context,
                                              _controller
                                                  .interProductList[index]['id']
                                                  .toString(),
                                              _controller
                                                  .interProductList[index]
                                                      ['product_name']
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

void _showAlertDialog(BuildContext context, String id, String name) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hapus Barang Setengah Jadi'),
        content:
            Text("Apakah anda yakin ingin menghapus bahan baku [ ${name} ] ?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Hapus'),
            onPressed: () {
              InterProductController _controller =
                  Get.put(InterProductController());
              _controller.interProductDelete(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
