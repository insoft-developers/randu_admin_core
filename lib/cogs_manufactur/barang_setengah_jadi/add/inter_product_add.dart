import 'dart:io';

import 'package:buzz/cogs_manufactur/barang_setengah_jadi/add/inter_product_add_controller.dart';
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

class InterProductAdd extends StatefulWidget {
  const InterProductAdd({super.key});

  @override
  State<InterProductAdd> createState() => _InterProductAddState();
}

class _InterProductAddState extends State<InterProductAdd> {
  final InterProductAddController _controller =
      Get.put(InterProductAddController());
  final TextEditingController _materialName = TextEditingController();
  final TextEditingController _sku = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _minStock = TextEditingController();
  final TextEditingController _idealStock = TextEditingController();
  final List<TextEditingController> _qty = [TextEditingController()];
  final List<String> _materials = [""];
  final List<String> _selectedMaterials = [""];

  @override
  void initState() {
    _controller.getCategoryData();
    _controller.getUnitData();
    _controller.getMaterialData();
    super.initState();
  }

  _addItem() {
    setState(() {
      _materials.add("");
      _selectedMaterials.add("");
      _qty.add(TextEditingController());
    });
  }

  _generateSKU(String value) {
    _sku.text = Helper().generateSKU(value);
  }

  _onInterProductSubmit() {
    List<String> _komposisi = [];
    List<String> _jumlah = [];

    for (var i = 0; i < _qty.length; i++) {
      _komposisi.add(_materials[i].isEmpty ? "" : _selectedMaterials[i]);
      _jumlah.add(_qty[i].text.isEmpty ? "0" : _qty[i].text);
    }

    _controller.interProductStore(_materialName.text, _sku.text, _minStock.text,
        _idealStock.text, _komposisi, _jumlah, _description.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(
              title: 'Tambah Barang \nSetengah Jadi',
              path: "Barang Setangah Jadi"),
          Jarak(tinggi: 20),
          Judul(
              nama: "Nama Barang Setengah Jadi",
              pad: 20,
              ukuran: 16,
              mandatory: 1),
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
                  hintText: "Nama barang setengah jadi",
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
          Judul(
              nama: "SKU barang setengah jadi",
              pad: 20,
              ukuran: 16,
              mandatory: 1),
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
          Judul(nama: "Kategori", pad: 20, ukuran: 16, mandatory: 1),
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
                            label: Text("Pilih Kategori"),
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
                            label: Text("Pilih Satuan"),
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
          Jarak(tinggi: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3 - 40,
                    child: Text("Komposisi Produk",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                      width: 25,
                      child: InkWell(
                        onTap: () {
                          _addItem();
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            )),
                      )),
                ],
              )),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _qty.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 4 / 8,
                          child: Obx(
                            () => _controller.materialLoading.value
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ShimmerText(
                                        lebar:
                                            MediaQuery.of(context).size.width,
                                        tinggi: 50),
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownSearch<String>(
                                      items: _controller.dropdownMaterial,
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                        showSearchBox: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              baseStyle:
                                                  TextStyle(fontSize: 16),
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text("Pilih Material"),
                                                border: InputBorder.none,
                                              )),
                                      onChanged: (value) {
                                        setState(() {
                                          _materials[index] = value.toString();
                                          int indexSelected = _controller
                                              .dropdownMaterial
                                              .indexOf(value!);
                                          Map<String, dynamic>
                                              _selectedComponent = _controller
                                                  .materialList[indexSelected];
                                          String _materialId =
                                              "${_selectedComponent['id']}_${_selectedComponent['product_type']}";
                                          _selectedMaterials[index] =
                                              _materialId;
                                          print(_selectedMaterials);
                                        });
                                      },
                                      selectedItem: _materials[index],
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 8,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: InputText(
                                hint: "Qty",
                                textInputType: TextInputType.number,
                                textEditingController: _qty[index],
                                obsecureText: false,
                                code: ""),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 1 / 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _materials.removeAt(index);
                                  _selectedMaterials.removeAt(index);
                                  _qty[index].clear();
                                  _qty.removeAt(index);
                                });
                              },
                              child: Container(
                                  child: Icon(Icons.delete,
                                      size: 25, color: Colors.red[900])),
                            ))
                      ],
                    ),
                  );
                }),
          ),
          Jarak(
            tinggi: 30,
          ),
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
              Text("Tips Mengisi Barang Setengah Jadi",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Jarak(tinggi: 5),
              Text(
                "Gunakan satuan porsi dalam mengisi barang setengah jadi jika produknya FnB, Misal untuk membuat 1 Porsi Nasi Goreng membutuhkan 1 Porsi Nasi Putih. Fitur ini juga bisa untuk pengelompokkan bahan baku misal: Untuk mengelompokkan Sayuran dalam Nasi Goreng tinggal ditulis 'Sayuran' dalam Nama barang setengah jadinya, sedangkan komposisinya bisa dimasukkan Sawi, Wortel, Kubis, dan lain lain. Bisa juga untuk mengelompokkan 'Rempah' dan 'Bumbu'",
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
                      _onInterProductSubmit();
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
