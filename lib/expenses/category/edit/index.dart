import 'dart:io';

import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';

import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/expenses/category/add/expense_category_add_controller.dart';
import 'package:buzz/expenses/category/edit/expense_category_edit_controller.dart';
import 'package:buzz/new_appbar.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ExpenseCategoryEdit extends StatefulWidget {
  Map<String, dynamic> dataList;
  ExpenseCategoryEdit({super.key, required this.dataList});

  @override
  State<ExpenseCategoryEdit> createState() => _ExpenseCategoryEditState();
}

class _ExpenseCategoryEditState extends State<ExpenseCategoryEdit> {
  final ExpenseCategoryEditController _controller =
      Get.put(ExpenseCategoryEditController());
  final TextEditingController _name = TextEditingController();

  final List<String> _products = [""];
  final List<String> _selectedProducts = [""];

  @override
  void initState() {
    _name.text = widget.dataList['name'];
    _controller.getProductData().then((value) {
      if (widget.dataList['md_expense_category_product'].length > 0) {
        _products.clear();
        _selectedProducts.clear();
        for (var i = 0;
            i < widget.dataList['md_expense_category_product'].length;
            i++) {
          setState(() {
            _products.add(widget.dataList['md_expense_category_product'][i]
                        ['md_product']['name']
                    .toString() +
                ' - ' +
                widget.dataList['md_expense_category_product'][i]['md_product']
                        ['unit']
                    .toString());

            _selectedProducts.add(widget.dataList['md_expense_category_product']
                    [i]['product_id']
                .toString());
          });
        }
      }
    });
    super.initState();

    print(widget.dataList);
  }

  _addItem() {
    setState(() {
      _products.add("");
      _selectedProducts.add("");
    });
  }

  _onDelete(int index) {
    setState(() {
      _products.removeAt(index);
      _selectedProducts.removeAt(index);
    });
  }

  _expenseCategoryStore() {
    _controller.categoryStore(
        widget.dataList['id'].toString(), _name.text, _selectedProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Edit\nKategori', path: "Kategori Expense"),
          Jarak(tinggi: 20),
          Judul(nama: "Kategori Biaya", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: InputText(
                hint: "Kategori Biaya",
                textInputType: TextInputType.text,
                textEditingController: _name,
                obsecureText: false,
                code: ""),
          ),
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
                    child: Text("Masukkan produk terkait",
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
                itemCount: _selectedProducts.length,
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
                      _expenseCategoryStore();
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
