import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage({required ImageSource imageSource}) async {
    try {
      var image = await _imagePicker.pickImage(source: imageSource);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } on PlatformException catch (_) {
      rethrow;
    }
  }
}
