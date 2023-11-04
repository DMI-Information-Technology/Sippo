import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';

import '../profile_model/profile_resource_model/cv_file_model.dart';
import '../profile_model/profile_resource_model/profile_edit_model.dart';

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

  factory ApplicationCompanyModel.fromJson(Map<String, dynamic>? json) {
    return ApplicationCompanyModel(
      id: json?["id"],
      customer: json?["customer"] != null
          ? ProfileInfoModel.fromJson(json?["customer"])
          : null,
      job: json?["job"] != null ? CompanyJobModel.fromJson(json?["job"]) : null,
      description: json?["description"],
      status: json?["status"],
      createdAt: json?["created_at"],
      cv: json?["cv"] != null ? CvModel.fromJson(json?["cv"]) : null,
    );
  }

  ApplicationCompanyModel copyWith({
    int? id,
    ProfileInfoModel? customer,
    CompanyJobModel? job,
    CompanyDetailsModel? company,
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
    return 'ApplicationCompanyModel{id: $id, description: $description, status: $status, createdAt: $createdAt, cv: $cv, customer: $customer, job: $job}';
  }
}

class ApplicationUserModel {
  ApplicationUserModel({
    this.id,
    this.description,
    this.status,
    this.createdAt,
    this.company,
    this.cv,
    this.job,
  });

  final int? id;
  final CompanyJobModel? job;
  final CompanyDetailsModel? company;
  final String? description;
  final String? status;
  final String? createdAt;
  final CvModel? cv;

  factory ApplicationUserModel.fromJson(Map<String, dynamic>? json) {
    print(json?['cv']);
    return ApplicationUserModel(
      id: json?["id"],
      job: json?["job"] != null ? CompanyJobModel.fromJson(json?["job"]) : null,
      description: json?["description"],
      status: json?["status"],
      company: json?["company"] != null
          ? CompanyDetailsModel.fromJson(json?["company"])
          : null,
      createdAt: json?["created_at"],
      cv: json?["cv"] != null ? CvModel.fromJson(json?["cv"]) : null,
    );
  }

  ApplicationUserModel copyWith({
    int? id,
    CompanyJobModel? job,
    CompanyDetailsModel? company,
    String? description,
    String? status,
    String? createdAt,
    CvModel? cv,
  }) =>
      ApplicationUserModel(
        id: id ?? this.id,
        job: job ?? this.job,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        company: company ?? this.company,
        cv: cv ?? this.cv,
      );


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationUserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          job == other.job &&
          company == other.company &&
          description == other.description &&
          status == other.status &&
          createdAt == other.createdAt &&
          cv == other.cv;

  @override
  int get hashCode =>
      id.hashCode ^
      job.hashCode ^
      company.hashCode ^
      description.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      cv.hashCode;

  @override
  String toString() {
    return 'ApplicationUserModel{id: $id, description: $description, status: $status, createdAt: $createdAt, cv: $cv, job: $job, company: $company,}';
  }
}
