import 'package:http/http.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';

abstract class BaseCompanyPost {
  int? id;
  String? title;
  String? body;

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
  });

  CompanyDetailsPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'] != null
        ? ImageResourceModel.fromJson(json['image'])
        : null;
    company = json['company'] != null
        ? CompanyDetailsResponseModel.fromJson(json['company'])
        : null;
  }

  ImageResourceModel? image;
  CompanyDetailsResponseModel? company;

  CompanyDetailsPostModel copyWith({
    int? id,
    String? title,
    String? body,
    ImageResourceModel? image,
    CompanyDetailsResponseModel? company,
  }) =>
      CompanyDetailsPostModel(
        id: id ?? super.id,
        title: title ?? super.title,
        body: body ?? super.body,
        image: image ?? this.image,
        company: company ?? this.company,
      );

  @override
  String toString() {
    return 'CompanyResponsePostModel{id: $id, title: $title, body: $body, image: $image,}';
  }
}

class ImageResourceModel {
  ImageResourceModel({
    this.url,
    this.name,
    this.mimeType,
    this.size,
  });

  ImageResourceModel.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
    mimeType = json['mime_type'];
    size = json['size'];
  }

  String? url;
  String? name;
  String? mimeType;
  String? size;

  ImageResourceModel copyWith({
    String? url,
    String? name,
    String? mimeType,
    String? size,
  }) =>
      ImageResourceModel(
        url: url ?? this.url,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );

  @override
  String toString() {
    return 'ImageResourceModel{url: $url, name: $name, mimeType: $mimeType, size: $size}';
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
}
