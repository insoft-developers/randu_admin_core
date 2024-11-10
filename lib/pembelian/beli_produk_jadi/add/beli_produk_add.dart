import 'dart:io';

import 'package:buzz/components/input_display.dart';
import 'package:buzz/components/input_readonly.dart';
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

class BeliProdukAdd extends StatefulWidget {
  const BeliProdukAdd({super.key});

  @override
  State<BeliProdukAdd> createState() => _BeliProdukAddState();
}

class _BeliProdukAddState extends State<BeliProdukAdd> {
  final BeliProdukAddController _controller =
      Get.put(BeliProdukAddController());
  final TextEditingController _tanggal = TextEditingController();

  final List<String> _products = [""];
  final List<String> _selectedProducts = [""];
  final List<TextEditingController> _totalPrices = [TextEditingController()];
  final List<TextEditingController> _quantities = [TextEditingController()];
  final List<TextEditingController> _unitPrices = [TextEditingController()];
  final TextEditingController _tax = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _other = TextEditingController();
  final TextEditingController _finalPrice = TextEditingController();
  int totalTransaction = 0;

  @override
  void initState() {
    var now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _tanggal.text = formattedDate;
    _controller.getProductPurchaseType("0");
    _controller.getProductData();
    super.initState();
    _countFinalPrice();
  }

  _addItem() {
    setState(() {
      _products.add("");
      _selectedProducts.add("");
      _totalPrices.add(TextEditingController());
      _quantities.add(TextEditingController());
      _unitPrices.add(TextEditingController());
      _countFinalPrice();
    });
  }

