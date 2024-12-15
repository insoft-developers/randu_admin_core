import 'dart:io';

import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/shimmer_text.dart';
import 'package:buzz/components/subtitle.dart';
import 'package:buzz/components/text_area.dart';

import 'package:buzz/pengaturan/kas_kecil/kas_kecil_controller.dart';
import 'package:buzz/pengaturan/printer_setting/printer_setting_controller.dart';

import 'package:buzz/widgets/comuntitle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterSetting extends StatefulWidget {
  const PrinterSetting({super.key});

  @override
  State<PrinterSetting> createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
  final TextEditingController _customFooter = TextEditingController();
  final PrinterSettingController _controller =
      Get.put(PrinterSettingController());

  @override
  void initState() {
    _controller.getSettingData().then((value) {
      _customFooter.text =
          _controller.settingData['printer_custom_footer'].toString();
      _controller.radioPembulatan.value =
          _controller.settingData['is_rounded'] == 1 ? 0 : 1;
      _controller.radioKoneksi.value =
          _controller.settingData['printer_connection'] == 'bluetooth' ? 0 : 1;

      _controller.radioUkuran.value =
          _controller.settingData['printer_paper_size'] == 5.8 ? 0 : 1;
    });
    super.initState();
  }

  _printerSettingUpdate() {
    _controller.printerSettingUpdate(_customFooter.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(
              title: 'Pengaturan \nPrinter POS (Kasir)', path: "Pengaturan"),
          Jarak(tinggi: 20),
          Judul(
              nama: "Pembulatan Transaksi", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Subtitle(
              text:
                  "Jika Transaksi dibawah Rp 500 Transaksi akan dibulatkan ke bawah, jika diatas Rp 500 Transaksi akan dibulatkan ke atas"),
          Jarak(tinggi: 2),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('Yes'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 0,
                      groupValue: _controller.radioPembulatan.value,
                      onChanged: (value) {
                        _controller.onChangePembulatan(value!);
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('No'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 1,
                      groupValue: _controller.radioPembulatan.value,
                      onChanged: (value) {
                        _controller.onChangePembulatan(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Koneksi Printer", pad: 20, ukuran: 16, mandatory: 1),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('Bluetooth'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 0,
                      groupValue: _controller.radioKoneksi.value,
                      onChanged: (value) {
                        _controller.onChangeKoneksi(value!);
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('USB'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 1,
                      groupValue: _controller.radioKoneksi.value,
                      onChanged: (value) {
                        _controller.onChangeKoneksi(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Ukuran Kertas", pad: 20, ukuran: 16, mandatory: 1),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('5.8 mm'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 0,
                      groupValue: _controller.radioUkuran.value,
                      onChanged: (value) {
                        _controller.onChangeUkuran(value!);
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('8.0 mm'),
                  leading: Obx(
                    () => Radio<int>(
                      value: 1,
                      groupValue: _controller.radioUkuran.value,
                      onChanged: (value) {
                        _controller.onChangeUkuran(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Custom Footer", pad: 20, ukuran: 16, mandatory: 0),
          Jarak(tinggi: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextArea(
                  hint: "", textEditingController: _customFooter, maxline: 5)),
          Jarak(tinggi: 50),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _printerSettingUpdate();
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
