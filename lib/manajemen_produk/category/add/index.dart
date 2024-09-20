import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/text_area.dart';
import 'package:buzz/new_appbar.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';

class ProductCategoryAdd extends StatefulWidget {
  const ProductCategoryAdd({super.key});

  @override
  State<ProductCategoryAdd> createState() => _ProductCategoryAddState();
}

class _ProductCategoryAddState extends State<ProductCategoryAdd> {
  final TextEditingController _namaKategori = TextEditingController();
  final TextEditingController _codeKategori = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Tambah Kategori', path: "Daftar Kategori"),
          Jarak(tinggi: 20),
          Judul(nama: "Nama Kategori *", pad: 20, ukuran: 16),
          Jarak(tinggi: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: InputText(
                hint: "Nama kategori",
                textInputType: TextInputType.text,
                textEditingController: _namaKategori,
                obsecureText: false,
                code: ""),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Kode Kategori (Opsional)", pad: 20, ukuran: 16),
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
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 2.0)),
              height: 200,
              child: Image.asset("assets/image_upload.png")),
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
          Center(
              child: InkWell(
            onTap: () {},
            splashColor: Colors.blue,
            borderRadius: BorderRadius.circular(30),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green.withOpacity(0.8)),
                child: Text("Simpan",
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          )),
          Jarak(tinggi: 100),
        ],
      ),
    );
  }
}
