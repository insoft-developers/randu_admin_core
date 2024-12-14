import 'dart:io';

import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/shimmer_text.dart';

import 'package:buzz/pengaturan/kas_kecil/kas_kecil_controller.dart';
import 'package:buzz/pengaturan/payment_setting/payment_setting_controller.dart';

import 'package:buzz/widgets/comuntitle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PaymentSetting extends StatefulWidget {
  const PaymentSetting({super.key});

  @override
  State<PaymentSetting> createState() => _PaymentSettingState();
}

class _PaymentSettingState extends State<PaymentSetting> {
  final PaymentSettingController _controller =
      Get.put(PaymentSettingController());

  @override
  void initState() {
    _controller.getPaymentData();
    super.initState();
  }

  _PaymentSettingUpdate() {
    _controller.pettyCashUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Pengaturan \nPembayaran', path: "Pengaturan"),
          Jarak(tinggi: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedCash.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text("Kas / Bayar Tunai di Kasir",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedPaymentGateway.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text("Payment Gateway Randu Wallet (Cek Otomatis)",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedTransfer.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text(
                      "Transfer Rekening / EDC / QRIS Toko (Cek Manual)",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 5),
          ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Text("");
              }),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedCOD.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text("Piutang Cash On Delivery (COD)",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedMarketplace.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text(
                      "Piutang Marketplace (Shopee, Tokopedia, Grabfood, GoFood dll)",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedPiutang.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text("Piutang Usaha", style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ToggleSwitch(
                    minWidth: 60.0,
                    cornerRadius: 10.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: _controller.selectedQRIS.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 2 / 3 - 60,
                  child: Text("QRIS Instant (Cek Otomatis)",
                      style: TextStyle(fontSize: 14)))
            ],
          ),
          Jarak(tinggi: 50),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _PaymentSettingUpdate();
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
