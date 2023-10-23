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
          fieldName: 'image',
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

  static Future<List<CustomFileModel>?> pickMultiImageFromGallery({
    String? fieldName,
  }) async {
    try {
      final _picker = ImagePicker();
      final images = await _picker.pickMultiImage();
      final customImages = <CustomFileModel>[];
      for (var i = 0; i < images.length; i++) {
        final image = images[i];
        final bytes = await image.readAsBytes();
        print(bytes);
        customImages.add(
          CustomFileModel.fromBytes(
            bytes: bytes,
            fieldName: "$fieldName[$i]",
            size: await image.length(),
            type: 'image',
            subtype: image.name.split('/').last.split('.')[1],
            name: image.name,
            uploadDate: DateTime.now(),
          ),
        );
      }
      return customImages;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
