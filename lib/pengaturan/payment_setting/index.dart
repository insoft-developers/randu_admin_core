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

  final List<TextEditingController> _banks = [TextEditingController()];
  final List<TextEditingController> _owner = [TextEditingController()];
  final List<TextEditingController> _rekening = [TextEditingController()];
  final List<bool> _checkboxes = [false];

  @override
  void initState() {
    _controller.getPaymentData().then((value) {
      if (_controller.settingData.length > 0) {
        setState(() {
          _banks[0].text =
              _controller.settingData[2]['banks'][0]['bank'].toString();
          _owner[0].text = _controller.settingData[2]['banks'][0]
                      ['bankOwner'] ==
                  null
              ? ""
              : _controller.settingData[2]['banks'][0]['bankOwner'].toString();

          _rekening[0].text = _controller.settingData[2]['banks'][0]
                      ['bankAccountNumber'] ==
                  null
              ? ""
              : _controller.settingData[2]['banks'][0]['bankAccountNumber']
                  .toString();

          _checkboxes[0] =
              _controller.settingData[2]['banks'][0]['selected'] == "true"
                  ? true
                  : false;

          for (var i = 1; i < _controller.settingData[2]['banks'].length; i++) {
            _banks.add(TextEditingController(
                text: _controller.settingData[2]['banks'][i]['bank'] == null
                    ? ""
                    : _controller.settingData[2]['banks'][i]['bank']
                        .toString()));
            _owner.add(TextEditingController(
                text:
                    _controller.settingData[2]['banks'][i]['bankOwner'] == null
                        ? ""
                        : _controller.settingData[2]['banks'][i]['bankOwner']
                            .toString()));
            _rekening.add(TextEditingController(
                text: _controller.settingData[2]['banks'][i]
                            ['bankAccountNumber'] ==
                        null
                    ? ""
                    : _controller.settingData[2]['banks'][i]
                            ['bankAccountNumber']
                        .toString()));

            _checkboxes.add(
                _controller.settingData[2]['banks'][i]['selected'] == "true"
                    ? true
                    : false);
          }
        });
      }
    });
    super.initState();
  }

  _PaymentSettingUpdate() {
    List<String> sendBanks = [];
    List<String> sendRekenings = [];
    List<String> sendOwners = [];
    for (var i = 0; i < _banks.length; i++) {
      sendBanks.add(_banks[i] == null ? "" : _banks[i].text);
      sendRekenings.add(_rekening[i] == null ? "" : _rekening[i].text);
      sendOwners.add(_owner[i] == null ? "" : _owner[i].text);
    }
    _controller.paymentSettingUpdate(
        sendBanks, sendRekenings, sendOwners, _checkboxes);
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
                      _controller.selectedCash.value = index!;
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
                      _controller.selectedPaymentGateway.value = index!;
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
                      _controller.selectedTransfer.value = index!;
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
          Jarak(tinggi: 20),
          Obx(
            () => _controller.onLoading.value
                ? const SizedBox()
                : _controller.selectedTransfer.value == 1
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount:
                                _controller.settingData[2]['banks'].length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                4,
                                        child: CheckboxListTile(
                                          value: _checkboxes[index],
                                          onChanged: (newValue) {
                                            setState(() {
                                              _checkboxes[index] = newValue!;
                                              print(_checkboxes);
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      3 /
                                                      4 -
                                                  40,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 2.0),
                                                ),
                                                child: TextField(
                                                  readOnly:
                                                      index == 4 ? false : true,
                                                  controller: _banks[index],
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: "Nama Bank",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onChanged: (value) {},
                                                ),
                                              )),
                                          Jarak(tinggi: 5),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      3 /
                                                      4 -
                                                  40,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 2.0),
                                                ),
                                                child: TextField(
                                                  controller: _owner[index],
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Nama Pemilik Rekening",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onChanged: (value) {},
                                                ),
                                              )),
                                          Jarak(tinggi: 5),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      3 /
                                                      4 -
                                                  40,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 2.0),
                                                ),
                                                child: TextField(
                                                  controller: _rekening[index],
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: "No Rekening",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onChanged: (value) {},
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[400],
                                  ),
                                ],
                              );
                            }),
                      ),
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
                    initialLabelIndex: _controller.selectedCOD.value,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    radiusStyle: true,
                    onToggle: (index) {
                      _controller.selectedCOD.value = index!;
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
                      _controller.selectedMarketplace.value = index!;
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
                      _controller.selectedPiutang.value = index!;
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
                      _controller.selectedQRIS.value = index!;
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
