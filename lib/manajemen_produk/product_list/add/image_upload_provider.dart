import 'dart:io';

import 'package:buzz/utils/contstant.dart';
import 'package:get/get.dart';

class ImageUploadProvider extends GetConnect {
  Future<String> uploadImage(List<String> list, String url, String id) async {
    try {
      final form = FormData({});

      for (String path in list) {
        form.files.add(MapEntry(
            "file[]",
            MultipartFile(File(path),
                filename:
                    "${DateTime.now().microsecondsSinceEpoch}.${path.split('.').last}")));
      }
      form.fields.add(MapEntry("ids", id));
      final response = await post(Constant.UPLOAD_IMAGE_URL + url, form);
      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body['result'];
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
