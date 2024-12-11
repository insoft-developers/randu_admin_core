import 'dart:io';

import 'package:buzz/adjustment/add/adjustment_add_controller.dart';
import 'package:buzz/components/input_display.dart';
import 'package:buzz/components/input_readonly.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/spasi.dart';

import 'package:buzz/new_appbar.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdjustmentAdd extends StatefulWidget {
  const AdjustmentAdd({super.key});

  @override
  State<AdjustmentAdd> createState() => _AdjustmentAddState();
}

class _AdjustmentAddState extends State<AdjustmentAdd> {
  final AdjustmentAddController _controller =
      Get.put(AdjustmentAddController());
  final TextEditingController _tanggal = TextEditingController();

  final List<String> _products = [""];
  final List<String> _selectedProducts = [""];
  final List<TextEditingController> _quantities = [TextEditingController()];
  final List<String> _types = [""];
  final List<String> _selectedTypes = ["addition"];

  @override
  void initState() {
    var now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _tanggal.text = formattedDate;
    _controller.selectedCategory.value = "";
    _controller.selectedAccount.value = "";

    _controller.getCategoryData();
    _controller.getAccountData();
    _controller.getProductData();
    super.initState();
  }

  _addItem() {
    setState(() {
      _products.add("");
      _selectedProducts.add("");
      _quantities.add(TextEditingController());
      _types.add("");
      _selectedTypes.add("addition");
    });
    print(_selectedTypes);
  }

  _onDelete(int index) {
    setState(() {
      _products.removeAt(index);
      _selectedProducts.removeAt(index);
      _quantities[index].clear();
      _quantities.removeAt(index);
      _types.removeAt(index);
      _selectedTypes.removeAt(index);
    });

    print(_selectedTypes);
  }

  _onDateChange() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2101));
    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
    setState(() {
      _tanggal.text = formattedDate;
    });
  }

  _adjustmentStore() {
    List<String> quantity_array = [];

    for (var i = 0; i < _quantities.length; i++) {
      quantity_array.add(_quantities[i].text);
    }
    _controller.adjustmentStore(
        _tanggal.text, _selectedProducts, quantity_array, _selectedTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Penyesuaian Barang\nDagang', path: "Penyesuaian"),
          Jarak(tinggi: 20),
          Judul(nama: "Tanggal Transaksi", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 3 - 10,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            height: 50,
            child: TextField(
              controller: _tanggal,
              decoration: const InputDecoration(
                hintText: "Tanggal",
                border: InputBorder.none,
                filled: false,
              ),
              readOnly: true,
              onTap: () {
                _onDateChange();
              },
            ),
          ),
          Jarak(tinggi: 30),
          Judul(
              nama: "Kategori Penyesuaian", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.categoryLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedCategory.value,
                  label: "",
                  menuItems: _controller.categoryDropdown,
                  code: 'adjustment-add-category',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Penyesuaian Untuk", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.categoryLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedAccount.value,
                  label: "",
                  menuItems: _controller.accountDropdown,
                  code: 'adjustment-add-account',
                )),
          Jarak(tinggi: 30),
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
                    child: Text("Masukkan produk penyesuaian",
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
                physics: const ScrollPhysics(),
                itemCount: _quantities.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Obx(
                              () => _controller.productLoading.value
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
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
                                              BorderRadius.circular(2)),
                                      child: DropdownSearch<String>(
                                        items: _controller.dropdownProduct,
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
                                                  label: Text("Pilih produk"),
                                                  border: InputBorder.none,
                                                )),
                                        onChanged: (value) {
                                          setState(() {
                                            _products[index] = value.toString();
                                            int indexSelected = _controller
                                                .dropdownProduct
                                                .indexOf(value!);
                                            Map<String, dynamic> _selected =
                                                _controller
                                                    .productList[indexSelected];
                                            String _selectedId =
                                                _selected['id'].toString();
                                            _selectedProducts[index] =
                                                _selectedId;
                                          });
                                        },
                                        selectedItem: _products[index],
                                      ),
                                    ),
                            ),
                          ),
                          Jarak(tinggi: 8),
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2.0),
                                    ),
                                    child: TextField(
                                      controller: _quantities[index],
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Qty",
                                        hintStyle: const TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  )),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                          2 /
                                          3 -
                                      40,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        value: _selectedTypes[index],
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedTypes[index] =
                                                newValue.toString();
                                          });
                                        },
                                        items: _controller.typeDropdown),
                                  )),
                            ],
                          ),
                          Divider(color: Colors.grey.shade400),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 30,
                                  child: GestureDetector(
                                    onTap: () {
                                      _addItem();
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 15)),
                                  )),
                              Spasi(lebar: 10),
                              SizedBox(
                                  width: 30,
                                  child: GestureDetector(
                                    onTap: () {
                                      _onDelete(index);
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Icon(Icons.delete,
                                            color: Colors.white, size: 15)),
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey[400],
                          )
                        ],
                      ));
                }),
          ),
          Jarak(tinggi: 30),
          Jarak(tinggi: 50),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _adjustmentStore();
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
          Jarak(tinggi: 150),
        ],
      ),
    );
  }
}