  _onDelete(int index) {
    setState(() {
      _products.removeAt(index);
      _selectedProducts.removeAt(index);
      _totalPrices[index].clear();
      _quantities[index].clear();
      _unitPrices[index].clear();
      _totalPrices.removeAt(index);
      _quantities.removeAt(index);
      _unitPrices.removeAt(index);
      _countFinalPrice();
    });
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

  _calculateUnitPrice(int index) {
    setState(() {
      if (_totalPrices[index].text.isNotEmpty &&
          _quantities[index].text.isNotEmpty) {
        double totalHarga = int.parse(_totalPrices[index].text) /
            int.parse(_quantities[index].text);
        _unitPrices[index].text = totalHarga.round().toString();
      } else {
        _unitPrices[index].text = "0";
      }
      _countFinalPrice();
    });
  }

  _countFinalPrice() {
    setState(() {
      int total = 0;
      for (var i = 0; i < _totalPrices.length; i++) {
        int tambahan =
            _totalPrices[i].text.isEmpty ? 0 : int.parse(_totalPrices[i].text);
        total = total + tambahan;
      }
      int pajak = _tax.text.isEmpty ? 0 : int.parse(_tax.text);
      int diskon = _discount.text.isEmpty ? 0 : int.parse(_discount.text);

      int lain = _other.text.isEmpty ? 0 : int.parse(_other.text);

      int grand = total + pajak - diskon + lain;
      totalTransaction = grand;
      _finalPrice.text = Helper.formatAngka(grand.toString());
    });
  }

  void _productPurchaseStore() {
    List<String> pQuantity = [];
    List<String> pTotalPrice = [];
    List<String> pUnitPrice = [];

    for (var i = 0; i < _quantities.length; i++) {
      pQuantity.add(_quantities[i].text);
      pTotalPrice.add(_totalPrices[i].text);
      pUnitPrice.add(_unitPrices[i].text);
    }

    _controller.productPurchaseStore(
        _tanggal.text,
        _quantities.length.toString(),
        totalTransaction.toString(),
        _selectedProducts,
        pTotalPrice,
        pQuantity,
        pUnitPrice,
        _tax.text,
        _discount.text,
        _other.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              ComunTitle(
                  title: 'Tambah Beli \nProduk',
                  path: "Transaksi Beli Produk (Jadi)"),
              Jarak(tinggi: 20),
              Judul(
                  nama: "Tanggal Transaksi", pad: 20, ukuran: 16, mandatory: 1),
              Jarak(tinggi: 5),
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3 - 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Judul(nama: "Tipe Pembayaran", pad: 20, ukuran: 16, mandatory: 1),
              Jarak(tinggi: 5),
              Obx(() => SelectData(
                    defValue: _controller.selectedPaymentType.value,
                    label: "",
                    menuItems: _controller.dropdownPaymentType,
                    code: 'payment-type',
                  )),
              Jarak(tinggi: 30),
              Judul(nama: "Bayar Pakai", pad: 20, ukuran: 16, mandatory: 1),
              Jarak(tinggi: 5),
              Obx(() => _controller.bayarPakaiLoading.value
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ShimmerText(
                        lebar: MediaQuery.of(context).size.width,
                        tinggi: 50,
                      ),
                    )
                  : SelectData(
                      defValue: _controller.selectedAccountId.value,
                      label: "",
                      menuItems: _controller.dropdownPayment,
                      code: 'account-id',
                    )),
              Jarak(tinggi: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Hanya untuk Produk 'Beli Jadi' dan 'Gunakan Stok = Yes'",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Jarak(tinggi: 5),
                      Text(
                        "Produk atau barang yang bisa ditransaksikan dalam menu ini hanya produk dengan tipe 'Beli Jadi' dan tipe 'Gunakan Stok = Yes', untuk tipe produk Manufaktur silahkan gunakan menu Transaksi Buat Produk (Manufaktur). \n \nMenu ini juga dipakai untuk banyak produk dalam 1 kali transaksi, asalkan masih dalam 1 nota pembelian atau 1 nota transaksi",
                        textAlign: TextAlign.justify,
                      ),
                      Jarak(tinggi: 10),
                    ]),
              ),
              Jarak(tinggi: 30),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue.shade200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 3 - 40,
                        child: Text("Masukkan item produk yang dibeli",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                          width: 25,
                          child: InkWell(
                            onTap: () {
                              _addItem();
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                              horizontal: 20),
                                          child: ShimmerText(
                                              lebar: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              tinggi: 50),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                                      label:
                                                          Text("Pilih produk"),
                                                      border: InputBorder.none,
                                                    )),
                                            onChanged: (value) {
                                              setState(() {
                                                _products[index] =
                                                    value.toString();
                                                int indexSelected = _controller
                                                    .dropdownProduct
                                                    .indexOf(value!);
                                                Map<String, dynamic> _selected =
                                                    _controller.productList[
                                                        indexSelected];
                                                String _selectedId =
                                                    _selected['id'].toString();
                                                _selectedProducts[index] =
                                                    _selectedId;
                                              });
                                              print(_selectedProducts);
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
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0),
                                            ),
                                            child: TextField(
                                              controller: _totalPrices[index],
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Harga Total",
                                                hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                _calculateUnitPrice(index);
                                              },
                                            ),
                                          ),
                                          Jarak(tinggi: 5),
                                          Text(
                                              Helper.formatAngka(
                                                  _totalPrices[index].text),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red),
                                              textAlign: TextAlign.right)
                                        ],
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              1 /
                                              3 -
                                          40,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0),
                                            ),
                                            child: TextField(
                                              controller: _quantities[index],
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Qty",
                                                hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                _calculateUnitPrice(index);
                                              },
                                            ),
                                          ),
                                          Jarak(tinggi: 5),
                                          Text(
                                              Helper.formatAngka(
                                                  _quantities[index].text),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red),
                                              textAlign: TextAlign.right)
                                        ],
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0),
                                            ),
                                            child: TextField(
                                              readOnly: true,
                                              controller: _unitPrices[index],
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Harga Satuan",
                                                hintStyle: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                          Jarak(tinggi: 5),
                                          Text(
                                              Helper.formatAngka(
                                                  _unitPrices[index].text),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red),
                                              textAlign: TextAlign.right)
                                        ],
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
                                            margin:
                                                const EdgeInsets.only(right: 5),
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
                                            margin:
                                                const EdgeInsets.only(right: 5),
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
              Judul(
                  nama: "Biaya Pajak Pembelian (+)",
                  pad: 20,
                  ukuran: 16,
                  mandatory: 0),
              Jarak(tinggi: 5),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: TextField(
                      controller: _tax,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Pajak (Rupiah)",
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _countFinalPrice();
                      },
                    ),
                  ),
                  Jarak(tinggi: 5),
                  Text(Helper.formatAngka(_tax.text),
                      style: TextStyle(fontSize: 13, color: Colors.red),
                      textAlign: TextAlign.right)
                ],
              ),
              Jarak(tinggi: 30),
              Judul(
                  nama: "Potongan / Discount Pembelian (-)",
                  pad: 20,
                  ukuran: 16,
                  mandatory: 0),
              Jarak(tinggi: 5),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: TextField(
                      controller: _discount,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Discount / Potongan",
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _countFinalPrice();
                      },
                    ),
                  ),
                  Jarak(tinggi: 5),
                  Text(Helper.formatAngka(_discount.text),
                      style: TextStyle(fontSize: 13, color: Colors.red),
                      textAlign: TextAlign.right)
                ],
              ),
              Jarak(tinggi: 30),
              Judul(
                  nama: "Biaya Lain Lain Pembelian (+)",
                  pad: 20,
                  ukuran: 16,
                  mandatory: 0),
              Jarak(tinggi: 5),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: TextField(
                      controller: _other,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Ongkir / Ongkos Kerja DLL",
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _countFinalPrice();
                      },
                    ),
                  ),
                  Jarak(tinggi: 5),
                  Text(Helper.formatAngka(_other.text),
                      style: TextStyle(fontSize: 13, color: Colors.red),
                      textAlign: TextAlign.right)
                ],
              ),
              Jarak(tinggi: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Penjelasan fitur transaksi Beli Produk",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Jarak(tinggi: 5),
                      Text(
                        "Transaksi ini digunakan saat dilakukan pembelian/kulak dari supplier yang mana stok produk akan langsung bertambah setelah transaksi ini sukses dibuat. \n\nHarga pokok penjualan / COGS pada produk yang dibuat akan otomatis terhitung dari total transaksi dibagi dengan jumlah produk yang dibeli. Contoh : Jika total transaksi = Rp. 100.000 dan produk yang dibeli adalah 5 pcs maka masing masing produk HPP nya adalah 100.000/5 = Rp. 20.000. \n\nGunakan tipe Utang jika pembeliannya menggunaan sistem utang. Fitur Utang juga bisa digunakan untuk sistem konsinyasi bisnis/Supplier menitipkan produk untuk dijual",
                        textAlign: TextAlign.justify,
                      ),
                      Jarak(tinggi: 10),
                    ]),
              ),
              Jarak(tinggi: 50),
              Obx(
                () => _controller.loading.value
                    ? const SizedBox(
                        child: Center(child: CircularProgressIndicator()))
                    : Center(
                        child: InkWell(
                        onTap: () {
                          _productPurchaseStore();
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      )),
              ),
              Jarak(tinggi: 150),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Center(
                    child: InputDisplay(
                        hint: "Rp. 0",
                        textInputType: TextInputType.number,
                        textEditingController: _finalPrice,
                        obsecureText: false,
                        code: ""))),
          )
        ],
      ),
    );
  }
}
