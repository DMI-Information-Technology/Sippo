import 'package:http/src/multipart_file.dart';
import 'package:sippo/sippo_data/model/custom_file_model/custom_file_model.dart';


class UserSendApplicationModel {
  final CustomFileModel? cv;
  final String? description;

  UserSendApplicationModel({
    this.description,
    this.cv,
  });

  MultipartFile? toMultipartFile() {
    return cv?.toMultipartFile();
  }

  Map<String, String?> contentToJson() {
    return {'description': description};
  }

  UserSendApplicationModel copyWith({
    CustomFileModel? cv,
    String? description,
  }) {
    return UserSendApplicationModel(
      cv: cv ?? this.cv,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'UserJobApplication{cv: $cv, description: $description}';
  }
}
