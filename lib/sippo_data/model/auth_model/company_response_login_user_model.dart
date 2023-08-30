import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/utils/app_use.dart';

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

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "company_id": this.companyId,
      "city": this.city,
      "longitude": this.longitude,
      "latitude": this.latitude,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
    };
  }
}

class LoginCompanyResponseModel extends EntityModel {
  final int? type;
  final String? role;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final CompanyDetails? companyDetails;

  LoginCompanyResponseModel({
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'phone': super.phone,
      'secondary_pone': super.secondaryPhone,
      'email': super.email,
      "type": this.type,
      "role": this.role,
      "status": this.status,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
      "company_details": this.companyDetails?.toJson(),
    };
  }

  factory LoginCompanyResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginCompanyResponseModel(
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

  @override
  // TODO: implement locationCity
  String? get locationCity => companyDetails?.city;

  @override
  // TODO: implement userType
  AppUsingType get userType => AppUsingType.company;
}
