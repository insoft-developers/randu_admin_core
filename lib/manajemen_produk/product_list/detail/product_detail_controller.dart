import 'dart:convert';

import 'package:buzz/network/network.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var loading = false.obs;
  var productDetail = <String, dynamic>{}.obs;

  void getProductDetail(int id) async {
    loading(true);
    var data = {"id": id};
    var res = await Network().post(data, '/core/product-detail');
    var body = jsonDecode(res.body);
    if (body['success']) {
      loading(false);
      productDetail.value = body['data'];
      print(productDetail);
    }
  }
}
