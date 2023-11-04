import 'package:http/http.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';

abstract class BaseCompanyPost {
  final int? id;
  final String? title;
  final String? body;

  bool isContentEqualTo(BaseCompanyPost value) =>
      id == value.id && title == value.title && body == value.body;

  BaseCompanyPost({this.id, this.title, this.body});
}

class CompanyDetailsPostModel extends BaseCompanyPost {
  CompanyDetailsPostModel({
    super.id,
    super.title,
    super.body,
    this.image,
    this.company,
    this.createdAt,
  });

  factory CompanyDetailsPostModel.fromJson(Map<String, dynamic>? json) {
    return CompanyDetailsPostModel(
      id: json?["id"],
      title: json?["title"],
      body: json?["body"],
      image: json?['image'] != null
          ? ImageResourceModel.fromJson(json?['image'])
          : null,
      company: json?['company'] != null
          ? CompanyDetailsModel.fromJson(json?['company'])
          : null,
      createdAt: json?['created_at'],
    );
  }

  ImageResourceModel? image;
  CompanyDetailsModel? company;
  String? createdAt;

  CompanyDetailsPostModel copyWith({
    int? id,
    String? title,
    String? body,
    ImageResourceModel? image,
    CompanyDetailsModel? company,
    String? createdAt,
  }) =>
      CompanyDetailsPostModel(
        id: id ?? super.id,
        title: title ?? super.title,
        body: body ?? super.body,
        image: image ?? this.image,
        company: company ?? this.company,
        createdAt: createdAt??this.createdAt
      );

  @override
  String toString() {
    return 'CompanyResponsePostModel{id: $id, title: $title, body: $body, image: $image,}';
  }
}

class CompanyPostModel extends BaseCompanyPost {
  CustomFileModel? image;

  CompanyPostModel({
    super.id,
    super.title,
    super.body,
    this.image,
  });

  MultipartFile? imageToMultipartFile() {
    return image?.toMultipartFile();
  }

  Map<String, String?> contentToJson() {
    return {
      "title": this.title,
      "body": this.body,
    };
  }

  CompanyPostModel copyWith({
    int? id,
    String? title,
    String? body,
    CustomFileModel? image,
  }) {
    return CompanyPostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
    );
  }
}
