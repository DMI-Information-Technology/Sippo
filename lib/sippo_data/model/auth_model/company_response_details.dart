import 'package:jobspot/sippo_data/model/auth_model/cord_location.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/utils/app_use.dart';

import '../specializations_model/specializations_model.dart';

class CompanyResponseDetailsModel extends EntityModel {
  CompanyResponseDetailsModel({
    super.id,
    super.name,
    super.phone,
    super.secondaryPhone,
    super.email,
    this.city,
    this.locations,
    this.website,
    this.bio,
    this.employeesCount,
    this.establishmentDate,
    this.specializations,
  });

  factory CompanyResponseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompanyResponseDetailsModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      secondaryPhone: json['secondary_phone'],
      email: json['email'],
      city: json['city'],
      locations: List.of(json["locations"] ?? [])
          .map((cord) => CordLocation.fromJson(cord))
          .toList(),
      website: json['website'],
      bio: json['bio'],
      employeesCount: json['employees_count'] is String
          ? int.parse(json['employees_count'])
          : json['employees_count'],
      establishmentDate: json['establishment_date'],
      specializations: List.of(json["specializations"] ?? [])
          .map((cord) => SpecializationModel.fromJson(cord))
          .toList(),
    );
  }

  final String? city;
  final List<CordLocation>? locations;
  final String? website;
  final String? bio;
  final int? employeesCount;
  final String? establishmentDate;
  final List<SpecializationModel>? specializations;

  CompanyResponseDetailsModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? secondaryPhone,
    String? email,
    String? city,
    List<CordLocation>? locations,
    String? website,
    String? bio,
    int? employeesCount,
    String? establishmentDate,
    List<SpecializationModel>? specializations,
  }) =>
      CompanyResponseDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        email: email ?? this.email,
        city: city ?? this.city,
        locations: locations ?? this.locations,
        website: website ?? this.website,
        bio: bio ?? this.bio,
        employeesCount: employeesCount ?? this.employeesCount,
        establishmentDate: establishmentDate ?? this.establishmentDate,
        specializations: specializations ?? this.specializations,
      );

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'secondary_phone': secondaryPhone,
      'email': email,
      'city': city,
      "latitude": locations?.first.latitude,
      "longitude": locations?.first.longitude,
      'website': website,
      'employees_count': employeesCount,
      'establishment_date': establishmentDate,
      'specializations': specializations?.map((e) => e.id).toList(),
    };
    for (var key in map.keys) {
      if (map[key] == null) continue;
      if (map[key] is List && map[key].runtimeType == List && map[key].isEmpty)
        map[key] = null;
      if ((map[key] is String && map[key].runtimeType == String) &&
          map[key].trim().isEmpty) map[key] = null;
    }
    return map;
  }

  @override
  String? get locationCity => city;

  @override
  AppUsingType get userType => AppUsingType.company;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyResponseDetailsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          phone == other.phone &&
          secondaryPhone == other.secondaryPhone &&
          email == other.email &&
          city == other.city &&
          locations == other.locations &&
          website == other.website &&
          bio == other.bio &&
          employeesCount == other.employeesCount &&
          establishmentDate == other.establishmentDate &&
          specializations == other.specializations;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      secondaryPhone.hashCode ^
      email.hashCode ^
      city.hashCode ^
      locations.hashCode ^
      website.hashCode ^
      bio.hashCode ^
      employeesCount.hashCode ^
      establishmentDate.hashCode ^
      specializations.hashCode;
}