import 'dart:io';

import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/subtitle.dart';
import 'package:buzz/components/text_area.dart';
import 'package:buzz/manajemen_produk/category/edit/product_category_edit_controller.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:buzz/utils/helper.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryEdit extends StatefulWidget {
  Map<String, dynamic> dataList;
  ProductCategoryEdit({super.key, required this.dataList});

  @override
  State<ProductCategoryEdit> createState() => _ProductCategoryEditState();
}

class _ProductCategoryEditState extends State<ProductCategoryEdit> {
  final ProductCategoryEditController _controller =
      Get.put(ProductCategoryEditController());
  final TextEditingController _namaKategori = TextEditingController();
  final TextEditingController _codeKategori = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    _controller.resetPicker();
    _namaKategori.text = widget.dataList["name"];
    _codeKategori.text = widget.dataList["code"];
    _description.text = widget.dataList["description"] == null
        ? ""
        : widget.dataList["description"];

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
          ComunTitle(title: 'Edit Kategori', path: "Daftar Kategori"),
          Jarak(tinggi: 20),
          Judul(nama: "Nama Kategori *", pad: 20, ukuran: 16),
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
          Judul(nama: "Kode Kategori", pad: 20, ukuran: 16),
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
          Judul(nama: "Upload Foto Kategori", pad: 20, ukuran: 16),
          Jarak(tinggi: 5),
          Subtitle(
            text: "Foto kategori 500 x 500 pixel ukuran persegi",
          ),
          Jarak(tinggi: 5),
          GetBuilder<ProductCategoryEditController>(
              builder: (builderController) {
            return builderController.pickedFile != null
                ? GestureDetector(
                    onTap: () {
                      _controller.pickImage();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 2.0)),
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(builderController.pickedFile!.path),
                            fit: BoxFit.contain,
                          ),
                        )),
                  )
                : widget.dataList["image"] == null
                    ? GestureDetector(
                        onTap: () {
                          _controller.pickImage();
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2.0)),
                            height: 200,
                            child: Image.asset("assets/image_upload.png")),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.pickImage();
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2.0)),
                            height: 200,
                            child: Image.network(
                                Constant.PRODUCT_CATEGORY_IMAGE +
                                    widget.dataList["image"].toString())),
                      );
          }),
          Jarak(tinggi: 30),
          Judul(nama: "Keterangan (Opsional)", pad: 20, ukuran: 16),
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
                      _controller.ProductCategoryUpdate(
                          widget.dataList['id'],
                          _namaKategori.text,
                          _codeKategori.text,
                          _description.text);
                    },
                    splashColor: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.withOpacity(0.8)),
                        child: Text("Update",
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
