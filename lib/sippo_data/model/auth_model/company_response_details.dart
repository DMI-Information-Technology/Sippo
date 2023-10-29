import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/helper.dart';

import '../profile_model/company_profile_resource_model/work_location_model.dart';
import '../specializations_model/specializations_model.dart';

class CompanyDetailsModel extends EntityModel {
  CompanyDetailsModel({
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
    this.profileImage,
    this.images,
    this.establishmentDate,
    this.specializations,
    this.isFollowed,
    this.hasApplied,
    this.isSubscribed,
    this.isEmailVerified,
    this.pendingEmail,
  });
  bool get pendingEmailIsNotEmpty => pendingEmail?.isNotEmpty == true;

  factory CompanyDetailsModel.fromJson(Map<String, dynamic>? json) {
    return CompanyDetailsModel(
      id: json?['id'],
      name: json?['name'],
      phone: json?['phone'],
      secondaryPhone: json?['secondary_phone'],
      email: json?['email'],
      city: json?['city'],
      locations: json?["locations"] != null
          ? List.of(json?["locations"] ?? [])
              .map((loc) => WorkLocationModel.fromJson(loc))
              .toList()
          : null,
      website: json?['website'],
      bio: json?['bio'],
      employeesCount: json?['employees_count'] is String
          ? int.parse(json?['employees_count'])
          : json?['employees_count'],
      establishmentDate: json?['establishment_date'],
      profileImage: json?['profile_image'] != null
          ? ImageResourceModel.fromJson(json?['profile_image'])
          : null,
      images: json?['images'] != null
          ? List.of(json?['images'])
              .map((e) => ImageResourceModel.fromJson(e))
              .toList()
          : null,
      specializations: json?["specializations"] != null
          ? List.of(json?["specializations"] ?? [])
              .map((cord) => SpecializationModel.fromJson(cord))
              .toList()
          : null,
      isFollowed: json?['is_followed'],
      hasApplied: json?['has_applied'],
      isSubscribed: json?['has_applied'],
      isEmailVerified: json?['is_email_verified'],
      pendingEmail: json?['pending_email'],
    );
  }

  final String? city;
  final List<WorkLocationModel>? locations;
  final String? website;
  final String? bio;
  final int? employeesCount;
  final String? establishmentDate;
  final ImageResourceModel? profileImage;
  final bool? isFollowed;
  final bool? hasApplied;
  final bool? isSubscribed;
  final List<SpecializationModel>? specializations;
  final List<ImageResourceModel>? images;
  final bool? isEmailVerified;
  final String? pendingEmail;

  CompanyDetailsModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? secondaryPhone,
    String? email,
    String? city,
    List<WorkLocationModel>? locations,
    String? website,
    String? bio,
    int? employeesCount,
    String? establishmentDate,
    ImageResourceModel? profileImage,
    List<ImageResourceModel>? images,
    bool? isFollowed,
    bool? isSubscribed,
    bool? hasApplied,
    bool? isEmailVerified,
    String? pendingEmail,
    List<SpecializationModel>? specializations,
  }) =>
      CompanyDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        email: email ?? this.email,
        city: city ?? this.city,
        locations: locations ?? this.locations,
        website: website ?? this.website,
        bio: bio ?? this.bio,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        employeesCount: employeesCount ?? this.employeesCount,
        establishmentDate: establishmentDate ?? this.establishmentDate,
        isFollowed: isFollowed ?? this.isFollowed,
        hasApplied: hasApplied ?? this.hasApplied,
        profileImage: profileImage ?? this.profileImage,
        images: images ?? this.images,
        specializations: specializations ?? this.specializations,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        pendingEmail: pendingEmail ?? this.pendingEmail,
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
      'bio': bio,
      "latitude": locations?.firstOrNull?.cordLocation?.latitude,
      "longitude": locations?.firstOrNull?.cordLocation?.longitude,
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
    print(map);
    return map;
  }

  Map<String, String> blankProfileMessages() {
    return {
      if (bio == null || bio?.isBlank == true)
        'bio': "You have not entered a bio for your profile account.",
      if (secondaryPhone == null || secondaryPhone?.isBlank == true)
        'secondary_phone':
            "The profile account does not have an secondary phone number.",
      if (email == null || email?.isBlank == true)
        'email': "The profile account does not have an email address.",
      if (profileImage == null ||
          profileImage?.url == null ||
          profileImage?.url?.isBlank == true)
        'image': "The profile account does not have an image profile.",
      if (website == null || website?.isBlank == true)
        'website': "The profile account does not have website.",
      if (employeesCount == null || employeesCount == 0)
        'employees_count':
            "The profile account does not have an employees count.",
      if (establishmentDate == null || establishmentDate?.isBlank == true)
        'establishment_date':
            "The profile account does not have an establishment date.",
    };
  }

  int get blankProfileMessagesLength => blankProfileMessages().length;

  @override
  String? get locationCity =>
      locations?.firstWhereOrNull((e) => e.isHQ == true)?.locationAddress?.name;

  @override
  AppUsingType get userType => AppUsingType.company;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyDetailsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          phone == other.phone &&
          secondaryPhone == other.secondaryPhone &&
          email == other.email &&
          city == other.city &&
          listEquality(locations, other.locations) &&
          website == other.website &&
          bio == other.bio &&
          employeesCount == other.employeesCount &&
          establishmentDate == other.establishmentDate &&
          profileImage == other.profileImage &&
          isFollowed == other.isFollowed &&
          hasApplied == other.hasApplied &&
          isSubscribed == other.isSubscribed &&
          isEmailVerified == other.isEmailVerified &&
          listEquality(specializations, other.specializations) &&
          listEquality(images, other.images);

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
      profileImage.hashCode ^
      isFollowed.hashCode ^
      hasApplied.hashCode ^
      isEmailVerified.hashCode ^
      isSubscribed.hashCode ^
      specializations.hashCode ^
      images.hashCode;

  @override
  String toString() {
    return 'CompanyResponseDetailsModel{id: $id,name: $name, phone: $phone, secondaryPhone: $secondaryPhone, email: $email, city: $city, images: $images, website: $website, employeesCount: $employeesCount, establishmentDate: $establishmentDate, hasApplied: $hasApplied ,isFollowed: $isFollowed, specializations: $specializations, profileImage: $profileImage, bio: $bio}';
  }
}
