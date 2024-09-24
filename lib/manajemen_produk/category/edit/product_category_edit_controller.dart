import 'dart:convert';
import 'dart:io';

import 'package:buzz/network/network.dart';
import 'package:buzz/utils/contstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductCategoryEditController extends GetxController {
  var loading = false.obs;

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
    Get.back();
    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(Constant.UPLOAD_IMAGE_URL + '/core/product-category-upload'));

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

  void ProductCategoryUpdate(
      int id, String _name, String _code, String _description) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      String userId = user['id'].toString();
      var data = {
        "id":id,
        "name": _name,
        "code": _code,
        "user_id": userId,
        "description": _description
      };

      var res = await Network().post(data, '/core/product-category-update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        if (_pickedFile != null) {
          upload(id.toString());
        } else {
          Get.back();
        }
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
}
