import 'dart:io';

import 'package:get/get.dart';

class ImageUploadProvider extends GetConnect {
  Future<String> uploadImage(List<String> list) async {
    try {
      final form = FormData({});
      for (String path in list) {
        form.files.add(MapEntry(
            "file[]",
            MultipartFile(File(path),
                filename:
                    "${DateTime.now().microsecondsSinceEpoch}.${path.split('.').last}")));
      }
      final response = await post("url", form);
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
