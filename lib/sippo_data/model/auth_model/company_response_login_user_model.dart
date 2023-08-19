import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';

class CompanyDetails {
  final int? id;
  final String? companyId;
  final String? city;
  final String? longitude;
  final String? latitude;
  final String? createdAt;
  final String? updatedAt;

  CompanyDetails({
    this.id,
    this.companyId,
    this.city,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      id: json['id'],
      companyId: json['company_id'],
      city: json['city'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class UserCompanyResponseModel extends EntityModel {
  final int? type;
  final String? role;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final CompanyDetails? companyDetails;

  UserCompanyResponseModel({
    super.id,
    super.name,
    super.phone,
    super.secondaryPhone,
    super.email,
    this.type,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.companyDetails,
  });

  factory UserCompanyResponseModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyResponseModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      secondaryPhone: json['secondary_phone'],
      email: json['email'],
      type: json['type'],
      role: json['role'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      companyDetails: CompanyDetails.fromJson(json['company_details']),
    );
  }
}
