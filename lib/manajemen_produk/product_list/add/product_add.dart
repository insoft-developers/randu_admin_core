import 'package:buzz/components/bottom_note.dart';
import 'package:buzz/components/input_readonly.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/spasi.dart';
import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
import 'package:buzz/manajemen_produk/product_list/add/varian_controller.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final ProductAddController _controller = Get.put(ProductAddController());
  final VarianController _varianController = Get.put(VarianController());
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _sku = TextEditingController();
  final TextEditingController _berat = TextEditingController();
  final TextEditingController _defaultPrice = TextEditingController();
  final TextEditingController _deliveryPrice = TextEditingController();
  final TextEditingController _marketplacePrice = TextEditingController();
  final TextEditingController _customPrice = TextEditingController();

  @override
  void initState() {
    _varianController.clearVarians();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: NewAppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ComunTitle(title: 'Tambah Produk', path: "Daftar Produk"),
              Jarak(tinggi: 20),
              Judul(nama: "Nama Produk *", pad: 20, ukuran: 16),
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
                    controller: _productName,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Cth: Nasi goreng ikan asin",
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              Jarak(tinggi: 30),
              Judul(nama: "Kategori Produk", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputReadonly(
                    hint: "Pilih kategori",
                    textInputType: TextInputType.text,
                    textEditingController: _category,
                    obsecureText: false,
                    code: 'select-product-category'),
              ),
              Jarak(tinggi: 30),
              Judul(nama: "SKU Produk", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputText(
                    hint: "Contoh: NGIA",
                    textInputType: TextInputType.text,
                    textEditingController: _sku,
                    obsecureText: false,
                    code: "product-sku"),
              ),
              Jarak(tinggi: 30),
              Judul(nama: "Berat Produk in (Gram)", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputText(
                    hint: "Cth: 100 (Opsional)",
                    textInputType: TextInputType.number,
                    textEditingController: _berat,
                    obsecureText: false,
                    code: "product-weight"),
              ),
              Jarak(tinggi: 30),
              Judul(nama: "Harga Jual Default", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputText(
                    hint: "Cth: 10.000",
                    textInputType: TextInputType.number,
                    textEditingController: _defaultPrice,
                    obsecureText: false,
                    code: "default-price"),
              ),
              Jarak(tinggi: 3),
              BottomNote(
                  text:
                      "*Isi dengan nominal harga jual produk / barang. Jika bisnis FnB biasanya harga untuk Dine In (Makan di Tempat).",
                  pad: 20),
              Jarak(tinggi: 30),
              Judul(
                  nama: "Harga Delivery / Take Away (Opsional)",
                  pad: 20,
                  ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputText(
                      hint: "Cth: 11.000",
                      textInputType: TextInputType.number,
                      textEditingController: _deliveryPrice,
                      obsecureText: false,
                      code: "delivery-price")),
              Jarak(tinggi: 3),
              BottomNote(
                  text:
                      "*Isi jika perlu harga yang berbeda jika pesanannya dikirim / dibawa pulang.",
                  pad: 20),
              Jarak(tinggi: 30),
              Judul(nama: "Harga Marketplace (Opsional)", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputText(
                    hint: "Cth: 14.000",
                    textInputType: TextInputType.number,
                    textEditingController: _marketplacePrice,
                    obsecureText: false,
                    code: "marketplace-price"),
              ),
              Jarak(tinggi: 3),
              BottomNote(
                  text:
                      "*Isi jika perlu harga yang berbeda khusus untuk Shopee, Tokopedia, GrabFood, GoFood DLL.",
                  pad: 20),
              Jarak(tinggi: 30),
              Judul(nama: "Harga Custom (Opsional)", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputText(
                      hint: "Cth: 15.000",
                      textInputType: TextInputType.number,
                      textEditingController: _customPrice,
                      obsecureText: false,
                      code: "custom-price")),
              Jarak(tinggi: 3),
              BottomNote(
                  text: "*Isi jika perlu harga jual yang berbeda Lainnya",
                  pad: 20),
              Jarak(tinggi: 30),
              Judul(nama: "Tipe Produk", pad: 20, ukuran: 16),
              Jarak(tinggi: 5),
              Obx(() => SelectData(
                    defValue: _controller.selectedProductType.value,
                    label: "",
                    menuItems: _controller.productTypeDropdown,
                    code: 'tipe-produk',
                  )),
              Jarak(tinggi: 15),
              Obx(
                () => _controller.selectedProductType.value == '1'
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.blue.shade100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Jarak(tinggi: 5),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 2,
                                child: Text("Varian Product List",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            GestureDetector(
                              onTap: () {
                                _showSimpleModalDialog(
                                    context, 1, {"text": "text"});
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.green),
                                  child: Icon(Icons.add, color: Colors.white)),
                            )
                          ],
                        ),
                      ),
              ),
              Obx(
                () => _controller.selectedProductType.value == '1'
                    ? const SizedBox()
                    : Container(
                        color: Colors.amber.withOpacity(0.2),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6,
                                child: Text("Group",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6,
                                child: Text("Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6 -
                                        10,
                                child: Text("SKU",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6,
                                child: Text("Price",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6 -
                                        40,
                                child: Text("SP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 6,
                                child: Text("MaxQty",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ),
              ),
              Jarak(tinggi: 10),
              Obx(
                () => _controller.selectedProductType.value == '1'
                    ? const SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: _varianController.varianList.length,
                        itemBuilder: (context, index2) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          6,
                                      child: Text(_varianController
                                          .varianList[index2]['varian_group']
                                          .toString()),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          6,
                                      child: Text(_varianController
                                          .varianList[index2]['varian_name']
                                          .toString()),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              1 /
                                              6 -
                                          10,
                                      child: Text(_varianController
                                          .varianList[index2]['sku']
                                          .toString()),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          6,
                                      child: Text(Helper.formatAngka(
                                          _varianController.varianList[index2]
                                                  ['harga']
                                              .toString())),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              1 /
                                              6 -
                                          40,
                                      child: Text(_varianController
                                          .varianList[index2]['single_pick']
                                          .toString()),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          6,
                                      child: Text(_varianController
                                          .varianList[index2]['max_quantity']
                                          .toString()),
                                    ),
                                  ],
                                ),
                                Jarak(tinggi: 5),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showSimpleModalDialog(
                                              context,
                                              2,
                                              _varianController
                                                  .varianList[index2]);
                                        },
                                        child: Icon(Icons.add,
                                            size: 22, color: Colors.green),
                                      ),
                                      Spasi(lebar: 20),
                                      GestureDetector(
                                        onTap: () {
                                          _showSimpleModalDialog(
                                              context,
                                              3,
                                              _varianController
                                                  .varianList[index2]);
                                        },
                                        child: Icon(Icons.edit,
                                            size: 18, color: Colors.orange),
                                      ),
                                      Spasi(lebar: 20),
                                      GestureDetector(
                                        onTap: () {
                                          _varianController.deleteVarian(
                                              _varianController
                                                  .varianList[index2]['id']);
                                        },
                                        child: Icon(Icons.delete,
                                            size: 18, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey.shade300),
                                Jarak(tinggi: 5),
                              ],
                            ),
                          );
                        }),
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
                      Text("Single Pick",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          "Single Pick memungkinkan pelanggan memilih hanya satu varian dari beberapa pilihan yang tersedia. Cocok untuk produk yang hanya bisa dipilih satu varian, seperti satu ukuran atau satu warna pakaian per transaksi.", textAlign:TextAlign.justify ,),
                      Jarak(tinggi: 10),
                      Text("Max Quantity ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          "Opsi Max Quantity membatasi jumlah maksimal varian yang bisa dipilih dalam satu transaksi. Berguna untuk mengelola stok dan mencegah over-ordering, seperti membatasi maksimal 3 jenis topping pada satu minuman.", textAlign:TextAlign.justify),
                    ]),
              ),
              Jarak(tinggi: 150)
            ])));
  }
}

