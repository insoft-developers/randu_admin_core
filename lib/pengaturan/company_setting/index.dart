import 'dart:io';

import 'package:buzz/components/input_readonly.dart';
import 'package:buzz/components/input_text.dart';
import 'package:buzz/components/jarak.dart';
import 'package:buzz/components/judul.dart';
import 'package:buzz/components/select.dart';
import 'package:buzz/components/select2.dart';
import 'package:buzz/components/shimmer_text.dart';

import 'package:buzz/components/subtitle.dart';
import 'package:buzz/components/text_area.dart';

import 'package:buzz/pengaturan/company_setting/company_setting_controller.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:buzz/utils/helper.dart';

import 'package:buzz/widgets/comuntitle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompanySetting extends StatefulWidget {
  const CompanySetting({super.key});

  @override
  State<CompanySetting> createState() => _CompanySettingState();
}

class _CompanySettingState extends State<CompanySetting> {
  final CompanySettingController _controller =
      Get.put(CompanySettingController());

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tax = TextEditingController();
  final TextEditingController _npwp = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _branchName = TextEditingController();
  final TextEditingController _branchPhone = TextEditingController();
  final TextEditingController _branchAddress = TextEditingController();
  final TextEditingController _rekening = TextEditingController();
  final TextEditingController _atasnama = TextEditingController();

  @override
  void initState() {
    _controller.getCompanyData().then((value) {
      _initData();
    });
    _controller.resetPicker();
    super.initState();
  }

  _initData() {
    setState(() {
      _email.text = _controller.dataList['data']['company_email'].toString();
      _name.text = _controller.dataList['data']['branch_name'].toString();
      _tax.text = _controller.dataList['data']['tax'].toString();
      _npwp.text = _controller.dataList['data']['npwp'].toString();
      _phone.text = _controller.dataList['data']['business_phone'].toString();
      _address.text =
          _controller.dataList['data']['business_address'].toString();

      _branchName.text = _controller.dataList['cabang'] == null
          ? ""
          : _controller.dataList['cabang']['name'].toString();

      _branchPhone.text = _controller.dataList['cabang'] == null
          ? ""
          : _controller.dataList['cabang']['phone'].toString();

      _branchAddress.text = _controller.dataList['cabang'] == null
          ? ""
          : _controller.dataList['cabang']['address'].toString();

      _controller.selectedCategory.value =
          _controller.dataList['data']['business_category'] == null
              ? ""
              : _controller.dataList['data']['business_category'].toString();
      _controller.selectedBank.value =
          _controller.dataList['data']['bank_id'] == null
              ? ""
              : _controller.dataList['data']['bank_id'].toString();

      _rekening.text = _controller.dataList['data']['no_rekening'].toString();
      _atasnama.text = _controller.dataList['data']['rekening_name'].toString();

      _controller.selectedProvinceName.value =
          _controller.dataList['data']['province_id'] == null
              ? ""
              : _controller.dataList['data']['province']['province_name']
                  .toString();

      _controller.selectedProvince.value =
          _controller.dataList['data']['province_id'].toString();

      _controller
          .getCityData(_controller.dataList['data']['province_id'].toString())
          .then((value) {
        _controller.selectedCityName.value =
            _controller.dataList['data']['city_id'] == null
                ? ""
                : _controller.dataList['data']['city']['city_name'].toString();
        _controller.selectedCity.value =
            _controller.dataList['data']['city_id'].toString();

        _controller
            .getDistrictData(_controller.dataList['data']['city_id'].toString())
            .then((value) {
          _controller.selectedDistrictName.value =
              _controller.dataList['data']['district_id'] == null
                  ? ""
                  : _controller.dataList['data']['district']['subdistrict_name']
                      .toString();
          _controller.selectedDistrict.value =
              _controller.dataList['data']['district_id'].toString();
        });
      });
    });
  }

