import 'package:buzz/cogs_manufactur/bahan_baku/add/bahan_baku_add.dart';
import 'package:buzz/cogs_manufactur/bahan_baku/bahan_baku_controller.dart';
import 'package:buzz/cogs_manufactur/bahan_baku/edit/bahan_baku_edit.dart';
import 'package:buzz/components/input_search.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/shimmer_list.dart';
import 'package:buzz/components/spasi.dart';

import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBaku extends StatefulWidget {
  const BahanBaku({super.key});

  @override
  State<BahanBaku> createState() => _BahanBakuState();
}

class _BahanBakuState extends State<BahanBaku> {
  final TextEditingController _search = TextEditingController();
  final BahanBakuController _bahanBakuController =
      Get.put(BahanBakuController());

  @override
  void initState() {
    _bahanBakuController.getMaterialList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ComunTitle(title: 'Daftar Bahan Baku', path: "COGS Manufaktur"),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InputSearch(
                    hint: "Cari nama bahan baku",
                    textInputType: TextInputType.text,
                    iconData: Icons.search,
                    textEditingController: _search,
                    code: "cari-material"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => BahanBakuAdd())?.then(
                      (value) => _bahanBakuController.getMaterialList(""));
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
                () => _bahanBakuController.loading.value
                    ? ShimmerList(tinggi: 110, jumlah: 10, pad: 0)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _bahanBakuController.materialList.length,
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
                                          _bahanBakuController
                                              .materialList[index]
                                                  ['material_name']
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
                                            _bahanBakuController
                                                .materialList[index]['sku']
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
                                            _bahanBakuController
                                                .materialList[index]
                                                    ['material_category']
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
                                            _bahanBakuController
                                                .materialList[index]['unit']
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
                                            Helper.formatAngka(
                                                _bahanBakuController
                                                    .materialList[index]
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
                                            Helper.formatAngka(
                                                _bahanBakuController
                                                    .materialList[index]['cost']
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
                                          Text("Supplier"),
                                          Text(
                                            _bahanBakuController
                                                .materialList[index]['supplier']
                                                    ['name']
                                                .toString(),
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
                                          Get.to(() => BahanBakuEdit(
                                                  dataList: _bahanBakuController
                                                      .materialList[index]))!
                                              .then((value) =>
                                                  _bahanBakuController
                                                      .getMaterialList(""));
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
                                              _bahanBakuController
                                                  .materialList[index]['id']
                                                  .toString(),
                                              _bahanBakuController
                                                  .materialList[index]
                                                      ['material_name']
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
        title: const Text('Hapus Bahan Baku'),
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
              BahanBakuController _controller = Get.put(BahanBakuController());
              _controller.bahanBakuDelete(id);
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
