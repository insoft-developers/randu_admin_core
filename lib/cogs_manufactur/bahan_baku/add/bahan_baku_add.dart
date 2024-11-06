import 'dart:io';

import 'package:buzz/cogs_manufactur/bahan_baku/add/bahan_baku_add_controller.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/text_area.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBakuAdd extends StatefulWidget {
  const BahanBakuAdd({super.key});

  @override
  State<BahanBakuAdd> createState() => _BahanBakuAddState();
}

class _BahanBakuAddState extends State<BahanBakuAdd> {
  final BahanBakuAddController _controller = Get.put(BahanBakuAddController());
  final TextEditingController _materialName = TextEditingController();
  final TextEditingController _sku = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _minStock = TextEditingController();
  final TextEditingController _idealStock = TextEditingController();

  @override
  void initState() {
    _controller.getCategoryData();
    _controller.getUnitData();
    _controller.getSupplierData();
    super.initState();
  }

  _generateSKU(String value) {
    _sku.text = Helper().generateSKU(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Tambah Bahan Baku', path: "Bahan Baku"),
          Jarak(tinggi: 20),
          Judul(nama: "Nama Bahan Baku", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 2.0),
              ),
              child: TextField(
                controller: _materialName,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Nama bahan baku",
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  _generateSKU(value.toString());
                },
              ),
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "SKU Bahan baku", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: InputText(
                hint: "Masukkan SKU",
                textInputType: TextInputType.text,
                textEditingController: _sku,
                obsecureText: false,
                code: ""),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Kategori material", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.categoryLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                        lebar: MediaQuery.of(context).size.width, tinggi: 50),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownSearch<String>(
                      items: _controller.dropdownCategory,
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(fontSize: 16),
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          )),
                      onChanged: (value) {
                        int indexSelected =
                            _controller.dropdownCategory.indexOf(value!);
                        String categoryId = _controller
                            .categoryList[indexSelected]['id']
                            .toString();
                        _controller.onChangeCategory(
                            categoryId, value.toString());
                      },
                      selectedItem: _controller.selectedCategory.value,
                    ),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Satuan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.satuanLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                        lebar: MediaQuery.of(context).size.width, tinggi: 50),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownSearch<String>(
                      items: _controller.dropdownSatuan,
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(fontSize: 16),
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          )),
                      onChanged: (value) {
                        _controller.onChangeSatuan(value.toString());
                      },
                      selectedItem: _controller.selectedSatuan.value,
                    ),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Supplier", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.supplierLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                        lebar: MediaQuery.of(context).size.width, tinggi: 50),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownSearch<String>(
                      items: _controller.dropdownSupplier,
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(fontSize: 16),
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          )),
                      onChanged: (value) {
                        int indexSelected =
                            _controller.dropdownSupplier.indexOf(value!);
                        String supplierId = _controller
                            .supplierList[indexSelected]['id']
                            .toString();
                        _controller.onChangeSupplier(
                            supplierId, value.toString());
                      },
                      selectedItem: _controller.selectedSupplier.value,
                    ),
                  ),
          ),
          Jarak(tinggi: 30),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 2,
                  child: Judul(
                      nama: "Min Stock", pad: 20, ukuran: 16, mandatory: 0)),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 2,
                  child: Judul(
                      nama: "Ideal Stck", pad: 20, ukuran: 16, mandatory: 0)),
            ],
          ),
          Jarak(tinggi: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputText(
                      hint: "Minimal Stock",
                      textInputType: TextInputType.number,
                      textEditingController: _minStock,
                      obsecureText: false,
                      code: ""),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputText(
                      hint: "Ideal Stock",
                      textInputType: TextInputType.number,
                      textEditingController: _idealStock,
                      obsecureText: false,
                      code: ""),
                ),
              ),
            ],
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Keterangan", pad: 20, ukuran: 16, mandatory: 0),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextArea(
                hint: "Masukkan keterangan",
                textEditingController: _description,
                maxline: 5),
          ),
          Jarak(tinggi: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Tips Mengisi Bahan Baku",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Jarak(tinggi: 5),
              Text(
                "Gunakan satuan baha baku dalam takaran yang dipakai dalam resep/produksi barang. Contohnya untuk membuat Roti butuh 300 gram tepung terigu, maka masukkan satuan gram(gr) untuk bahan baku tepung terigu. Meskipun saat berbelanja di Supplier nanti satuannya adalah kilogram (kg)",
                textAlign: TextAlign.justify,
              ),
              Jarak(tinggi: 10),
            ]),
          ),
          Jarak(tinggi: 30),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _controller.bahanBakuStore(_materialName.text, _sku.text,
                          _minStock.text, _idealStock.text, _description.text);
                    },
                    splashColor: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.withOpacity(0.8)),
                        child: Text("Simpan",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16))),
                  )),
          ),
          Jarak(tinggi: 100),
        ],
      ),
    );
  }
}
