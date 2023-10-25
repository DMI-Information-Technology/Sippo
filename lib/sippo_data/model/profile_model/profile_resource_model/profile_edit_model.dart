import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';
import 'package:jobspot/utils/app_use.dart';

import 'cv_file_model.dart';

class ProfileInfoModel extends EntityModel {
  ProfileInfoModel({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.secondaryPhone,
    this.gender,
    this.bio,
    this.cv,
    this.profileImage,
    this.isEmailVerified,
    this.pendingEmail,
    this.myLocation,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic>? json) =>
      ProfileInfoModel(
        id: json?["id"],
        name: json?["name"],
        phone: json?["phone"],
        secondaryPhone: json?["secondary_phone"],
        email: json?["email"],
        gender: json?['gender'],
        isEmailVerified: json?['is_email_verified'],
        pendingEmail: json?['pending_email'],
        bio: json?['bio'],
        myLocation: json?['location'] != null
            ? WorkLocationModel.fromJson(json?["location"])
            : null,
        cv: json?['cv'] != null ? CvModel.fromJson(json?['cv']) : null,
        profileImage: json?['profile_image'] != null
            ? ImageResourceModel.fromJson(json?['profile_image'])
            : null,
      );

  final String? gender;
  final CvModel? cv;
  final String? bio;
  final ImageResourceModel? profileImage;
  final bool? isEmailVerified;
  final String? pendingEmail;
  final WorkLocationModel? myLocation;

  ProfileInfoModel copyWith({
    int? id,
    String? name,
    String? email,
    String? secondaryPhone,
    String? phone,
    String? gender,
    String? bio,
    bool? isEmailVerified,
    String? pendingEmail,
    CvModel? cv,
    ImageResourceModel? profileImage,
    WorkLocationModel? locationAddress,
  }) =>
      ProfileInfoModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        gender: gender ?? this.gender,
        bio: bio ?? this.bio,
        cv: cv ?? this.cv,
        profileImage: profileImage ?? this.profileImage,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        pendingEmail: pendingEmail ?? this.pendingEmail,
        myLocation: myLocation ?? this.myLocation,
      );

  bool get pendingEmailIsNotEmpty => pendingEmail?.isNotEmpty == true;

  bool get pendingEmailIsEmpty => pendingEmail?.isEmpty == true;

  ProfileInfoModel copyWithRemoveCv({
    int? id,
    String? name,
    String? email,
    String? secondaryPhone,
    String? phone,
    String? gender,
    String? bio,
    ImageResourceModel? profileImage,
    bool? isEmailVerified,
    String? pendingEmail,
    WorkLocationModel? locationAddress,
  }) =>
      ProfileInfoModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        gender: gender ?? this.gender,
        bio: bio ?? this.bio,
        profileImage: profileImage ?? this.profileImage,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        pendingEmail: pendingEmail ?? this.pendingEmail,
        myLocation: myLocation ?? this.myLocation,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'email': email,
        'phone': phone,
        'secondary_phone': secondaryPhone,
        'bio': bio,
      }..removeWhere((_, v) {
          if (v == null) return true;
          if (v is String && v.isEmpty) return true;
          return false;
        });

  @override
  String? get locationCity => myLocation?.locationAddress?.name;

  LocationAddress? get locationAddress => myLocation?.locationAddress?.copyWith();

  @override
  AppUsingType get userType => AppUsingType.user;

  @override
  String toString() {
    return 'ProfileInfoModel{id: $id, name: $name, phone: $phone, secondaryPhone: $secondaryPhone, email: $email, gender: $gender, cv: $cv, profileImage: $profileImage, bio: $bio}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileInfoModel &&
          runtimeType == other.runtimeType &&
          super.id == other.id &&
          super.name == other.name &&
          super.email == other.email &&
          super.phone == other.phone &&
          super.secondaryPhone == other.secondaryPhone &&
          profileImage == other.profileImage &&
          cv == other.cv &&
          gender == other.gender &&
          isEmailVerified == other.isEmailVerified &&
          pendingEmail == other.pendingEmail &&
          locationAddress == other.locationAddress &&
          bio == other.bio;

  @override
  int get hashCode =>
      super.id.hashCode ^
      super.name.hashCode ^
      super.email.hashCode ^
      super.phone.hashCode ^
      super.secondaryPhone.hashCode ^
      cv.hashCode ^
      profileImage.hashCode ^
      gender.hashCode ^
      isEmailVerified.hashCode ^
      pendingEmail.hashCode ^
      locationAddress.hashCode ^
      bio.hashCode;
}
