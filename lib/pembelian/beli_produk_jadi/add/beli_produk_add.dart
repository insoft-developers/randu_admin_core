import 'dart:io';

import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/subtitle.dart';
import 'package:buzz/components/text_area.dart';
import 'package:buzz/manajemen_produk/category/add/product_category_add_controller.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/pembelian/beli_produk_jadi/add/beli_produk_add_controller.dart';
import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeliProdukAdd extends StatefulWidget {
  const BeliProdukAdd({super.key});

  @override
  State<BeliProdukAdd> createState() => _BeliProdukAddState();
}

class _BeliProdukAddState extends State<BeliProdukAdd> {
  final BeliProdukAddController _controller =
      Get.put(BeliProdukAddController());
  final TextEditingController _namaKategori = TextEditingController();
  final TextEditingController _codeKategori = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onChangeCategory(String value) {
    _codeKategori.text = Helper().generateCode(value);
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
              title: 'Tambah Beli \nProduk',
              path: "Transaksi Beli Produk (Jadi)"),
          Jarak(tinggi: 20),
          Judul(nama: "Nama Kategori *", pad: 20, ukuran: 16, mandatory: 1),
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
                controller: _namaKategori,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Nama kategori",
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  _onChangeCategory(value);
                },
              ),
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Kode Kategori", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: InputText(
                hint: "Kode kategori",
                textInputType: TextInputType.text,
                textEditingController: _codeKategori,
                obsecureText: false,
                code: ""),
          ),
          Jarak(tinggi: 30),
          Judul(
              nama: "Keterangan (Opsional)", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextArea(
                hint: "Masukkan keterangan",
                textEditingController: _description,
                maxline: 5),
          ),
          Jarak(tinggi: 30),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      // _controller.ProductCategoryStore(_namaKategori.text,
                      //     _codeKategori.text, _description.text);
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
