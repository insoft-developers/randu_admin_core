import 'package:buzz/components/bottom_note.dart';
import 'package:buzz/components/input_readonly.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/manajemen_produk/product_list/add/product_add_controller.dart';
import 'package:buzz/new_appbar.dart';
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
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _sku = TextEditingController();
  final TextEditingController _berat = TextEditingController();
  final TextEditingController _defaultPrice = TextEditingController();
  final TextEditingController _deliveryPrice = TextEditingController();
  final TextEditingController _marketplacePrice = TextEditingController();
  final TextEditingController _customPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  menuItems: _controller.productTypeDropdown)),
              Jarak(tinggi: 150)
            ])));
  }
}
