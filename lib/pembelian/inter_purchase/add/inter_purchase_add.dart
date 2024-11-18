import 'dart:io';

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
import 'package:buzz/pembelian/inter_purchase/add/inter_purchase_add_controller.dart';
import 'package:buzz/pembelian/manufacture/add/product_manufacture_add_controller.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InterPurchaseAdd extends StatefulWidget {
  const InterPurchaseAdd({super.key});

  @override
  State<InterPurchaseAdd> createState() => _InterPurchaseAddState();
}

class _InterPurchaseAddState extends State<InterPurchaseAdd> {
  final InterPurchaseAddController _controller =
      Get.put(InterPurchaseAddController());
  final TextEditingController _tanggal = TextEditingController();

  String _product = "";
  String _selectedProduct = "";
  final TextEditingController _pesanan = TextEditingController();

  final List<TextEditingController> _materials = [TextEditingController()];
  final List<TextEditingController> _cogs = [TextEditingController()];
  final List<TextEditingController> _qty = [TextEditingController()];
  final List<TextEditingController> _totalCogs = [TextEditingController()];

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
    _controller.getInterPurchaseAccount();
    _controller.getProductData();
    super.initState();
    _countFinalPrice();
  }

  _onMaterialShow() {
    _controller.getMaterialData(_selectedProduct, _pesanan.text).then((value) {
      _materials.clear();
      _cogs.clear();
      _qty.clear();
      _totalCogs.clear();
      setState(() {
        for (var i = 0; i < _controller.materialList.length; i++) {
          _materials.add(TextEditingController(
              text: _controller.materialList[i]['material_name'].toString()));
          _cogs.add(TextEditingController(
              text: _controller.materialList[i]['cost'].toString()));
          _qty.add(TextEditingController(
              text: _controller.materialList[i]['total_quantity'].toString()));
          _totalCogs.add(TextEditingController(
              text: _controller.materialList[i]['total_price'].toString()));
        }
        _countFinalPrice();
      });
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

  _countFinalPrice() {
    setState(() {
      int total = 0;
      for (var i = 0; i < _totalCogs.length; i++) {
        int tambahan =
            _totalCogs[i].text.isEmpty ? 0 : int.parse(_totalCogs[i].text);
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

  void _productManufactureStore() {
    _controller.interPurchaseStore(
        _tanggal.text,
        _selectedProduct,
        _pesanan.text,
        _tax.text,
        _discount.text,
        _other.text,
        totalTransaction.toString());
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
                  title: 'Tambah Barang \n1/2 Jadi',
                  path: "Trans Brng 1/2 Jadi"),
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
              Judul(nama: "Pilih Produk", pad: 20, ukuran: 16, mandatory: 1),
              Jarak(tinggi: 5),
              Obx(
                () => _controller.productLoading.value
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ShimmerText(
                            lebar: MediaQuery.of(context).size.width,
                            tinggi: 50),
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
                          items: _controller.dropdownProduct,
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
                            setState(() {
                              _product = value.toString();
                              int indexSelected =
                                  _controller.dropdownProduct.indexOf(value!);
                              Map<String, dynamic> _selected =
                                  _controller.productList[indexSelected];
                              String _selectedId = _selected['id'].toString();
                              _selectedProduct = _selectedId;
                            });
                            print(_selectedProduct);
                          },
                          selectedItem: _product,
                        ),
                      ),
              ),
              Jarak(tinggi: 30),
              Judul(
                  nama: "Bayar Biaya Pakai", pad: 20, ukuran: 16, mandatory: 1),
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
                      menuItems: _controller.dropdownAccount,
                      code: 'inter-purchase-account-id',
                    )),
              Jarak(tinggi: 30),
              Judul(
                  nama: "Jumlah yang diproduksi",
                  pad: 20,
                  ukuran: 16,
                  mandatory: 1),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputText(
                    hint: "jumlah diproduksi",
                    textInputType: TextInputType.number,
                    textEditingController: _pesanan,
                    obsecureText: false,
                    code: "pesanan"),
              ),
              Jarak(tinggi: 5),
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
                          "Tekan Tombol 'Tampilkan Komposisi' untuk memproses Komposisi",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Jarak(tinggi: 5),
                      Text(
                        "Setelah menentukan jumlah yang diproduksi (Qty), tekan tombol 'tampilkan komposisi' untuk memproses komposisi otomatis",
                        textAlign: TextAlign.justify,
                      ),
                      Jarak(tinggi: 10),
                    ]),
              ),
              Jarak(tinggi: 2),
              Obx(
                () => _controller.materialLoading.value
                    ? const SizedBox(
                        child: Center(child: CircularProgressIndicator()))
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              _onMaterialShow();
                            },
                            child: Text("Tampilkan Komposisi")),
                      ),
              ),
              Jarak(tinggi: 20),
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
                        width: MediaQuery.of(context).size.width - 80,
                        child: Text("Komposisi Barang / Resep Menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: _materials.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
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
                                    readOnly: true,
                                    controller: _materials[index],
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Material Name",
                                      hintStyle: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              Jarak(tinggi: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              controller: _cogs[index],
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Cogs",
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
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            child: Text(
                                                Helper.formatAngka(
                                                    _cogs[index].text),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue),
                                                textAlign: TextAlign.right),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              1 /
                                              3 -
                                          40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              readOnly: true,
                                              controller: _qty[index],
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
                                              onChanged: (value) {},
                                            ),
                                          ),
                                          Jarak(tinggi: 5),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                                Helper.formatAngka(
                                                    _qty[index].text),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue),
                                                textAlign: TextAlign.right),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              controller: _totalCogs[index],
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Total CogS",
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
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            child: Text(
                                                Helper.formatAngka(
                                                    _totalCogs[index].text),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue),
                                                textAlign: TextAlign.right),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              Divider(color: Colors.grey.shade400),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text(Helper.formatAngka(_tax.text),
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                        textAlign: TextAlign.right),
                  )
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text(Helper.formatAngka(_discount.text),
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                        textAlign: TextAlign.right),
                  )
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text(Helper.formatAngka(_other.text),
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                        textAlign: TextAlign.right),
                  )
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
                      Text(
                          "Penjelasan Fitur Transaksi Buat Barang Setengah Jadi",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Jarak(tinggi: 5),
                      Text(
                        "Stok produk akan langsung bertambah setelah transaksi ini sukses dibuat, dan stok Bahan Baku serta Barang Setengah Jadi akan berkurang otomatis sesuai dengan komposisi bahan pada produk.\n\nHarga Pokok Penjualan / COGS pada Barang yang dibuat akan otomatis tergitung dari Total Transaksi dibagi dengan jumlah barang yang di produksi. Contoh: Jika Total Transaksi = Rp100.000 dan barang yang di produksi adalah 5pcs maka masing masing barang HPP nya adalah 100.000 / 5 = Rp20.000",
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
                          _productManufactureStore();
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
