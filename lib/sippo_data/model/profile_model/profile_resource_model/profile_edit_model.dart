import 'package:jobspot/utils/app_use.dart';

import '../../auth_model/entity_model.dart';
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
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) =>
      ProfileInfoModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        secondaryPhone: json["secondary_phone"],
        email: json["email"],
        gender: json['gender'],
        bio: json['bio'],
        cv: json['cv'] != null ? CvModel.fromJson(json['cv']) : null,
      );

  final String? gender;
  final CvModel? cv;
  final String? bio;

  ProfileInfoModel copyWith({
    int? id,
    String? name,
    String? email,
    String? secondaryPhone,
    String? phone,
    String? gender,
    String? bio,
    CvModel? cv,
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
      );

  ProfileInfoModel copyWithRemoveCv({
    int? id,
    String? name,
    String? email,
    String? secondaryPhone,
    String? phone,
    String? gender,
    String? bio,
  }) =>
      ProfileInfoModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        gender: gender ?? this.gender,
        bio: bio ?? this.bio,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'email': email,
        'phone': phone,
        'secondary_phone': secondaryPhone,
        'bio': bio,
      }..removeWhere((_, v) => v == null || (v as String).trim().isEmpty);

  @override
  String? get locationCity => null;

  @override
  AppUsingType get userType => AppUsingType.user;

  @override
  String toString() {
    return 'ProfileInfoModel{id: $id, name: $name, phone: $phone, secondaryPhone: $secondaryPhone, email: $email, gender: $gender, cv: $cv, bio: $bio}';
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
          cv == other.cv &&
          gender == other.gender &&
          bio == other.bio;

  @override
  int get hashCode =>
      super.id.hashCode ^
      super.name.hashCode ^
      super.email.hashCode ^
      super.phone.hashCode ^
      super.secondaryPhone.hashCode ^
      cv.hashCode ^
      gender.hashCode ^
      bio.hashCode;
}
