import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';
import 'package:buzz/staticdata.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CompanySettingController extends GetxController {
  var loading = false.obs;
  var dataLoading = false.obs;
  var dataList = <String, dynamic>{}.obs;
  var selected = "".obs;
  var selectedCategory = "".obs;
  var categoryList = List.empty().obs;

  var bankList = List.empty().obs;
  var selectedBank = "".obs;

  var provinceList = List.empty().obs;
  var selectedProvince = "".obs;
  var selectedProvinceName = "".obs;

  var cityList = List.empty().obs;
  var selectedCity = "".obs;
  var selectedCityName = "".obs;
  var cityLoading = false.obs;

  var districtList = List.empty().obs;
  var selectedDistrict = "".obs;
  var selectedDistrictName = "".obs;
  var districtLoading = false.obs;

  final AppConst controller = Get.put(AppConst());

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<void> resetPicker() async {
    _pickedFile = null;
    update();
  }

  Future<bool> upload(String ids) async {
    print("upload process");
    update();
    bool success = false;
    http.StreamedResponse response = await updateImage(_pickedFile, ids);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;
      _imagePath = message;
      print(message);
    } else {}
    update();
    loading(false);

    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(Constant.UPLOAD_IMAGE_URL + '/core/company-setting-upload'));
    print("upload http");

    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    Map<String, String> _fields = {};
    _fields.addAll(<String, String>{'ids': ids});
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future getCompanyData() async {
    dataLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {"userid": userId};
      var res = await Network().post(data, '/core/company-setting');
      var body = jsonDecode(res.body);
      if (body['success']) {
        dataList.value = body['data'];
        categoryList.value = body['data']['category'];
        bankList.value = body['data']['bank'];
        provinceList.value = body['data']['province'];
        dataLoading(false);

        print(categoryList);
      }
    }
  }

  List<DropdownMenuItem<String>> get categoryDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems
        .add(const DropdownMenuItem(child: Text("Pilih Kategori"), value: ""));

    for (var i = 0; i < categoryList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(categoryList[i]['category_name'].toString()),
            value: categoryList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get bankDropdown {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(const DropdownMenuItem(child: Text("Pilih"), value: ""));

    for (var i = 0; i < bankList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: Text(bankList[i]['bank_name'].toString()),
            value: bankList[i]['id'].toString()),
      );
    }

    return menuItems;
  }

  List<String> get provinceDropdown {
    List<String> menuItems = [];

    for (var i = 0; i < provinceList.length; i++) {
      menuItems.add(provinceList[i]['province_name'].toString());
    }

    return menuItems;
  }

  List<String> get cityDropdown {
    List<String> menuItems = [];

    for (var i = 0; i < cityList.length; i++) {
      menuItems.add(cityList[i]['city_name'].toString());
    }

    return menuItems;
  }

  List<String> get districtDropdown {
    List<String> menuItems = [];

    for (var i = 0; i < districtList.length; i++) {
      menuItems.add(districtList[i]['subdistrict_name'].toString());
    }

    return menuItems;
  }

  Future getCityData(String provinceId) async {
    cityLoading(true);

    var data = {"province": provinceId};
    var res = await Network().post(data, '/core/company-city');
    var body = jsonDecode(res.body);
    if (body['success']) {
      cityList.value = body['data'];
      cityLoading(false);
    }
  }

  Future getDistrictData(String cityId) async {
    districtLoading(true);

    var data = {"city": cityId};
    var res = await Network().post(data, '/core/company-district');
    var body = jsonDecode(res.body);
    if (body['success']) {
      districtList.value = body['data'];
      districtLoading(false);
    }
  }

  void companySettingUpdate(
      String _id,
      String _email,
      String _name,
      String _phone,
      String _address,
      String _npwp,
      String _rekening,
      String _atasnama,
      String _branchName,
      String _branchAddress,
      String _branchPhone,
      String _tax) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        'id': _id,
        'company_email': _email,
        'company_name': _name,
        'phone_number': _phone,
        'address': _address,
        'business_category': selectedCategory.value,
        'npwp': _npwp,
        'no_rekening': _rekening,
        'rekening_name': _atasnama,
        'bank_id': selectedBank.value,
        'province_id': selectedProvince.value,
        'city_id': selectedCity.value,
        'district_id': selectedDistrict.value,
        'userid': userId,
        'branches_name': _branchName,
        'branches_address': _branchAddress,
        'branches_phone': _branchPhone,
        'branches_district_id': selectedDistrict.value,
        'tax': _tax
      };
      var res = await Network().post(data, '/core/company-setting-update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        if (_pickedFile != null) {
          upload(_id.toString());
          print("upload gambar_" + _id);
        } else {
          loading(false);
          print("no-gambar");
        }
        showSuccess(body['message'].toString());
      } else {
        loading(false);
        showError(body['message'].toString());
      }
    }
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }

  void showSuccess(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(n, style: TextStyle(color: Colors.white, fontSize: 16)),
    ));
  }
}
