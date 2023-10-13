import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../sippo_data/model/custom_file_model/custom_file_model.dart';

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

  static Future<CustomFileModel?> pickImageFileFromGallery() async {
    try {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      print(imageFile?.path);
      if (imageFile != null) {
        final file = File(imageFile.path);
        final data = CustomFileModel(
          fileField: 'image',
          file: file,
          type: "image",
          name: imageFile.path.split('/').last,
          subtype: imageFile.path.split('/').last.split('.').last,
        );
        print(data);
        return data;
      }
      return null;
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
