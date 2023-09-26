import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';

import '../profile_resource_model/profile_edit_model.dart';

class ApplicationCompanyModel {
  ApplicationCompanyModel({
    this.id,
    this.description,
    this.status,
    this.createdAt,
    this.cv,
    this.job,
    this.customer,
  });

  final int? id;
  final ProfileInfoModel? customer;
  final CompanyJobModel? job;
  final String? description;
  final String? status;
  final String? createdAt;
  final CvModel? cv;

  factory ApplicationCompanyModel.fromJson(Map<String, dynamic> json) {
    return ApplicationCompanyModel(
      id: json["id"],
      customer: ProfileInfoModel.fromJson(json["customer"]),
      job: json["job"] != null ? CompanyJobModel.fromJson(json["job"]) : null,
      description: json["description"],
      status: json["status"],
      createdAt: json["created_at"],
      cv: json["cv"] != null ? CvModel.fromJson(json["cv"]) : null,
    );
  }

  ApplicationCompanyModel copyWith({
    int? id,
    ProfileInfoModel? customer,
    CompanyJobModel? job,
    String? description,
    String? status,
    String? createdAt,
    CvModel? cv,
  }) =>
      ApplicationCompanyModel(
        id: id ?? this.id,
        customer: customer ?? this.customer,
        job: job ?? this.job,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        cv: cv ?? this.cv,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationCompanyModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          customer == other.customer &&
          job == other.job &&
          description == other.description &&
          status == other.status &&
          createdAt == other.createdAt &&
          cv == other.cv;

  @override
  int get hashCode =>
      id.hashCode ^
      customer.hashCode ^
      job.hashCode ^
      description.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      cv.hashCode;

  @override
  String toString() {
    return 'ApplicationJobCompanyModel{id: $id, customer: $customer, job: $job, description: $description, status: $status, createdAt: $createdAt, cv: $cv}';
  }
}

class CvModel {
  CvModel({
    this.url,
    this.name,
    this.mimeType,
    this.size,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CvModel &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          name == other.name &&
          mimeType == other.mimeType &&
          size == other.size;

  @override
  int get hashCode =>
      url.hashCode ^ name.hashCode ^ mimeType.hashCode ^ size.hashCode;
  final String? url;
  final String? name;
  final String? mimeType;
  final String? size;

  factory CvModel.fromJson(Map<String, dynamic> json) {
    return CvModel(
      url: json["url"],
      name: json["name"],
      mimeType: json["mimeType"],
      size: json["size"],
    );
  }

  CvModel copyWith({
    String? url,
    String? name,
    String? mimeType,
    String? size,
  }) =>
      CvModel(
        url: url ?? this.url,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );

  @override
  String toString() {
    return 'Cv{url: $url, name: $name, mimeType: $mimeType, size: $size}';
  }
}