  _companySettingUpdate() {
    _controller.companySettingUpdate(
        _controller.dataList['data']['id'].toString(),
        _email.text,
        _name.text,
        _phone.text,
        _address.text,
        _npwp.text,
        _rekening.text,
        _atasnama.text,
        _branchName.text,
        _branchAddress.text,
        _branchPhone.text,
        _tax.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ComunTitle(title: 'Pengaturan \nPerusahaan', path: "Pengaturan"),
          Jarak(tinggi: 20),
          Judul(
              nama: "Upload Logo Perusahaan",
              pad: 20,
              ukuran: 16,
              mandatory: 0),
          Jarak(tinggi: 5),
          Subtitle(
            text: "Logo Perusahaan 500 x 500 pixel ukuran persegi",
          ),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? const SizedBox()
                : GetBuilder<CompanySettingController>(
                    builder: (builderController) {
                    return builderController.pickedFile != null
                        ? GestureDetector(
                            onTap: () {
                              builderController.pickImage();
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 2.0)),
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(builderController.pickedFile!.path),
                                    fit: BoxFit.contain,
                                  ),
                                )),
                          )
                        : _controller.dataList['data']['logo'] == null
                            ? GestureDetector(
                                onTap: () {
                                  builderController.pickImage();
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 2.0)),
                                    height: 200,
                                    child:
                                        Image.asset("assets/image_upload.png")),
                              )
                            : GestureDetector(
                                onTap: () {
                                  builderController.pickImage();
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 2.0)),
                                    height: 200,
                                    child: Image.network(Constant.LOGO_IMAGE +
                                        _controller.dataList['data']['logo']
                                            .toString())),
                              );
                  }),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Email Perusahaan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Contoh: marketing@randu.co.id",
                        textInputType: TextInputType.emailAddress,
                        textEditingController: _email,
                        obsecureText: false,
                        code: "company-email"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Nama Perusahaan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Contoh: PT. Randu Bertumbuh Digital",
                        textInputType: TextInputType.text,
                        textEditingController: _name,
                        obsecureText: false,
                        code: "company-name"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(
              nama: "Pajak Perusahaan (%)", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint:
                            "Isi dengan total pajak yang dibayar konsumen/client",
                        textInputType: TextInputType.number,
                        textEditingController: _tax,
                        obsecureText: false,
                        code: "company-tax"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Bidang usaha", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.dataLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedCategory.value,
                  label: "",
                  menuItems: _controller.categoryDropdown,
                  code: 'company-category',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "NPWP Perusahaan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Nomor Pokok Wajib Pajak",
                        textInputType: TextInputType.number,
                        textEditingController: _npwp,
                        obsecureText: false,
                        code: "company-npwp"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Telepon Perusahaan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Contoh: 03123345627",
                        textInputType: TextInputType.number,
                        textEditingController: _phone,
                        obsecureText: false,
                        code: "company-phone"),
                  ),
          ),
          Jarak(tinggi: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Catatan :", style: TextStyle(fontWeight: FontWeight.bold)),
              Jarak(tinggi: 5),
              Text(
                "Data Rekening Bank yang digunakan untuk pencairan Saldo Randu Wallet, Hanya dapat diubah sekali, jika ingin mengganti data bank silahkan hubungi customer service di https://help.randu.co.id",
                textAlign: TextAlign.justify,
              ),
              Jarak(tinggi: 10),
            ]),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Nama Bank", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.dataLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : SelectData(
                  defValue: _controller.selectedBank.value,
                  label: _controller.dataList['data']['bank_id'] == null
                      ? ""
                      : "readonly",
                  menuItems: _controller.bankDropdown,
                  code: 'company-bank',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Nomor Rekening", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _controller.dataList['data']['no_rekening'] == null
                  ? InputText(
                      hint: "Masukkan nomor rekening",
                      textInputType: TextInputType.number,
                      textEditingController: _rekening,
                      obsecureText: false,
                      code: "company-bank-account")
                  : InputReadonly(
                      hint: "Masukkan nomor Rekening",
                      textInputType: TextInputType.number,
                      textEditingController: _rekening,
                      obsecureText: false,
                      code: "company-bank-account"),
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Atas Nama Rekening", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _controller.dataList['data']['rekening_name'] == null
                  ? InputText(
                      hint: "Masukkan atas nama rekening",
                      textInputType: TextInputType.text,
                      textEditingController: _atasnama,
                      obsecureText: false,
                      code: "company-bank-owner")
                  : InputReadonly(
                      hint: "Masukkan atas nama rekening",
                      textInputType: TextInputType.text,
                      textEditingController: _atasnama,
                      obsecureText: false,
                      code: "company-bank-owner"),
            ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Provinsi", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.dataLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : Select2(
                  items: _controller.provinceDropdown,
                  selectedItem: _controller.selectedProvinceName.value,
                  code: 'province',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Kabupaten/Kota", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.cityLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : Select2(
                  items: _controller.cityDropdown,
                  selectedItem: _controller.selectedCityName.value,
                  code: 'city',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Kecamatan", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(() => _controller.districtLoading.value
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShimmerText(
                    lebar: MediaQuery.of(context).size.width,
                    tinggi: 50,
                  ),
                )
              : Select2(
                  items: _controller.districtDropdown,
                  selectedItem: _controller.selectedDistrictName.value,
                  code: 'district',
                )),
          Jarak(tinggi: 30),
          Judul(nama: "Alamat Lengkap", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextArea(
                        hint: "Alamat Lengkap Perusahaan",
                        textEditingController: _address,
                        maxline: 5),
                  ),
          ),
          Jarak(tinggi: 30),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade200),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3 - 40,
                child: Text("Data Cabang",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )),
          Jarak(tinggi: 20),
          Judul(nama: "Nama Cabang", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Nama cabang perusahaan",
                        textInputType: TextInputType.text,
                        textEditingController: _branchName,
                        obsecureText: false,
                        code: "branch-name"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(
              nama: "Kontak Telepon Cabang", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputText(
                        hint: "Telepon Cabang Perusahaan",
                        textInputType: TextInputType.number,
                        textEditingController: _branchPhone,
                        obsecureText: false,
                        code: "branch-phone"),
                  ),
          ),
          Jarak(tinggi: 30),
          Judul(nama: "Alamat Cabang", pad: 20, ukuran: 16, mandatory: 1),
          Jarak(tinggi: 5),
          Obx(
            () => _controller.dataLoading.value
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ShimmerText(
                      lebar: MediaQuery.of(context).size.width,
                      tinggi: 50,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextArea(
                        hint: "Alamat Lengkap Cabang Perusahaan",
                        textEditingController: _branchAddress,
                        maxline: 5),
                  ),
          ),
          Jarak(tinggi: 50),
          Obx(
            () => _controller.loading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : Center(
                    child: InkWell(
                    onTap: () {
                      _companySettingUpdate();
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
