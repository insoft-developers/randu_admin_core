import 'dart:io';

import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/shimmer_text.dart';

import 'package:buzz/pengaturan/kas_kecil/kas_kecil_controller.dart';

import 'package:buzz/widgets/comuntitle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KasKecil extends StatefulWidget {
  const KasKecil({super.key});

  @override
  State<KasKecil> createState() => _KasKecilState();
}

class _KasKecilState extends State<KasKecil> {
  final KasKecilController _controller = Get.put(KasKecilController());

  @override
  void initState() {
    _controller.getPettyCashData().then((value) {
      _controller.selected.value = _controller.settingData['petty_cash'] == null
          ? ""
          : _controller.settingData['petty_cash'].toString();
    });
    super.initState();
  }

  _KasKecilUpdate() {
    _controller.pettyCashUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Pengaturan \nKas Kecil', path: "Pengaturan"),
          Jarak(tinggi: 20),
          Jarak(tinggi: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Apakah Anda Perlu Mengaktifkan Kas Kecil / Petty Cash?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Jarak(tinggi: 5),
              Text(
                "Mengaktifkan kas kecil dalam sistem POS sangat berguna jika bisnis Anda sering melakukan transaksi tunai dan membutuhkan uang kembalian, serta memiliki pengeluaran kecil rutin seperti bahan baku tambahan atau biaya transportasi. Fitur ini juga memudahkan pemantauan dan rekonsiliasi kas setiap akhir shift.\nJika bisnis Anda lebih banyak menggunakan pembayaran non-tunai dan jarang membutuhkan uang kembalian, atau jika pengeluaran kecil tidak rutin, Anda mungkin tidak perlu mengaktifkan kas kecil. Menonaktifkan fitur ini cocok untuk pencatatan keuangan yang lebih sederhana. Pilihlah pengaturan sesuai kebutuhan operasional bisnis Anda untuk efisiensi dan akurasi dalam pengelolaan keuangan.",
                textAlign: TextAlign.justify,
              ),
              Jarak(tinggi: 10),
            ]),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Petty cash setting", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.onLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : SelectData(
                    defValue: _controller.selected.value,
                    label: "",
                    menuItems: _controller.pettyDropdown,
                    code: 'petty-cash-setting',
                  ),
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
                      _KasKecilUpdate();
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