_showSimpleModalDialog(context, int trans, Map<String, dynamic> dataList) {
  final VarianController _varianController = Get.put(VarianController());
  TextEditingController _varianGroup = TextEditingController();
  TextEditingController _varianName = TextEditingController();
  TextEditingController _sku = TextEditingController();
  TextEditingController _harga = TextEditingController();
  TextEditingController _maxQuantity = TextEditingController();

  if (trans == 2 || trans == 3) {
    _varianGroup.text = dataList['varian_group'].toString();
  }

  if (trans == 3) {
    _varianName.text = dataList['varian_name'].toString();
    _sku.text = dataList['sku'].toString();
    _harga.text = dataList['harga'].toString();
    _maxQuantity.text = dataList['max_quantity'].toString();
    _varianController
        .onClickSinglePick(dataList['single_pick'] == 1 ? true : false);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Jarak(tinggi: 20),
                    Center(
                        child: Text("Tambah Varian Produk",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    const Divider(
                      color: Colors.grey,
                    ),
                    InputText(
                        hint: "Varian Group",
                        textInputType: TextInputType.text,
                        textEditingController: _varianGroup,
                        obsecureText: false,
                        code: ""),
                    Jarak(tinggi: 10),
                    InputText(
                        hint: "Varian Name",
                        textInputType: TextInputType.text,
                        textEditingController: _varianName,
                        obsecureText: false,
                        code: ""),
                    Jarak(tinggi: 10),
                    InputText(
                        hint: "SKU",
                        textInputType: TextInputType.text,
                        textEditingController: _sku,
                        obsecureText: false,
                        code: ""),
                    Jarak(tinggi: 10),
                    InputText(
                        hint: "Harga",
                        textInputType: TextInputType.number,
                        textEditingController: _harga,
                        obsecureText: false,
                        code: ""),
                    Jarak(tinggi: 10),
                    Obx(
                      () => CheckboxListTile(
                        title: Text("Single Pick"),
                        value: _varianController.singlePickValue.value,
                        onChanged: (newValue) {
                          _varianController.onClickSinglePick(newValue!);
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                    InputText(
                        hint: "Max Quantity",
                        textInputType: TextInputType.number,
                        textEditingController: _maxQuantity,
                        obsecureText: false,
                        code: ""),
                    Jarak(tinggi: 30),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (trans == 1 || trans == 2) {
                              _varianController.tambahVarian(
                                  _varianGroup.text,
                                  _varianName.text,
                                  _sku.text.isEmpty ? "-" : _sku.text,
                                  _harga.text.isEmpty
                                      ? 0
                                      : int.parse(_harga.text),
                                  _maxQuantity.text.isEmpty
                                      ? 0
                                      : int.parse(_maxQuantity.text));
                            } else if (trans == 3) {
                              _varianController.updateVarian(
                                  dataList['id'],
                                  _varianGroup.text,
                                  _varianName.text,
                                  _sku.text.isEmpty ? "-" : _sku.text,
                                  _harga.text.isEmpty
                                      ? 0
                                      : int.parse(_harga.text),
                                  _maxQuantity.text.isEmpty
                                      ? 0
                                      : int.parse(_maxQuantity.text));
                            }
                          },
                          child: Text("Tambah Varian")),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
