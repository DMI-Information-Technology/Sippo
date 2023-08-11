import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerFile {
  static Future<File?> pickImageFromGallery() async {
    try {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      return imageFile != null ? File(imageFile.path) : null;
    } catch (e) {
      print('error in image picker $e');
      return null;
    }
  }

  static Future<String?> pickImageFromGalleryPath() async {
    try {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      return imageFile != null ? imageFile.path : null;
    } catch (e) {
      print('error in image picker $e');
      return null;
    }
  }
}
